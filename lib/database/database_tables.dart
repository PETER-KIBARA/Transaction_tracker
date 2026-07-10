import 'package:drift/drift.dart';

/// SQLite table for SMS transactions
class SmsTransactions extends Table {
  TextColumn get id => text()();
  TextColumn get sender => text()();
  TextColumn get messageBody => text()();
  RealColumn get amount => real()();
  TextColumn get transactionType => text()();
  TextColumn get category => text()();
  DateTimeColumn get transactionDate => dateTime()();
  TextColumn get provider => text().withDefault(const Constant('unknown'))();
  RealColumn get transactionCost => real().nullable()();
  RealColumn get balance => real().nullable()();
  TextColumn get referenceNumber => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};

  @override
  List<Set<Column>> get uniqueKeys => [
    {sender, messageBody, amount, transactionDate}, // Prevent duplicates
  ];
}

/// SQLite table for categories
class Categories extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().unique()();
  TextColumn get icon => text()();
  TextColumn get color => text()();
  DateTimeColumn get createdAt => dateTime()();
}

/// SQLite table for analytics cache
class AnalyticsCache extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get month => dateTime()();
  RealColumn get totalIncome => real().withDefault(const Constant(0))();
  RealColumn get totalExpenses => real().withDefault(const Constant(0))();
  RealColumn get savings => real().withDefault(const Constant(0))();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  List<Set<Column>> get uniqueKeys => [
    {month}, // One record per month
  ];
}
