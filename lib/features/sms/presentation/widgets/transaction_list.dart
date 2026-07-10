import 'package:flutter/material.dart';
import 'package:transaction_tracker/core/utils/app_utils.dart';
import 'package:transaction_tracker/features/sms/domain/entities/sms_transaction_entity.dart';

class TransactionList extends StatelessWidget {
  const TransactionList({
    super.key,
    required this.transactions,
    this.shrinkWrap = false,
  });
  final List<SmsTransactionEntity> transactions;
  final bool shrinkWrap;

  @override
  Widget build(BuildContext context) => ListView.builder(
    shrinkWrap: shrinkWrap,
    physics: shrinkWrap ? const NeverScrollableScrollPhysics() : null,
    itemCount: transactions.length,
    itemBuilder: (context, index) =>
        TransactionListItem(transaction: transactions[index]),
  );
}

class TransactionListItem extends StatelessWidget {
  const TransactionListItem({super.key, required this.transaction});
  final SmsTransactionEntity transaction;

  @override
  Widget build(BuildContext context) {
    final isExpense = transaction.transactionType != 'Deposit';
    final color = isExpense ? Colors.red : Colors.green;
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withOpacity(.12),
          child: Icon(
            isExpense ? Icons.arrow_upward : Icons.arrow_downward,
            color: color,
          ),
        ),
        title: Text(
          transaction.category,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(
          '${transaction.sender} · ${AppUtils.formatDateTime(transaction.transactionDate)}',
        ),
        trailing: Text(
          '${isExpense ? '-' : '+'}${AppUtils.formatSimpleCurrency(transaction.amount)}',
          style: TextStyle(fontWeight: FontWeight.w600, color: color),
        ),
      ),
    );
  }
}
