import 'package:transaction_tracker/features/sms/domain/entities/sms_transaction_entity.dart';

/// Repository interface for SMS transactions
abstract class SmsTransactionRepository {
  /// Get all SMS transactions
  Future<List<SmsTransactionEntity>> getAllTransactions();

  /// Get SMS transactions paginated
  Future<List<SmsTransactionEntity>> getTransactionsPaginated(int page, int pageSize);

  /// Get transactions by category
  Future<List<SmsTransactionEntity>> getTransactionsByCategory(String category);

  /// Get transactions by date range
  Future<List<SmsTransactionEntity>> getTransactionsByDateRange(
    DateTime startDate,
    DateTime endDate,
  );

  /// Search transactions
  Future<List<SmsTransactionEntity>> searchTransactions(String query);

  /// Get transactions by type
  Future<List<SmsTransactionEntity>> getTransactionsByType(String type);

  /// Get transaction count
  Future<int> getTransactionCount();

  /// Add a transaction
  Future<void> addTransaction(SmsTransactionEntity transaction);

  /// Add multiple transactions
  Future<void> addMultipleTransactions(List<SmsTransactionEntity> transactions);

  /// Delete transaction
  Future<void> deleteTransaction(String id);

  /// Delete all transactions
  Future<void> deleteAllTransactions();

  /// Update transaction
  Future<void> updateTransaction(SmsTransactionEntity transaction);

  /// Get statistics
  Future<Map<String, dynamic>> getStatistics(DateTime startDate, DateTime endDate);
}
