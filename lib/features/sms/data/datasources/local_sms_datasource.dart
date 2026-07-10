import 'package:drift/drift.dart';
import 'package:transaction_tracker/core/errors/exceptions.dart';
import 'package:transaction_tracker/database/app_database.dart';
import 'package:transaction_tracker/features/sms/data/models/sms_transaction_model.dart';
import 'package:transaction_tracker/features/sms/domain/entities/sms_transaction_entity.dart';
import 'package:transaction_tracker/features/sms/domain/entities/dashboard_summary.dart';

/// Local data source for SMS transactions using Drift
abstract class LocalSmsDataSource {
  Future<void> insertTransaction(SmsTransactionModel model);
  Future<void> insertMultipleTransactions(List<SmsTransactionModel> models);
  Future<List<SmsTransactionModel>> getAllTransactions();
  Future<List<SmsTransactionModel>> getTransactionsPaginated(
    int offset,
    int limit,
  );
  Future<List<SmsTransactionModel>> getTransactionsByCategory(String category);
  Future<List<SmsTransactionModel>> getTransactionsByDateRange(
    DateTime startDate,
    DateTime endDate,
  );
  Future<List<SmsTransactionModel>> searchTransactions(String query);
  Future<List<SmsTransactionModel>> getTransactionsByType(String type);
  Future<List<SmsTransactionModel>> getTransactionsByProvider(String provider);
  Future<DashboardSummary> getDashboardSummary();
  Future<int> getTransactionCount();
  Future<void> deleteTransaction(String id);
  Future<void> deleteAllTransactions();
  Future<void> updateTransaction(SmsTransactionModel model);
  Future<Map<String, dynamic>> getStatistics(
    DateTime startDate,
    DateTime endDate,
  );
}

/// Implementation of LocalSmsDataSource
class LocalSmsDataSourceImpl implements LocalSmsDataSource {
  final AppDatabase _database;

  LocalSmsDataSourceImpl(this._database);

  @override
  Future<void> insertTransaction(SmsTransactionModel model) async {
    try {
      await _database.insertSmsTransaction(
        SmsTransactionsCompanion(
          id: Value(model.id),
          sender: Value(model.sender),
          messageBody: Value(model.messageBody),
          amount: Value(model.amount),
          transactionType: Value(model.transactionType),
          category: Value(model.category),
          transactionDate: Value(model.transactionDate),
          provider: Value(model.provider.name),
          transactionCost: Value(model.transactionCost),
          balance: Value(model.balance),
          referenceNumber: Value(model.referenceNumber),
          createdAt: Value(model.createdAt),
        ),
      );
    } catch (e) {
      throw DatabaseException('Failed to insert transaction: $e');
    }
  }

  @override
  Future<void> insertMultipleTransactions(
    List<SmsTransactionModel> models,
  ) async {
    try {
      final companions = models
          .map(
            (model) => SmsTransactionsCompanion(
              id: Value(model.id),
              sender: Value(model.sender),
              messageBody: Value(model.messageBody),
              amount: Value(model.amount),
              transactionType: Value(model.transactionType),
              category: Value(model.category),
              transactionDate: Value(model.transactionDate),
              provider: Value(model.provider.name),
              transactionCost: Value(model.transactionCost),
              balance: Value(model.balance),
              referenceNumber: Value(model.referenceNumber),
              createdAt: Value(model.createdAt),
            ),
          )
          .toList();

      await _database.insertMultipleSmsTransactions(companions);
    } catch (e) {
      throw DatabaseException('Failed to insert multiple transactions: $e');
    }
  }

  @override
  Future<List<SmsTransactionModel>> getAllTransactions() async {
    try {
      final transactions = await _database.getAllSmsTransactions();
      return transactions.map(_fromDatabase).toList();
    } catch (e) {
      throw DatabaseException('Failed to get all transactions: $e');
    }
  }

  @override
  Future<List<SmsTransactionModel>> getTransactionsPaginated(
    int offset,
    int limit,
  ) async {
    try {
      final transactions = await _database.getSmsTransactionsPaginated(
        offset,
        limit,
      );
      return transactions.map(_fromDatabase).toList();
    } catch (e) {
      throw DatabaseException('Failed to get paginated transactions: $e');
    }
  }

  @override
  Future<List<SmsTransactionModel>> getTransactionsByCategory(
    String category,
  ) async {
    try {
      final transactions = await _database.getSmsTransactionsByCategory(
        category,
      );
      return transactions.map(_fromDatabase).toList();
    } catch (e) {
      throw DatabaseException('Failed to get transactions by category: $e');
    }
  }

  @override
  Future<List<SmsTransactionModel>> getTransactionsByDateRange(
    DateTime startDate,
    DateTime endDate,
  ) async {
    try {
      final transactions = await _database.getSmsTransactionsByDateRange(
        startDate,
        endDate,
      );
      return transactions.map(_fromDatabase).toList();
    } catch (e) {
      throw DatabaseException('Failed to get transactions by date range: $e');
    }
  }

  @override
  Future<List<SmsTransactionModel>> searchTransactions(String query) async {
    try {
      final transactions = await _database.searchSmsTransactions(query);
      return transactions.map(_fromDatabase).toList();
    } catch (e) {
      throw DatabaseException('Failed to search transactions: $e');
    }
  }

  @override
  Future<List<SmsTransactionModel>> getTransactionsByType(String type) async {
    try {
      final transactions = await _database.getSmsTransactionsByType(type);
      return transactions.map(_fromDatabase).toList();
    } catch (e) {
      throw DatabaseException('Failed to get transactions by type: $e');
    }
  }

  @override
  Future<List<SmsTransactionModel>> getTransactionsByProvider(
    String provider,
  ) async {
    try {
      final transactions = await _database.getSmsTransactionsByProvider(
        provider,
      );
      return transactions.map(_fromDatabase).toList();
    } catch (e) {
      throw DatabaseException('Failed to get transactions by provider: $e');
    }
  }

  SmsTransactionModel _fromDatabase(SmsTransaction txn) => SmsTransactionModel(
    id: txn.id,
    sender: txn.sender,
    messageBody: txn.messageBody,
    amount: txn.amount,
    transactionType: txn.transactionType,
    category: txn.category,
    transactionDate: txn.transactionDate,
    provider: TransactionProvider.values.firstWhere(
      (provider) => provider.name == txn.provider,
      orElse: () => TransactionProvider.unknown,
    ),
    transactionCost: txn.transactionCost,
    balance: txn.balance,
    referenceNumber: txn.referenceNumber,
    createdAt: txn.createdAt,
  );

  @override
  Future<DashboardSummary> getDashboardSummary() async {
    try {
      final aggregates = await _database.getDashboardAggregates();
      final summaries = {
        for (final provider in TransactionProvider.values)
          provider: ProviderSummary(provider: provider),
      };
      var earnings = 0.0;
      var expenses = 0.0;
      var transactionCosts = 0.0;
      for (final aggregate in aggregates) {
        final provider = TransactionProvider.values.firstWhere(
          (value) => value.name == aggregate.provider,
          orElse: () => TransactionProvider.unknown,
        );
        summaries[provider] = ProviderSummary(
          provider: provider,
          count: aggregate.count,
          moneyIn: aggregate.moneyIn,
          moneyOut: aggregate.moneyOut,
        );
        earnings += aggregate.moneyIn;
        expenses += aggregate.moneyOut;
        transactionCosts += aggregate.transactionCosts;
      }
      return DashboardSummary(
        totalEarnings: earnings,
        totalExpenses: expenses,
        totalTransactionCosts: transactionCosts,
        providers: summaries,
      );
    } catch (e) {
      throw DatabaseException('Failed to aggregate dashboard summary: $e');
    }
  }

  @override
  Future<int> getTransactionCount() async {
    try {
      return await _database.getSmsTransactionCount();
    } catch (e) {
      throw DatabaseException('Failed to get transaction count: $e');
    }
  }

  @override
  Future<void> deleteTransaction(String id) async {
    try {
      await _database.deleteSmsTransaction(id);
    } catch (e) {
      throw DatabaseException('Failed to delete transaction: $e');
    }
  }

  @override
  Future<void> deleteAllTransactions() async {
    try {
      await _database.deleteAllSmsTransactions();
    } catch (e) {
      throw DatabaseException('Failed to delete all transactions: $e');
    }
  }

  @override
  Future<void> updateTransaction(SmsTransactionModel model) async {
    try {
      await _database.updateSmsTransaction(
        SmsTransactionsCompanion(
          id: Value(model.id),
          sender: Value(model.sender),
          messageBody: Value(model.messageBody),
          amount: Value(model.amount),
          transactionType: Value(model.transactionType),
          category: Value(model.category),
          transactionDate: Value(model.transactionDate),
          provider: Value(model.provider.name),
          transactionCost: Value(model.transactionCost),
          balance: Value(model.balance),
          referenceNumber: Value(model.referenceNumber),
          createdAt: Value(model.createdAt),
        ),
      );
    } catch (e) {
      throw DatabaseException('Failed to update transaction: $e');
    }
  }

  @override
  Future<Map<String, dynamic>> getStatistics(
    DateTime startDate,
    DateTime endDate,
  ) async {
    try {
      return await _database.getTransactionStatistics(startDate, endDate);
    } catch (e) {
      throw DatabaseException('Failed to get statistics: $e');
    }
  }
}
