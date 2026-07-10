import 'package:transaction_tracker/core/errors/exceptions.dart';
import 'package:transaction_tracker/features/sms/data/datasources/local_sms_datasource.dart';
import 'package:transaction_tracker/features/sms/data/models/sms_transaction_model.dart';
import 'package:transaction_tracker/features/sms/domain/entities/sms_transaction_entity.dart';
import 'package:transaction_tracker/features/sms/domain/entities/dashboard_summary.dart';
import 'package:transaction_tracker/features/sms/domain/repositories/sms_transaction_repository.dart';

/// Implementation of SmsTransactionRepository
class SmsTransactionRepositoryImpl implements SmsTransactionRepository {
  final LocalSmsDataSource _localDataSource;

  SmsTransactionRepositoryImpl(this._localDataSource);

  @override
  Future<void> addMultipleTransactions(
    List<SmsTransactionEntity> transactions,
  ) async {
    try {
      final models = transactions
          .map((txn) => SmsTransactionModel.fromEntity(txn))
          .toList();
      await _localDataSource.insertMultipleTransactions(models);
    } on DatabaseException {
      throw RepositoryException('Failed to add multiple transactions');
    } catch (e) {
      throw RepositoryException('Unexpected error adding transactions: $e');
    }
  }

  @override
  Future<void> addTransaction(SmsTransactionEntity transaction) async {
    try {
      final model = SmsTransactionModel.fromEntity(transaction);
      await _localDataSource.insertTransaction(model);
    } on DatabaseException {
      throw RepositoryException('Failed to add transaction');
    } catch (e) {
      throw RepositoryException('Unexpected error adding transaction: $e');
    }
  }

  @override
  Future<void> deleteAllTransactions() async {
    try {
      await _localDataSource.deleteAllTransactions();
    } on DatabaseException {
      throw RepositoryException('Failed to delete all transactions');
    } catch (e) {
      throw RepositoryException(
        'Unexpected error deleting all transactions: $e',
      );
    }
  }

  @override
  Future<void> deleteTransaction(String id) async {
    try {
      await _localDataSource.deleteTransaction(id);
    } on DatabaseException {
      throw RepositoryException('Failed to delete transaction');
    } catch (e) {
      throw RepositoryException('Unexpected error deleting transaction: $e');
    }
  }

  @override
  Future<List<SmsTransactionEntity>> getAllTransactions() async {
    try {
      final models = await _localDataSource.getAllTransactions();
      return models.map((model) => model.toEntity()).toList();
    } on DatabaseException {
      throw RepositoryException('Failed to get all transactions');
    } catch (e) {
      throw RepositoryException('Unexpected error getting transactions: $e');
    }
  }

  @override
  Future<List<SmsTransactionEntity>> getTransactionsByCategory(
    String category,
  ) async {
    try {
      final models = await _localDataSource.getTransactionsByCategory(category);
      return models.map((model) => model.toEntity()).toList();
    } on DatabaseException {
      throw RepositoryException('Failed to get transactions by category');
    } catch (e) {
      throw RepositoryException(
        'Unexpected error getting transactions by category: $e',
      );
    }
  }

  @override
  Future<List<SmsTransactionEntity>> getTransactionsByDateRange(
    DateTime startDate,
    DateTime endDate,
  ) async {
    try {
      final models = await _localDataSource.getTransactionsByDateRange(
        startDate,
        endDate,
      );
      return models.map((model) => model.toEntity()).toList();
    } on DatabaseException {
      throw RepositoryException('Failed to get transactions by date range');
    } catch (e) {
      throw RepositoryException(
        'Unexpected error getting transactions by date range: $e',
      );
    }
  }

  @override
  Future<List<SmsTransactionEntity>> getTransactionsByType(String type) async {
    try {
      final models = await _localDataSource.getTransactionsByType(type);
      return models.map((model) => model.toEntity()).toList();
    } on DatabaseException {
      throw RepositoryException('Failed to get transactions by type');
    } catch (e) {
      throw RepositoryException(
        'Unexpected error getting transactions by type: $e',
      );
    }
  }

  @override
  Future<List<SmsTransactionEntity>> getTransactionsByProvider(
    String provider,
  ) async {
    try {
      final models = await _localDataSource.getTransactionsByProvider(provider);
      return models.map((model) => model.toEntity()).toList();
    } on DatabaseException {
      throw RepositoryException('Failed to get transactions by provider');
    } catch (e) {
      throw RepositoryException(
        'Unexpected error getting transactions by provider: $e',
      );
    }
  }

  @override
  Future<DashboardSummary> getDashboardSummary() async {
    try {
      return await _localDataSource.getDashboardSummary();
    } on DatabaseException {
      throw RepositoryException('Failed to load dashboard summary');
    } catch (e) {
      throw RepositoryException(
        'Unexpected error loading dashboard summary: $e',
      );
    }
  }

  @override
  Future<int> getTransactionCount() async {
    try {
      return await _localDataSource.getTransactionCount();
    } on DatabaseException {
      throw RepositoryException('Failed to get transaction count');
    } catch (e) {
      throw RepositoryException(
        'Unexpected error getting transaction count: $e',
      );
    }
  }

  @override
  Future<List<SmsTransactionEntity>> getTransactionsPaginated(
    int page,
    int pageSize,
  ) async {
    try {
      final offset = (page - 1) * pageSize;
      final models = await _localDataSource.getTransactionsPaginated(
        offset,
        pageSize,
      );
      return models.map((model) => model.toEntity()).toList();
    } on DatabaseException {
      throw RepositoryException('Failed to get paginated transactions');
    } catch (e) {
      throw RepositoryException(
        'Unexpected error getting paginated transactions: $e',
      );
    }
  }

  @override
  Future<List<SmsTransactionEntity>> searchTransactions(String query) async {
    try {
      final models = await _localDataSource.searchTransactions(query);
      return models.map((model) => model.toEntity()).toList();
    } on DatabaseException {
      throw RepositoryException('Failed to search transactions');
    } catch (e) {
      throw RepositoryException('Unexpected error searching transactions: $e');
    }
  }

  @override
  Future<void> updateTransaction(SmsTransactionEntity transaction) async {
    try {
      final model = SmsTransactionModel.fromEntity(transaction);
      await _localDataSource.updateTransaction(model);
    } on DatabaseException {
      throw RepositoryException('Failed to update transaction');
    } catch (e) {
      throw RepositoryException('Unexpected error updating transaction: $e');
    }
  }

  @override
  Future<Map<String, dynamic>> getStatistics(
    DateTime startDate,
    DateTime endDate,
  ) async {
    try {
      return await _localDataSource.getStatistics(startDate, endDate);
    } on DatabaseException {
      throw RepositoryException('Failed to get statistics');
    } catch (e) {
      throw RepositoryException('Unexpected error getting statistics: $e');
    }
  }
}
