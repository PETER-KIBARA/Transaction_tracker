import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:transaction_tracker/core/constants/app_constants.dart';
import 'package:transaction_tracker/database/app_database.dart';
import 'package:transaction_tracker/features/sms/data/datasources/local_sms_datasource.dart';
import 'package:transaction_tracker/features/sms/data/repositories/sms_transaction_repository_impl.dart';
import 'package:transaction_tracker/features/sms/domain/entities/sms_transaction_entity.dart';
import 'package:transaction_tracker/features/sms/domain/repositories/sms_transaction_repository.dart';
import 'package:transaction_tracker/features/sms/domain/usecases/sms_transaction_usecases.dart';

part 'sms_providers.g.dart';

// Database Provider
@riverpod
AppDatabase appDatabase(Ref ref) {
  return AppDatabase();
}

// Data Source Provider
@riverpod
LocalSmsDataSource localSmsDataSource(Ref ref) {
  final database = ref.watch(appDatabaseProvider);
  return LocalSmsDataSourceImpl(database);
}

// Repository Provider
@riverpod
SmsTransactionRepository smsTransactionRepository(Ref ref) {
  final dataSource = ref.watch(localSmsDataSourceProvider);
  return SmsTransactionRepositoryImpl(dataSource);
}

// Use Cases
@riverpod
GetAllTransactionsUseCase getAllTransactionsUseCase(Ref ref) {
  final repository = ref.watch(smsTransactionRepositoryProvider);
  return GetAllTransactionsUseCase(repository);
}

@riverpod
GetPaginatedTransactionsUseCase getPaginatedTransactionsUseCase(Ref ref) {
  final repository = ref.watch(smsTransactionRepositoryProvider);
  return GetPaginatedTransactionsUseCase(repository);
}

@riverpod
GetTransactionsByCategoryUseCase getTransactionsByCategoryUseCase(Ref ref) {
  final repository = ref.watch(smsTransactionRepositoryProvider);
  return GetTransactionsByCategoryUseCase(repository);
}

@riverpod
GetTransactionsByDateRangeUseCase getTransactionsByDateRangeUseCase(Ref ref) {
  final repository = ref.watch(smsTransactionRepositoryProvider);
  return GetTransactionsByDateRangeUseCase(repository);
}

@riverpod
SearchTransactionsUseCase searchTransactionsUseCase(Ref ref) {
  final repository = ref.watch(smsTransactionRepositoryProvider);
  return SearchTransactionsUseCase(repository);
}

@riverpod
AddTransactionUseCase addTransactionUseCase(Ref ref) {
  final repository = ref.watch(smsTransactionRepositoryProvider);
  return AddTransactionUseCase(repository);
}

@riverpod
AddMultipleTransactionsUseCase addMultipleTransactionsUseCase(Ref ref) {
  final repository = ref.watch(smsTransactionRepositoryProvider);
  return AddMultipleTransactionsUseCase(repository);
}

@riverpod
DeleteTransactionUseCase deleteTransactionUseCase(Ref ref) {
  final repository = ref.watch(smsTransactionRepositoryProvider);
  return DeleteTransactionUseCase(repository);
}

@riverpod
GetStatisticsUseCase getStatisticsUseCase(Ref ref) {
  final repository = ref.watch(smsTransactionRepositoryProvider);
  return GetStatisticsUseCase(repository);
}

@riverpod
GetTransactionCountUseCase getTransactionCountUseCase(Ref ref) {
  final repository = ref.watch(smsTransactionRepositoryProvider);
  return GetTransactionCountUseCase(repository);
}

// State Providers

@riverpod
Future<List<SmsTransactionEntity>> allTransactions(Ref ref) async {
  final useCase = ref.watch(getAllTransactionsUseCaseProvider);
  return useCase();
}

@riverpod
Future<List<SmsTransactionEntity>> paginatedTransactions(
  Ref ref, {
  required int page,
}) async {
  final useCase = ref.watch(getPaginatedTransactionsUseCaseProvider);
  return useCase(page, AppConstants.pageSize);
}

@riverpod
Future<List<SmsTransactionEntity>> transactionsByCategory(
  Ref ref, {
  required String category,
}) async {
  final useCase = ref.watch(getTransactionsByCategoryUseCaseProvider);
  return useCase(category);
}

@riverpod
Future<List<SmsTransactionEntity>> transactionsByDateRange(
  Ref ref, {
  required DateTime startDate,
  required DateTime endDate,
}) async {
  final useCase = ref.watch(getTransactionsByDateRangeUseCaseProvider);
  return useCase(startDate, endDate);
}

@riverpod
Future<List<SmsTransactionEntity>> searchedTransactions(
  Ref ref, {
  required String query,
}) async {
  if (query.isEmpty) {
    return [];
  }
  final useCase = ref.watch(searchTransactionsUseCaseProvider);
  return useCase(query);
}

@riverpod
Future<int> transactionCount(Ref ref) async {
  final useCase = ref.watch(getTransactionCountUseCaseProvider);
  return useCase();
}

@riverpod
Future<Map<String, dynamic>> monthlyStatistics(
  Ref ref, {
  required DateTime startDate,
  required DateTime endDate,
}) async {
  final useCase = ref.watch(getStatisticsUseCaseProvider);
  return useCase(startDate, endDate);
}

// State notifier for managing filter state
@riverpod
class SelectedCategory extends _$SelectedCategory {
  @override
  String build() => '';

  void updateCategory(String category) {
    state = category;
  }

  void clearCategory() {
    state = '';
  }
}

// Search query state
@riverpod
class SearchQuery extends _$SearchQuery {
  @override
  String build() => '';

  void updateQuery(String query) {
    state = query;
  }

  void clearQuery() {
    state = '';
  }
}
