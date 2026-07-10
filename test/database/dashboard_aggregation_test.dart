import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:transaction_tracker/database/app_database.dart';

void main() {
  late AppDatabase database;

  setUp(() async {
    database = AppDatabase.forTesting(NativeDatabase.memory());
    await database.customStatement('''
      CREATE TABLE sms_transactions (
        id TEXT NOT NULL PRIMARY KEY,
        sender TEXT NOT NULL,
        message_body TEXT NOT NULL,
        amount REAL NOT NULL,
        transaction_type TEXT NOT NULL,
        category TEXT NOT NULL,
        transaction_date INTEGER NOT NULL,
        provider TEXT NOT NULL DEFAULT 'unknown',
        transaction_cost REAL,
        balance REAL,
        reference_number TEXT,
        created_at INTEGER NOT NULL
      )
    ''');
  });

  tearDown(() => database.close());

  test(
    'computes provider totals, costs, income, and expenses in SQL',
    () async {
      final now = DateTime(2026, 7, 10);
      await database.insertMultipleSmsTransactions([
        SmsTransactionsCompanion.insert(
          id: 'income',
          sender: 'MPESA',
          messageBody: 'Paid in',
          amount: 1000,
          transactionType: 'Deposit',
          category: 'Deposit',
          transactionDate: now,
          provider: const Value('mpesa'),
          transactionCost: const Value(12.5),
          createdAt: now,
        ),
        SmsTransactionsCompanion.insert(
          id: 'expense',
          sender: 'MPESA',
          messageBody: 'Paid out',
          amount: 200,
          transactionType: 'Payment',
          category: 'Payment',
          transactionDate: now,
          provider: const Value('mpesa'),
          transactionCost: const Value(5),
          createdAt: now,
        ),
        SmsTransactionsCompanion.insert(
          id: 'airtel',
          sender: 'AIRTEL',
          messageBody: 'Paid in',
          amount: 300,
          transactionType: 'Paid in',
          category: 'Deposit',
          transactionDate: now,
          provider: const Value('airtel'),
          createdAt: now,
        ),
      ]);

      final aggregates = await database.getDashboardAggregates();
      final mpesa = aggregates.singleWhere(
        (value) => value.provider == 'mpesa',
      );
      final airtel = aggregates.singleWhere(
        (value) => value.provider == 'airtel',
      );

      expect(mpesa.count, 2);
      expect(mpesa.moneyIn, 1000);
      expect(mpesa.moneyOut, 200);
      expect(mpesa.transactionCosts, 17.5);
      expect(airtel.moneyIn, 300);
      expect(airtel.moneyOut, 0);
    },
  );
}
