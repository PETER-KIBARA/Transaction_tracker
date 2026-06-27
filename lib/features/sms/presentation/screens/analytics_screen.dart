import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:transaction_tracker/core/utils/app_utils.dart';
import 'package:transaction_tracker/features/sms/presentation/providers/sms_providers.dart';
import 'package:transaction_tracker/features/sms/presentation/widgets/error_widget.dart';
import 'package:transaction_tracker/features/sms/presentation/widgets/loading_widget.dart';

/// Screen displaying analytics and charts
class AnalyticsScreen extends ConsumerStatefulWidget {
  const AnalyticsScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends ConsumerState<AnalyticsScreen> {
  late DateTime _selectedMonth;

  @override
  void initState() {
    super.initState();
    _selectedMonth = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    final startOfMonth = DateTime(_selectedMonth.year, _selectedMonth.month, 1);
    final endOfMonth = DateTime(_selectedMonth.year, _selectedMonth.month + 1, 1).subtract(const Duration(days: 1));

    final statisticsAsync = ref.watch(
      monthlyStatisticsProvider(startDate: startOfMonth, endDate: endOfMonth),
    );
    final transactionsAsync = ref.watch(
      transactionsByDateRangeProvider(startDate: startOfMonth, endDate: endOfMonth),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Analytics'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Month selector
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () {
                          setState(() {
                            _selectedMonth = DateTime(
                              _selectedMonth.year,
                              _selectedMonth.month - 1,
                            );
                          });
                        },
                      ),
                      Text(
                        AppUtils.getMonthName(_selectedMonth.month),
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.arrow_forward),
                        onPressed: () {
                          setState(() {
                            _selectedMonth = DateTime(
                              _selectedMonth.year,
                              _selectedMonth.month + 1,
                            );
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              // Statistics summary
              statisticsAsync.when(
                data: (stats) {
                  final income = (stats['totalIncome'] as num).toDouble();
                  final expenses = (stats['totalExpenses'] as num).toDouble();
                  final savings = (stats['savings'] as num).toDouble();

                  return _buildSummaryCards(context, income, expenses, savings);
                },
                loading: () => const LoadingWidget(height: 120),
                error: (e, st) => AppErrorWidget(error: e.toString()),
              ),
              const SizedBox(height: 32),
              // Pie chart
              Text(
                'Spending Distribution',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 16),
              transactionsAsync.when(
                data: (transactions) {
                  if (transactions.isEmpty) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Text(
                          'No transaction data for this month',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: Colors.grey,
                              ),
                        ),
                      ),
                    );
                  }

                  // Group by category
                  final categoryTotals = <String, double>{};
                  for (final txn in transactions) {
                    categoryTotals[txn.category] = (categoryTotals[txn.category] ?? 0) + txn.amount;
                  }

                  return SizedBox(
                    height: 300,
                    child: PieChart(
                      PieChartData(
                        sections: categoryTotals.entries
                            .map(
                              (e) => PieChartSectionData(
                                value: e.value,
                                title: '${e.key}\n${AppUtils.formatSimpleCurrency(e.value)}',
                                radius: 100,
                              ),
                            )
                            .toList(),
                        sectionsSpace: 0,
                        centerSpaceRadius: 40,
                      ),
                    ),
                  );
                },
                loading: () => const LoadingWidget(height: 300),
                error: (e, st) => AppErrorWidget(error: e.toString()),
              ),
              const SizedBox(height: 32),
              // Bar chart for daily spending
              Text(
                'Daily Breakdown',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 16),
              transactionsAsync.when(
                data: (transactions) {
                  if (transactions.isEmpty) {
                    return SizedBox(
                      height: 200,
                      child: Center(
                        child: Text(
                          'No data available',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: Colors.grey,
                              ),
                        ),
                      ),
                    );
                  }

                  // Group by day
                  final dailyTotals = <int, double>{};
                  for (final txn in transactions) {
                    final day = txn.transactionDate.day;
                    dailyTotals[day] = (dailyTotals[day] ?? 0) + txn.amount;
                  }

                  final maxValue = dailyTotals.values.isNotEmpty
                      ? dailyTotals.values.reduce((a, b) => a > b ? a : b)
                      : 1;

                  return SizedBox(
                    height: 300,
                    child: BarChart(
                      BarChartData(
                        maxY: maxValue * 1.1,
                        barGroups: dailyTotals.entries
                            .map(
                              (e) => BarChartGroupData(
                                x: e.key,
                                barRods: [
                                  BarChartRodData(
                                    toY: e.value,
                                    color: Theme.of(context).colorScheme.primary,
                                    width: 6,
                                  ),
                                ],
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  );
                },
                loading: () => const LoadingWidget(height: 300),
                error: (e, st) => AppErrorWidget(error: e.toString()),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryCards(BuildContext context, double income, double expenses, double savings) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildSmallStatCard(
                context,
                title: 'Income',
                amount: income,
                icon: Icons.arrow_downward,
                color: Colors.green,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildSmallStatCard(
                context,
                title: 'Expenses',
                amount: expenses,
                icon: Icons.arrow_upward,
                color: Colors.red,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _buildSmallStatCard(
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

  Widget _buildSmallStatCard(
    BuildContext context, {
    required String title,
    required double amount,
    required IconData icon,
    required Color color,
    bool fullWidth = false,
  }) {
    return Card(
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
                        color: Colors.grey[600],
                      ),
                ),
                Icon(icon, color: color, size: 18),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              AppUtils.formatCurrency(amount),
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
