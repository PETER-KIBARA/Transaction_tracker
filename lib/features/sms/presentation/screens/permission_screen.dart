import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:transaction_tracker/core/services/permission_service.dart';

/// Screen that explains and requests SMS permission
class PermissionScreen extends ConsumerStatefulWidget {
  const PermissionScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<PermissionScreen> createState() => _PermissionScreenState();
}

class _PermissionScreenState extends ConsumerState<PermissionScreen> {
  late PermissionService _permissionService;
  bool _isRequesting = false;
  bool? _permissionDenied;

  @override
  void initState() {
    super.initState();
    _permissionService = PermissionService();
  }

  Future<void> _requestPermission() async {
    setState(() => _isRequesting = true);

    try {
      final granted = await _permissionService.requestSmsPermission();
      if (mounted) {
        setState(() {
          _isRequesting = false;
          _permissionDenied = !granted;
        });

        if (granted) {
          if (mounted) {
            Navigator.of(context).pushReplacementNamed('/home');
          }
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isRequesting = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error requesting permission: $e')),
        );
      }
    }
  }

  Future<void> _openAppSettings() async {
    try {
      await _permissionService.openAppSettings();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error opening app settings: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Icon
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Icon(
                  Icons.sms,
                  size: 40,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(height: 32),
              // Title
              Text(
                'SMS Access Required',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              // Description
              Text(
                'To analyze your transactions, we need access to your SMS messages. This allows us to:',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.grey[600],
                      height: 1.5,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              // Permission Benefits
              ...[
                'Extract transaction amounts and details',
                'Categorize your spending automatically',
                'Generate spending analytics',
                'Track your financial trends',
              ]
                  .map(
                    (benefit) => Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: Row(
                        children: [
                          Icon(
                            Icons.check_circle,
                            color: Theme.of(context).colorScheme.primary,
                            size: 20,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              benefit,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                  .toList(),
              const SizedBox(height: 32),
              // Error message if denied
              if (_permissionDenied == true)
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Colors.red.withOpacity(0.3),
                    ),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.error_outline, color: Colors.red),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Permission was denied. Please enable SMS access in app settings.',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: Colors.red[700],
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
              if (_permissionDenied == true) const SizedBox(height: 24),
              // Buttons
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isRequesting ? null : _requestPermission,
                  child: _isRequesting
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      : const Text('Allow SMS Access'),
                ),
              ),
              if (_permissionDenied == true) ...[
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: _openAppSettings,
                    child: const Text('Open App Settings'),
                  ),
                ),
              ],
              const SizedBox(height: 24),
              // Note about privacy
              Text(
                '💡 Your SMS data is stored locally on your device and never sent to external servers.',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.grey[500],
                      fontStyle: FontStyle.italic,
                    ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
