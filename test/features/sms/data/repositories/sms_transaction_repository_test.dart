import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:transaction_tracker/features/sms/data/datasources/local_sms_datasource.dart';
import 'package:transaction_tracker/features/sms/data/repositories/sms_transaction_repository_impl.dart';
import 'package:transaction_tracker/features/sms/domain/entities/sms_transaction_entity.dart';

class MockLocalSmsDataSource extends Mock implements LocalSmsDataSource {}

void main() {
  late SmsTransactionRepositoryImpl repository;
  late MockLocalSmsDataSource mockDataSource;

  setUp(() {
    mockDataSource = MockLocalSmsDataSource();
    repository = SmsTransactionRepositoryImpl(mockDataSource);
  });

  group('SMS Transaction Repository', () {
    test('Get all transactions successfully', () async {
      // Arrange
      final mockTransactions = [
        SmsTransactionEntity(
          id: '1',
          sender: 'Bank',
          messageBody: 'Test',
          amount: 1000,
          transactionType: 'Transfer',
          category: 'Transfer',
          transactionDate: DateTime.fromMillisecondsSinceEpoch(0),
          createdAt: DateTime.fromMillisecondsSinceEpoch(0),
        ),
      ];

      // Act
      when(
        () => mockDataSource.getAllTransactions(),
      ).thenAnswer((_) async => []);

      final result = await repository.getAllTransactions();

      // Assert
      expect(result, isA<List<SmsTransactionEntity>>());
      verify(() => mockDataSource.getAllTransactions()).called(1);
    });

    test('Get transaction count successfully', () async {
      // Arrange
      when(
        () => mockDataSource.getTransactionCount(),
      ).thenAnswer((_) async => 10);

      // Act
      final result = await repository.getTransactionCount();

      // Assert
      expect(result, 10);
      verify(() => mockDataSource.getTransactionCount()).called(1);
    });

    test('Search transactions successfully', () async {
      // Arrange
      when(
        () => mockDataSource.searchTransactions(any()),
      ).thenAnswer((_) async => []);

      // Act
      final result = await repository.searchTransactions('test');

      // Assert
      expect(result, isA<List<SmsTransactionEntity>>());
      verify(() => mockDataSource.searchTransactions('test')).called(1);
    });

    test('Add transaction successfully', () async {
      // Arrange
      final transaction = SmsTransactionEntity(
        id: '1',
        sender: 'Bank',
        messageBody: 'Test',
        amount: 1000,
        transactionType: 'Transfer',
        category: 'Transfer',
        transactionDate: DateTime.fromMillisecondsSinceEpoch(0),
        createdAt: DateTime.fromMillisecondsSinceEpoch(0),
      );

      when(
        () => mockDataSource.insertTransaction(any()),
      ).thenAnswer((_) async => {});

      // Act
      await repository.addTransaction(transaction);

      // Assert
      verify(() => mockDataSource.insertTransaction(any())).called(1);
    });

    test('Delete transaction successfully', () async {
      // Arrange
      when(
        () => mockDataSource.deleteTransaction(any()),
      ).thenAnswer((_) async => {});

      // Act
      await repository.deleteTransaction('1');

      // Assert
      verify(() => mockDataSource.deleteTransaction('1')).called(1);
    });
  });
}
