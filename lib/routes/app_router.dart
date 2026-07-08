import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:transaction_tracker/features/sms/presentation/screens/splash_screen.dart';
import 'package:transaction_tracker/features/sms/presentation/screens/permission_screen.dart';
import 'package:transaction_tracker/features/sms/presentation/screens/home_screen.dart';

/// App routes with go_router
final appRouter = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(
      path: '/splash',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/permissions',
      builder: (context, state) => const PermissionScreen(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomeScreen(),
    ),
  ],
  errorBuilder: (context, state) {
    return Scaffold(
      body: Center(
        child: Text('Page not found: ${state.matchedLocation}'),
      ),
    );
  },
);
