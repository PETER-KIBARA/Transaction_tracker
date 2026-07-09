import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:transaction_tracker/core/utils/app_utils.dart';
import 'package:transaction_tracker/features/sms/presentation/providers/sms_providers.dart';
import 'package:transaction_tracker/features/sms/presentation/widgets/error_widget.dart';
import 'package:transaction_tracker/features/sms/presentation/widgets/loading_widget.dart';

/// Dashboard screen showing key financial metrics
class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final now = DateTime.now();
    final startOfMonth = DateTime(now.year, now.month, 1);
    final endOfMonth = DateTime(now.year, now.month + 1, 1).subtract(const Duration(days: 1));

    final statisticsAsync = ref.watch(
      monthlyStatisticsProvider(startDate: startOfMonth, endDate: endOfMonth),
    );
    final transactionsAsync = ref.watch(paginatedTransactionsProvider(page: 1));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        elevation: 0,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(monthlyStatisticsProvider(startDate: startOfMonth, endDate: endOfMonth));
          ref.invalidate(paginatedTransactionsProvider(page: 1));
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Statistics Cards
                statisticsAsync.when(
                  data: (stats) => _buildStatisticsCards(context, stats),
                  loading: () => const LoadingWidget(height: 180),
                  error: (e, st) => AppErrorWidget(error: e.toString()),
                ),
                const SizedBox(height: 32),
                // Recent Transactions
                Text(
                  'Recent Transactions',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 12),
                transactionsAsync.when(
                  data: (transactions) {
                    if (transactions.isEmpty) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Text(
                            'No transactions found. Scan your SMS to get started.',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: Colors.grey,
                                ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                    }
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: transactions.take(5).length,
                      itemBuilder: (context, index) {
                        final txn = transactions[index];
                        final isExpense = txn.transactionType.toLowerCase().contains('withdrawal') ||
                            txn.transactionType.toLowerCase().contains('payment') ||
                            txn.transactionType.toLowerCase().contains('purchase');

                        return Card(
                          margin: const EdgeInsets.only(bottom: 8),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              children: [
                                Container(
                                  width: 48,
                                  height: 48,
                                  decoration: BoxDecoration(
                                    color: isExpense
                                        ? Colors.red.withOpacity(0.1)
                                        : Colors.green.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Icon(
                                    isExpense ? Icons.arrow_upward : Icons.arrow_downward,
                                    color: isExpense ? Colors.red : Colors.green,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        txn.category,
                                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                              fontWeight: FontWeight.w600,
                                            ),
                                      ),
                                      Text(
                                        AppUtils.formatDate(txn.transactionDate, 'dd MMM yyyy'),
                                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                              color: Colors.grey,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  '${isExpense ? '-' : '+'}${AppUtils.formatSimpleCurrency(txn.amount)}',
                                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: isExpense ? Colors.red : Colors.green,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                  loading: () => const LoadingWidget(height: 150),
                  error: (e, st) => AppErrorWidget(error: e.toString()),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatisticsCards(BuildContext context, Map<String, dynamic> stats) {
    final totalIncome = (stats['totalIncome'] as num).toDouble();
    final totalExpenses = (stats['totalExpenses'] as num).toDouble();
    final savings = (stats['savings'] as num).toDouble();

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildStatCard(
                context,
                title: 'Income',
                amount: totalIncome,
                icon: Icons.trending_up,
                color: Colors.green,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildStatCard(
                context,
                title: 'Expenses',
                amount: totalExpenses,
                icon: Icons.trending_down,
                color: Colors.red,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _buildStatCard(
          context,
          title: 'Savings',
          amount: savings,
          icon: Icons.savings,
          color: Colors.blue,
          fullWidth: true,
        ),
      ],
    );
  }

  Widget _buildStatCard(
    BuildContext context, {
    required String title,
    required double amount,
    required IconData icon,
    required Color color,
    bool fullWidth = false,
  }) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [color.withOpacity(0.1), color.withOpacity(0.05)],
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: color,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    Icon(icon, color: color, size: 20),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  AppUtils.formatCurrency(amount),
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: color,
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
