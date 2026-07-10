import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:transaction_tracker/core/utils/app_utils.dart';
import 'package:transaction_tracker/features/sms/presentation/providers/sms_providers.dart';
import 'package:transaction_tracker/features/sms/presentation/widgets/error_widget.dart';
import 'package:transaction_tracker/features/sms/presentation/widgets/loading_widget.dart';

/// Screen displaying all transactions with search and filtering
class TransactionsScreen extends ConsumerStatefulWidget {
  const TransactionsScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends ConsumerState<TransactionsScreen> {
  final TextEditingController _searchController = TextEditingController();
  int _currentPage = 1;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final searchQuery = ref.watch(searchQueryProvider);
    final transactionsAsync = searchQuery.isEmpty
        ? ref.watch(paginatedTransactionsProvider(page: _currentPage))
        : ref.watch(searchedTransactionsProvider(query: searchQuery));

    return Scaffold(
      appBar: AppBar(title: const Text('Transactions'), elevation: 0),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                ref.read(searchQueryProvider.notifier).state = value;
                setState(() => _currentPage = 1);
              },
              decoration: InputDecoration(
                hintText: 'Search by amount, sender, or date...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          ref.read(searchQueryProvider.notifier).state = '';
                          setState(() => _currentPage = 1);
                        },
                      )
                    : null,
              ),
            ),
          ),
          // Transactions List
          Expanded(
            child: transactionsAsync.when(
              data: (transactions) {
                if (transactions.isEmpty) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.receipt_long_outlined,
                            size: 64,
                            color: Colors.grey[300],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'No transactions found',
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(color: Colors.grey),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            searchQuery.isEmpty
                                ? 'Scan your SMS messages to get started'
                                : 'Try a different search query',
                            style: Theme.of(
                              context,
                            ).textTheme.bodySmall?.copyWith(color: Colors.grey),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: transactions.length,
                  itemBuilder: (context, index) {
                    final txn = transactions[index];
                    final isExpense =
                        txn.transactionType.toLowerCase().contains(
                          'withdrawal',
                        ) ||
                        txn.transactionType.toLowerCase().contains('payment') ||
                        txn.transactionType.toLowerCase().contains('purchase');

                    return Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: ListTile(
                          leading: Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              color: isExpense
                                  ? Colors.red.withOpacity(0.1)
                                  : Colors.green.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(
                              isExpense
                                  ? Icons.arrow_upward
                                  : Icons.arrow_downward,
                              color: isExpense ? Colors.red : Colors.green,
                            ),
                          ),
                          title: Text(
                            txn.category,
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 4),
                              Text(
                                'From: ${txn.sender}',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.bodySmall
                                    ?.copyWith(color: Colors.grey[600]),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                AppUtils.formatDateTime(txn.transactionDate),
                                style: Theme.of(context).textTheme.bodySmall
                                    ?.copyWith(color: Colors.grey),
                              ),
                              if (txn.referenceNumber != null) ...[
                                const SizedBox(height: 4),
                                Text(
                                  'Ref: ${txn.referenceNumber}',
                                  style: Theme.of(context).textTheme.bodySmall
                                      ?.copyWith(color: Colors.grey),
                                ),
                              ],
                            ],
                          ),
                          trailing: Text(
                            '${isExpense ? '-' : '+'}${AppUtils.formatSimpleCurrency(txn.amount)}',
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: isExpense ? Colors.red : Colors.green,
                                ),
                          ),
                          onTap: () {
                            _showTransactionDetails(context, txn);
                          },
                        ),
                      ),
                    );
                  },
                );
              },
              loading: () => const LoadingWidget(),
              error: (error, stackTrace) =>
                  AppErrorWidget(error: error.toString()),
            ),
          ),
          // Pagination controls
          if (searchQuery.isEmpty)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: _currentPage > 1
                        ? () {
                            setState(() => _currentPage--);
                            ref.refresh(
                              paginatedTransactionsProvider(page: _currentPage),
                            );
                          }
                        : null,
                    icon: const Icon(Icons.arrow_back),
                    label: const Text('Previous'),
                  ),
                  Text('Page $_currentPage'),
                  ElevatedButton.icon(
                    onPressed: () {
                      setState(() => _currentPage++);
                      ref.refresh(
                        paginatedTransactionsProvider(page: _currentPage),
                      );
                    },
                    icon: const Icon(Icons.arrow_forward),
                    label: const Text('Next'),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  void _showTransactionDetails(BuildContext context, dynamic txn) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Transaction Details'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildDetailRow('Category:', txn.category),
              _buildDetailRow('Amount:', AppUtils.formatCurrency(txn.amount)),
              _buildDetailRow('Type:', txn.transactionType),
              _buildDetailRow('From:', txn.sender),
              _buildDetailRow(
                'Date:',
                AppUtils.formatDateTime(txn.transactionDate),
              ),
              if (txn.referenceNumber != null)
                _buildDetailRow('Reference:', txn.referenceNumber),
              if (txn.balance != null)
                _buildDetailRow(
                  'Balance:',
                  AppUtils.formatCurrency(txn.balance),
                ),
              const SizedBox(height: 12),
              const Divider(),
              const SizedBox(height: 12),
              Text('Message:', style: Theme.of(context).textTheme.labelMedium),
              const SizedBox(height: 8),
              Text(
                txn.messageBody,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(child: Text(value ?? 'N/A')),
        ],
      ),
    );
  }
}
