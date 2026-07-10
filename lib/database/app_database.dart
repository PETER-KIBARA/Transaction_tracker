import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';

import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'database_tables.dart';
import 'package:transaction_tracker/features/sms/domain/entities/sms_transaction_entity.dart';

part 'app_database.g.dart';

/// Main database class using Drift ORM
@DriftDatabase(tables: [SmsTransactions, Categories, AnalyticsCache])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  /// In-memory/test executor constructor. Production always uses the
  /// application-documents database above.
  AppDatabase.forTesting(QueryExecutor executor) : super(executor);

  @override
  int get schemaVersion => 3;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onUpgrade: (m, from, to) async {
      if (from < 2) {
        await m.addColumn(smsTransactions, smsTransactions.provider);
        await m.addColumn(smsTransactions, smsTransactions.transactionCost);
      }
      if (from < 3) {
        await _backfillTransactionProviders();
      }
    },
  );

  Future<void> _backfillTransactionProviders() async {
    final transactions = await select(smsTransactions).get();
    await batch((batch) {
      for (final transaction in transactions) {
        final provider = detectTransactionProvider(
          sender: transaction.sender,
          messageBody: transaction.messageBody,
        );
        batch.update(
          smsTransactions,
          SmsTransactionsCompanion(provider: Value(provider.name)),
          where: (table) => table.id.equals(transaction.id),
        );
      }
    });
  }

  // --- SMS Transactions Queries ---

  /// Insert a new SMS transaction
  Future<void> insertSmsTransaction(SmsTransactionsCompanion transaction) {
    return into(
      smsTransactions,
    ).insert(transaction, mode: InsertMode.insertOrIgnore);
  }

  /// Insert multiple SMS transactions
  Future<void> insertMultipleSmsTransactions(
    List<SmsTransactionsCompanion> transactions,
  ) {
    return batch((batch) {
      batch.insertAll(
        smsTransactions,
        transactions,
        mode: InsertMode.insertOrIgnore,
      );
    });
  }

  /// Get all SMS transactions
  Future<List<SmsTransaction>> getAllSmsTransactions() {
    return select(smsTransactions).get();
  }

  /// Get SMS transactions paginated
  Future<List<SmsTransaction>> getSmsTransactionsPaginated(
    int offset,
    int limit,
  ) {
    return (select(smsTransactions)
          ..orderBy([
            (t) => OrderingTerm(
              expression: t.transactionDate,
              mode: OrderingMode.desc,
            ),
          ])
          ..limit(limit, offset: offset))
        .get();
  }

  /// Get SMS transactions by category
  Future<List<SmsTransaction>> getSmsTransactionsByCategory(String category) {
    return (select(smsTransactions)
          ..where((t) => t.category.equals(category))
          ..orderBy([
            (t) => OrderingTerm(
              expression: t.transactionDate,
              mode: OrderingMode.desc,
            ),
          ]))
        .get();
  }

  /// Get SMS transactions by date range
  Future<List<SmsTransaction>> getSmsTransactionsByDateRange(
    DateTime startDate,
    DateTime endDate,
  ) {
    return (select(smsTransactions)
          ..where(
            (t) =>
                t.transactionDate.isBiggerOrEqualValue(startDate) &
                t.transactionDate.isSmallerOrEqualValue(endDate),
          )
          ..orderBy([
            (t) => OrderingTerm(
              expression: t.transactionDate,
              mode: OrderingMode.desc,
            ),
          ]))
        .get();
  }

  /// Search SMS transactions
  Future<List<SmsTransaction>> searchSmsTransactions(String query) {
    return (select(smsTransactions)..where(
          (t) =>
              t.sender.like('%$query%') |
              t.messageBody.like('%$query%') |
              t.referenceNumber.like('%$query%'),
        ))
        .get();
  }

  /// Get SMS transactions by type
  Future<List<SmsTransaction>> getSmsTransactionsByType(String type) {
    return (select(smsTransactions)
          ..where((t) => t.transactionType.equals(type))
          ..orderBy([
            (t) => OrderingTerm(
              expression: t.transactionDate,
              mode: OrderingMode.desc,
            ),
          ]))
        .get();
  }

  Future<List<SmsTransaction>> getSmsTransactionsByProvider(String provider) {
    return (select(smsTransactions)
          ..where((t) => t.provider.equals(provider))
          ..orderBy([
            (t) => OrderingTerm(
              expression: t.transactionDate,
              mode: OrderingMode.desc,
            ),
          ]))
        .get();
  }

  /// Computes all dashboard values in one grouped database query. Keeping the
  /// aggregation in SQLite avoids loading every transaction into Dart memory.
  Future<List<DashboardAggregate>> getDashboardAggregates() async {
    final result = await customSelect(
      '''
        SELECT provider,
               COUNT(*) AS transaction_count,
               COALESCE(SUM(CASE
                 WHEN LOWER(transaction_type) IN ('deposit', 'paid in')
                 THEN amount ELSE 0 END), 0) AS money_in,
               COALESCE(SUM(CASE
                 WHEN LOWER(transaction_type) IN ('deposit', 'paid in')
                 THEN 0 ELSE amount END), 0) AS money_out,
               COALESCE(SUM(transaction_cost), 0) AS transaction_costs
        FROM sms_transactions
        GROUP BY provider
      ''',
      readsFrom: {smsTransactions},
    ).get();
    return result
        .map(
          (row) => DashboardAggregate(
            provider: row.read<String>('provider'),
            count: row.read<int>('transaction_count'),
            moneyIn: row.read<double>('money_in'),
            moneyOut: row.read<double>('money_out'),
            transactionCosts: row.read<double>('transaction_costs'),
          ),
        )
        .toList();
  }

  /// Get total count of SMS transactions
  Future<int> getSmsTransactionCount() {
    return (select(smsTransactions)).get().then((txns) => txns.length);
  }

  Future<bool> deleteSmsTransaction(String id) {
    return (delete(
      smsTransactions,
    )..where((t) => t.id.equals(id))).go().then((v) => v > 0);
  }

  /// Delete all SMS transactions
  Future<void> deleteAllSmsTransactions() {
    return delete(smsTransactions).go();
  }

  Future<bool> updateSmsTransaction(SmsTransactionsCompanion transaction) {
    return update(smsTransactions).replace(transaction);
  }

  /// Get transaction statistics
  Future<Map<String, dynamic>> getTransactionStatistics(
    DateTime startDate,
    DateTime endDate,
  ) async {
    final transactions = await getSmsTransactionsByDateRange(
      startDate,
      endDate,
    );

    double totalIncome = 0;
    double totalExpenses = 0;

    for (final txn in transactions) {
      if (txn.transactionType.toLowerCase().contains('deposit') ||
          txn.transactionType.toLowerCase().contains('transfer to')) {
        totalIncome += txn.amount;
      } else {
        totalExpenses += txn.amount;
      }
    }

    return {
      'totalIncome': totalIncome,
      'totalExpenses': totalExpenses,
      'savings': totalIncome - totalExpenses,
      'transactionCount': transactions.length,
    };
  }

  // --- Categories Queries ---

  /// Insert a new category
  Future<int> insertCategory(CategoriesCompanion category) {
    return into(categories).insert(category);
  }

  /// Get all categories
  Future<List<Category>> getAllCategories() {
    return select(categories).get();
  }

  /// Get category by ID
  Future<Category?> getCategoryById(int id) {
    return (select(
      categories,
    )..where((t) => t.id.equals(id))).getSingleOrNull();
  }

  Future<bool> deleteCategory(int id) {
    return (delete(
      categories,
    )..where((t) => t.id.equals(id))).go().then((v) => v > 0);
  }

  /// Update category
  Future<bool> updateCategory(CategoriesCompanion category) {
    return update(categories).replace(category);
  }

  // --- Analytics Cache Queries ---

  /// Insert or update analytics cache
  Future<void> upsertAnalyticsCache(AnalyticsCacheCompanion cache) {
    return into(
      analyticsCache,
    ).insert(cache, onConflict: DoUpdate((_) => cache));
  }

  /// Get analytics for month
  Future<AnalyticsCacheData?> getAnalyticsByMonth(DateTime month) {
    final startOfMonth = DateTime(month.year, month.month, 1);
    return (select(
      analyticsCache,
    )..where((t) => t.month.equals(startOfMonth))).getSingleOrNull();
  }

  /// Get all analytics cached
  Future<List<AnalyticsCacheData>> getAllAnalytics() {
    return select(analyticsCache).get();
  }

  /// Delete old analytics cache
  Future<void> deleteOldAnalyticsCache(DateTime beforeDate) {
    return (delete(
      analyticsCache,
    )..where((t) => t.month.isSmallerThanValue(beforeDate))).go();
  }
}

class DashboardAggregate {
  const DashboardAggregate({
    required this.provider,
    required this.count,
    required this.moneyIn,
    required this.moneyOut,
    required this.transactionCosts,
  });

  final String provider;
  final int count;
  final double moneyIn;
  final double moneyOut;
  final double transactionCosts;
}

/// Open database connection
LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'sms_transactions.db'));
    return NativeDatabase.createInBackground(file);
  });
}
