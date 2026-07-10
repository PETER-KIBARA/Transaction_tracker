import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:transaction_tracker/features/sms/domain/entities/sms_transaction_entity.dart';
import 'package:transaction_tracker/features/sms/domain/repositories/sms_transaction_repository.dart';
import 'package:transaction_tracker/features/sms/domain/usecases/sms_transaction_usecases.dart';

class MockSmsTransactionRepository extends Mock
    implements SmsTransactionRepository {}

void main() {
  late MockSmsTransactionRepository mockRepository;

  setUp(() {
    mockRepository = MockSmsTransactionRepository();
  });

  group('SMS Transaction Use Cases', () {
    test('GetAllTransactionsUseCase returns list of transactions', () async {
      // Arrange
      const mockTransactions = <SmsTransactionEntity>[];
      when(
        () => mockRepository.getAllTransactions(),
      ).thenAnswer((_) async => mockTransactions);

      final useCase = GetAllTransactionsUseCase(mockRepository);

      // Act
      final result = await useCase();

      // Assert
      expect(result, mockTransactions);
      verify(() => mockRepository.getAllTransactions()).called(1);
    });

    test('GetTransactionCountUseCase returns count', () async {
      // Arrange
      when(
        () => mockRepository.getTransactionCount(),
      ).thenAnswer((_) async => 5);

      final useCase = GetTransactionCountUseCase(mockRepository);

      // Act
      final result = await useCase();

      // Assert
      expect(result, 5);
      verify(() => mockRepository.getTransactionCount()).called(1);
    });

    test('SearchTransactionsUseCase searches transactions', () async {
      // Arrange
      const mockTransactions = <SmsTransactionEntity>[];
      when(
        () => mockRepository.searchTransactions(any()),
      ).thenAnswer((_) async => mockTransactions);

      final useCase = SearchTransactionsUseCase(mockRepository);

      // Act
      final result = await useCase('test');

      // Assert
      expect(result, mockTransactions);
      verify(() => mockRepository.searchTransactions('test')).called(1);
    });

    test('AddTransactionUseCase adds transaction', () async {
      // Arrange
      final transaction = SmsTransactionEntity(
        id: '1',
        sender: 'Bank',
        messageBody: 'Test',
        amount: 1000,
        transactionType: 'Transfer',
        category: 'Transfer',
        transactionDate: DateTime.fromMicrosecondsSinceEpoch(0),
        createdAt: DateTime.fromMicrosecondsSinceEpoch(0),
      );

      when(
        () => mockRepository.addTransaction(any()),
      ).thenAnswer((_) async => {});

      final useCase = AddTransactionUseCase(mockRepository);

      // Act
      await useCase(transaction);

      // Assert
      verify(() => mockRepository.addTransaction(transaction)).called(1);
    });

    test('GetPaginatedTransactionsUseCase returns paginated results', () async {
      // Arrange
      const mockTransactions = <SmsTransactionEntity>[];
      when(
        () => mockRepository.getTransactionsPaginated(any(), any()),
      ).thenAnswer((_) async => mockTransactions);

      final useCase = GetPaginatedTransactionsUseCase(mockRepository);

      // Act
      final result = await useCase(1, 20);

      // Assert
      expect(result, mockTransactions);
      verify(() => mockRepository.getTransactionsPaginated(1, 20)).called(1);
    });

    test('GetStatisticsUseCase returns statistics', () async {
      // Arrange
      final mockStats = {
        'totalIncome': 5000.0,
        'totalExpenses': 2000.0,
        'savings': 3000.0,
      };

      final startDate = DateTime.now();
      final endDate = DateTime.now();

      when(
        () => mockRepository.getStatistics(any(), any()),
      ).thenAnswer((_) async => mockStats);

      final useCase = GetStatisticsUseCase(mockRepository);

      // Act
      final result = await useCase(startDate, endDate);

      // Assert
      expect(result, mockStats);
      expect(result['totalIncome'], 5000.0);
      verify(() => mockRepository.getStatistics(any(), any())).called(1);
    });
  });
}
