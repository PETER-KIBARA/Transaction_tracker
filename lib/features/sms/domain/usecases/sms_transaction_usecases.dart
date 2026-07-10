import 'package:transaction_tracker/features/sms/domain/entities/sms_transaction_entity.dart';
import 'package:transaction_tracker/features/sms/domain/entities/dashboard_summary.dart';
import 'package:transaction_tracker/features/sms/domain/repositories/sms_transaction_repository.dart';

/// Use case for fetching all transactions
class GetAllTransactionsUseCase {
  final SmsTransactionRepository _repository;

  GetAllTransactionsUseCase(this._repository);

  Future<List<SmsTransactionEntity>> call() {
    return _repository.getAllTransactions();
  }
}

/// Use case for fetching transactions with pagination
class GetPaginatedTransactionsUseCase {
  final SmsTransactionRepository _repository;

  GetPaginatedTransactionsUseCase(this._repository);

  Future<List<SmsTransactionEntity>> call(int page, int pageSize) {
    return _repository.getTransactionsPaginated(page, pageSize);
  }
}

/// Use case for fetching transactions by category
class GetTransactionsByCategoryUseCase {
  final SmsTransactionRepository _repository;

  GetTransactionsByCategoryUseCase(this._repository);

  Future<List<SmsTransactionEntity>> call(String category) {
    return _repository.getTransactionsByCategory(category);
  }
}

class GetTransactionsByProviderUseCase {
  GetTransactionsByProviderUseCase(this._repository);
  final SmsTransactionRepository _repository;

  Future<List<SmsTransactionEntity>> call(String provider) =>
      _repository.getTransactionsByProvider(provider);
}

class GetDashboardSummaryUseCase {
  GetDashboardSummaryUseCase(this._repository);
  final SmsTransactionRepository _repository;

  Future<DashboardSummary> call() => _repository.getDashboardSummary();
}

/// Use case for fetching transactions by date range
class GetTransactionsByDateRangeUseCase {
  final SmsTransactionRepository _repository;

  GetTransactionsByDateRangeUseCase(this._repository);

  Future<List<SmsTransactionEntity>> call(
    DateTime startDate,
    DateTime endDate,
  ) {
    return _repository.getTransactionsByDateRange(startDate, endDate);
  }
}

/// Use case for searching transactions
class SearchTransactionsUseCase {
  final SmsTransactionRepository _repository;

  SearchTransactionsUseCase(this._repository);

  Future<List<SmsTransactionEntity>> call(String query) {
    return _repository.searchTransactions(query);
  }
}

/// Use case for adding a transaction
class AddTransactionUseCase {
  final SmsTransactionRepository _repository;

  AddTransactionUseCase(this._repository);

  Future<void> call(SmsTransactionEntity transaction) {
    return _repository.addTransaction(transaction);
  }
}

/// Use case for adding multiple transactions
class AddMultipleTransactionsUseCase {
  final SmsTransactionRepository _repository;

  AddMultipleTransactionsUseCase(this._repository);

  Future<void> call(List<SmsTransactionEntity> transactions) {
    return _repository.addMultipleTransactions(transactions);
  }
}

/// Use case for deleting a transaction
class DeleteTransactionUseCase {
  final SmsTransactionRepository _repository;

  DeleteTransactionUseCase(this._repository);

  Future<void> call(String id) {
    return _repository.deleteTransaction(id);
  }
}

/// Use case for getting statistics
class GetStatisticsUseCase {
  final SmsTransactionRepository _repository;

  GetStatisticsUseCase(this._repository);

  Future<Map<String, dynamic>> call(DateTime startDate, DateTime endDate) {
    return _repository.getStatistics(startDate, endDate);
  }
}

/// Use case for getting transaction count
class GetTransactionCountUseCase {
  final SmsTransactionRepository _repository;

  GetTransactionCountUseCase(this._repository);

  Future<int> call() {
    return _repository.getTransactionCount();
  }
}
