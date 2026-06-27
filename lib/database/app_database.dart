import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';

import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'database_tables.dart';

part 'app_database.g.dart';

/// Main database class using Drift ORM
@DriftDatabase(tables: [SmsTransactions, Categories, AnalyticsCache])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  // --- SMS Transactions Queries ---

  /// Insert a new SMS transaction
  Future<void> insertSmsTransaction(SmsTransactionsCompanion transaction) {
    return into(smsTransactions).insert(transaction);
  }

  /// Insert multiple SMS transactions
  Future<void> insertMultipleSmsTransactions(List<SmsTransactionsCompanion> transactions) {
    return batch((batch) {
      batch.insertAll(smsTransactions, transactions);
    });
  }

  /// Get all SMS transactions
  Future<List<SmsTransaction>> getAllSmsTransactions() {
    return select(smsTransactions).get();
  }

  /// Get SMS transactions paginated
  Future<List<SmsTransaction>> getSmsTransactionsPaginated(int offset, int limit) {
    return (select(smsTransactions)
          ..orderBy([(t) => OrderingTerm(expression: t.transactionDate, mode: OrderingMode.desc)])
          ..limit(limit, offset: offset))
        .get();
  }

  /// Get SMS transactions by category
  Future<List<SmsTransaction>> getSmsTransactionsByCategory(String category) {
    return (select(smsTransactions)
          ..where((t) => t.category.equals(category))
          ..orderBy([(t) => OrderingTerm(expression: t.transactionDate, mode: OrderingMode.desc)]))
        .get();
  }

  /// Get SMS transactions by date range
  Future<List<SmsTransaction>> getSmsTransactionsByDateRange(DateTime startDate, DateTime endDate) {
    return (select(smsTransactions)
          ..where((t) =>
              t.transactionDate.isBiggerOrEqualValue(startDate) &
              t.transactionDate.isSmallerOrEqualValue(endDate))
          ..orderBy([(t) => OrderingTerm(expression: t.transactionDate, mode: OrderingMode.desc)]))
        .get();
  }

  /// Search SMS transactions
  Future<List<SmsTransaction>> searchSmsTransactions(String query) {
    return (select(smsTransactions)
          ..where((t) =>
              t.sender.like('%$query%') |
              t.messageBody.like('%$query%') |
              t.referenceNumber.like('%$query%')))
        .get();
  }

  /// Get SMS transactions by type
  Future<List<SmsTransaction>> getSmsTransactionsByType(String type) {
    return (select(smsTransactions)
          ..where((t) => t.transactionType.equals(type))
          ..orderBy([(t) => OrderingTerm(expression: t.transactionDate, mode: OrderingMode.desc)]))
        .get();
  }

  /// Get total count of SMS transactions
  Future<int> getSmsTransactionCount() {
    return (select(smsTransactions)).get().then((txns) => txns.length);
  }

  Future<bool> deleteSmsTransaction(String id) {
    return (delete(smsTransactions)..where((t) => t.id.equals(id))).go().then((v) => v > 0);
  }

  /// Delete all SMS transactions
  Future<void> deleteAllSmsTransactions() {
    return delete(smsTransactions).go();
  }

  Future<bool> updateSmsTransaction(SmsTransactionsCompanion transaction) {
    return update(smsTransactions).replace(transaction);
  }

  /// Get transaction statistics
  Future<Map<String, dynamic>> getTransactionStatistics(DateTime startDate, DateTime endDate) async {
    final transactions = await getSmsTransactionsByDateRange(startDate, endDate);

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
    return (select(categories)..where((t) => t.id.equals(id))).getSingleOrNull();
  }

  Future<bool> deleteCategory(int id) {
    return (delete(categories)..where((t) => t.id.equals(id))).go().then((v) => v > 0);
  }

  /// Update category
  Future<bool> updateCategory(CategoriesCompanion category) {
    return update(categories).replace(category);
  }

  // --- Analytics Cache Queries ---

  /// Insert or update analytics cache
  Future<void> upsertAnalyticsCache(AnalyticsCacheCompanion cache) {
    return into(analyticsCache).insert(cache, onConflict: DoUpdate((_) => cache));
  }

  /// Get analytics for month
  Future<AnalyticsCacheData?> getAnalyticsByMonth(DateTime month) {
    final startOfMonth = DateTime(month.year, month.month, 1);
    return (select(analyticsCache)..where((t) => t.month.equals(startOfMonth))).getSingleOrNull();
  }

  /// Get all analytics cached
  Future<List<AnalyticsCacheData>> getAllAnalytics() {
    return select(analyticsCache).get();
  }

  /// Delete old analytics cache
  Future<void> deleteOldAnalyticsCache(DateTime beforeDate) {
    return (delete(analyticsCache)..where((t) => t.month.isSmallerThanValue(beforeDate))).go();
  }
}

/// Open database connection
LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'sms_transactions.db'));
    return NativeDatabase.createInBackground(file);
  });
}