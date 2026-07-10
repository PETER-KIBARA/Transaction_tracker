import 'package:transaction_tracker/features/sms/domain/entities/sms_transaction_entity.dart';

class ProviderSummary {
  const ProviderSummary({
    required this.provider,
    this.count = 0,
    this.moneyIn = 0,
    this.moneyOut = 0,
  });

  final TransactionProvider provider;
  final int count;
  final double moneyIn;
  final double moneyOut;
}

class DashboardSummary {
  const DashboardSummary({
    required this.totalEarnings,
    required this.totalExpenses,
    required this.totalTransactionCosts,
    required this.providers,
  });

  final double totalEarnings;
  final double totalExpenses;
  final double totalTransactionCosts;
  final Map<TransactionProvider, ProviderSummary> providers;
}
