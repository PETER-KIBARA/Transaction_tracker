import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:transaction_tracker/features/sms/domain/entities/sms_transaction_entity.dart';
import 'package:transaction_tracker/features/sms/presentation/providers/sms_providers.dart';
import 'package:transaction_tracker/features/sms/presentation/widgets/loading_widget.dart';
import 'package:transaction_tracker/features/sms/presentation/widgets/transaction_list.dart';

class ProviderTransactionsScreen extends ConsumerWidget {
  const ProviderTransactionsScreen({super.key, required this.provider});
  final TransactionProvider provider;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transactions = ref.watch(
      transactionsByProviderProvider(providerName: provider.name),
    );
    return Scaffold(
      appBar: AppBar(title: Text(_title(provider))),
      body: transactions.when(
        data: (items) => items.isEmpty
            ? const Center(child: Text('No transactions for this provider'))
            : Padding(
                padding: const EdgeInsets.all(16),
                child: TransactionList(transactions: items),
              ),
        loading: () => const LoadingWidget(),
        error: (error, _) =>
            Center(child: Text('Could not load transactions: $error')),
      ),
    );
  }

  String _title(TransactionProvider value) => switch (value) {
    TransactionProvider.mpesa => 'M-Pesa Transactions',
    TransactionProvider.airtel => 'Airtel Money Transactions',
    TransactionProvider.equity => 'Equity Transactions',
    TransactionProvider.unknown => 'Unknown Transactions',
  };
}
