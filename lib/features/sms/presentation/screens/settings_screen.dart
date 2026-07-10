import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:transaction_tracker/core/theme/theme_provider.dart';
import 'package:transaction_tracker/core/services/sms_reading_service.dart';
import 'package:transaction_tracker/core/services/sms_parsing_service.dart';
import 'package:transaction_tracker/features/sms/domain/entities/sms_transaction_entity.dart';
import 'package:transaction_tracker/features/sms/presentation/providers/sms_providers.dart';
import 'package:transaction_tracker/injection/injection_container.dart';

/// Settings screen for application configuration
class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  bool _darkModeEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings'), elevation: 0),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Data Management Section
          Text(
            'Data Management',
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Card(
            child: ListTile(
              leading: const Icon(Icons.refresh),
              title: const Text('Re-scan SMS'),
              subtitle: const Text(
                'Import latest SMS messages from your device',
              ),
              trailing: const Icon(Icons.arrow_forward),
              onTap: _showConfirmDialog,
            ),
          ),
          const SizedBox(height: 12),
          Card(
            child: ListTile(
              leading: const Icon(Icons.download),
              title: const Text('Export Data'),
              subtitle: const Text('Export all data as CSV'),
              trailing: const Icon(Icons.arrow_forward),
              onTap: _exportData,
            ),
          ),
          const SizedBox(height: 24),
          // Appearance Section
          Text(
            'Appearance',
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Card(
            child: SwitchListTile(
              secondary: const Icon(Icons.dark_mode_outlined),
              title: const Text('Dark Mode'),
              value: ref.watch(themeModeProvider) == ThemeMode.dark,
              onChanged: (value) {
                ref.read(themeModeProvider.notifier).state = value
                    ? ThemeMode.dark
                    : ThemeMode.light;
              },
            ),
          ),
          const SizedBox(height: 24),
          // Security Section
          Text(
            'Security & Privacy',
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Card(
            child: ListTile(
              leading: const Icon(Icons.delete_forever),
              title: const Text('Clear All Data'),
              subtitle: const Text('Permanently delete all transactions'),
              trailing: const Icon(Icons.arrow_forward),
              onTap: _showClearDataConfirmDialog,
            ),
          ),
          const SizedBox(height: 24),
          // Info Section
          Text(
            'Information',
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Card(
            child: ListTile(
              leading: const Icon(Icons.info_outline),
              title: const Text('About'),
              subtitle: const Text('Version 1.0.0'),
            ),
          ),
          const SizedBox(height: 12),
          Card(
            child: ListTile(
              leading: const Icon(Icons.privacy_tip_outlined),
              title: const Text('Privacy'),
              subtitle: const Text('View privacy information'),
              onTap: _showPrivacyInfo,
            ),
          ),
        ],
      ),
    );
  }

  void _showConfirmDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Re-scan SMS'),
        content: const Text(
          'This will scan your device for new SMS messages and import them. This may take a while depending on the number of messages.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(onPressed: _importSms, child: const Text('Scan')),
        ],
      ),
    );
  }

  Future<void> _importSms() async {
    Navigator.pop(context);
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Scanning SMS messages...')));
    try {
      final smsReadingService = getIt<SmsReadingService>();
      final smsParsingService = getIt<SmsParsingService>();

      final allSms = await smsReadingService.getAllSms();
      final transactionSms = smsReadingService.filterTransactionSms(allSms);

      final transactions = <SmsTransactionEntity>[];
      for (final sms in transactionSms) {
        final transaction = smsParsingService.parseSms(
          sms.messageBody,
          sms.sender,
          receivedAt: sms.timestamp,
        );
        if (transaction != null) {
          transactions.add(transaction);
        }
      }

      if (transactions.isNotEmpty) {
        await ref.read(addMultipleTransactionsUseCaseProvider)(transactions);

        // Refresh UI providers
        ref.invalidate(paginatedTransactionsProvider);
        ref.invalidate(monthlyStatisticsProvider);
        ref.invalidate(allTransactionsProvider);

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Successfully imported ${transactions.length} transactions.',
              ),
            ),
          );
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('No new transactions found.')),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error scanning SMS: $e')));
      }
    }
  }

  Future<void> _exportData() async {
    try {
      final transactions = await ref
          .read(getAllTransactionsUseCaseProvider)
          .call();
      if (transactions.isEmpty) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('No transactions to export')),
          );
        }
        return;
      }

      String csv = 'ID,Date,Sender,Type,Category,Amount,Reference,Balance\n';
      for (final t in transactions) {
        csv +=
            '${t.id},${t.transactionDate},${t.sender},${t.transactionType},${t.category},${t.amount},${t.referenceNumber ?? ''},${t.balance ?? ''}\n';
      }

      final directory = await getApplicationDocumentsDirectory();
      final path = '${directory.path}/transactions_export.csv';
      final file = File(path);
      await file.writeAsString(csv);

      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Data exported to $path')));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error exporting data: $e')));
      }
    }
  }

  void _showClearDataConfirmDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear All Data'),
        content: const Text(
          'Are you sure you want to permanently delete all transactions? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              try {
                await ref
                    .read(smsTransactionRepositoryProvider)
                    .deleteAllTransactions();

                // Refresh UI providers
                ref.invalidate(paginatedTransactionsProvider);
                ref.invalidate(monthlyStatisticsProvider);
                ref.invalidate(allTransactionsProvider);

                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('All data has been cleared')),
                  );
                }
              } catch (e) {
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error clearing data: $e')),
                  );
                }
              }
            },
            child: const Text('Clear', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _showPrivacyInfo() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Privacy & Security'),
        content: const SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Your Data is Safe',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text('• All data is stored locally on your device'),
              SizedBox(height: 8),
              Text('• No data is sent to external servers'),
              SizedBox(height: 8),
              Text('• No analytics or tracking'),
              SizedBox(height: 8),
              Text('• Your SMS content is never shared'),
              SizedBox(height: 16),
              Text(
                'This app respects your privacy and operates completely offline.',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
