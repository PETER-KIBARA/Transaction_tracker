import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:transaction_tracker/core/utils/app_utils.dart';
import 'package:transaction_tracker/features/sms/domain/entities/dashboard_summary.dart';
import 'package:transaction_tracker/features/sms/domain/entities/sms_transaction_entity.dart';
import 'package:transaction_tracker/features/sms/presentation/providers/sms_providers.dart';
import 'package:transaction_tracker/features/sms/presentation/widgets/loading_widget.dart';
import 'package:transaction_tracker/features/sms/presentation/widgets/transaction_list.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final summary = ref.watch(dashboardSummaryProvider);
    final transactions = ref.watch(paginatedTransactionsProvider(page: 1));
    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(dashboardSummaryProvider);
          ref.invalidate(paginatedTransactionsProvider);
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              summary.when(
                data: (data) => _SummaryContent(summary: data),
                loading: () => const LoadingWidget(height: 180),
                error: (e, _) => Text('Could not load summary: $e'),
              ),
              const SizedBox(height: 24),
              Text(
                'Recent Transactions',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              transactions.when(
                data: (items) => TransactionList(
                  transactions: items.take(5).toList(),
                  shrinkWrap: true,
                ),
                loading: () => const LoadingWidget(height: 120),
                error: (e, _) => Text('$e'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SummaryContent extends StatelessWidget {
  const _SummaryContent({required this.summary});
  final DashboardSummary summary;
  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Wrap(
        spacing: 8,
        runSpacing: 8,
        children: [
          _StatCard(
            title: 'Total Earnings',
            value: summary.totalEarnings,
            color: Colors.green,
          ),
          _StatCard(
            title: 'Total Expenses',
            value: summary.totalExpenses,
            color: Colors.red,
          ),
          _StatCard(
            title: 'Transaction Costs',
            value: summary.totalTransactionCosts,
            color: Colors.orange,
          ),
        ],
      ),
      const SizedBox(height: 24),
      Text('Providers', style: Theme.of(context).textTheme.titleLarge),
      const SizedBox(height: 8),
      for (final provider in [
        TransactionProvider.mpesa,
        TransactionProvider.airtel,
        TransactionProvider.equity,
      ])
        _ProviderCard(
          provider: provider,
          summary: summary.providers[provider]!,
        ),
    ],
  );
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.title,
    required this.value,
    required this.color,
  });
  final String title;
  final double value;
  final Color color;
  @override
  Widget build(BuildContext context) => SizedBox(
    width: 170,
    child: Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title),
            const SizedBox(height: 6),
            Text(
              AppUtils.formatCurrency(value),
              style: TextStyle(color: color, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    ),
  );
}

class _ProviderCard extends StatelessWidget {
  const _ProviderCard({required this.provider, required this.summary});
  final TransactionProvider provider;
  final ProviderSummary summary;
  @override
  Widget build(BuildContext context) => Card(
    child: ListTile(
      leading: Icon(switch (provider) {
        TransactionProvider.mpesa => Icons.account_balance_wallet,
        TransactionProvider.airtel => Icons.phone_android,
        TransactionProvider.equity => Icons.account_balance,
        TransactionProvider.unknown => Icons.help_outline,
      }),
      title: Text(switch (provider) {
        TransactionProvider.mpesa => 'M-Pesa',
        TransactionProvider.airtel => 'Airtel Money',
        TransactionProvider.equity => 'Equity',
        TransactionProvider.unknown => 'Unknown',
      }),
      subtitle: Text(
        '${summary.count} transactions · In ${AppUtils.formatSimpleCurrency(summary.moneyIn)} · Out ${AppUtils.formatSimpleCurrency(summary.moneyOut)}',
      ),
      trailing: const Icon(Icons.chevron_right),
      onTap: () => context.push('/providers/${provider.name}'),
    ),
  );
}
