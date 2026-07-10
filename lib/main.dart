import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:transaction_tracker/core/theme/app_theme.dart';
import 'package:transaction_tracker/injection/injection_container.dart';
import 'package:transaction_tracker/routes/app_router.dart';
import 'package:transaction_tracker/core/services/permission_service.dart';
import 'package:transaction_tracker/core/services/sms_listener_service.dart';
import 'package:transaction_tracker/core/theme/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize dependency injection
  configureDependencies();

  // Initialize SMS listener
  await _initializeSmsListener();

  runApp(const ProviderScope(child: MyApp()));
}

Future<void> _initializeSmsListener() async {
  try {
    final permissionService = getIt<PermissionService>();
    final smsListenerService = getIt<SmsListenerService>();

    final hasPermission = await permissionService.isSmsPermissionGranted();
    if (hasPermission) {
      await smsListenerService.startListening();
    }
  } catch (e) {
    // Silently fail - SMS listener will start when permission is granted
    debugPrint('Failed to initialize SMS listener: $e');
  }
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);

    return MaterialApp.router(
      title: 'SMS LEDGER',
      theme: AppTheme.lightTheme(),
      darkTheme: AppTheme.darkTheme(),
      themeMode: themeMode,
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
    );
  }
}
