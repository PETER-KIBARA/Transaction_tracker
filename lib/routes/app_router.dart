import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:transaction_tracker/features/sms/presentation/screens/splash_screen.dart';

/// App routes with go_router
final appRouter = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(
      path: '/splash',
      builder: (context, state) => const SplashScreen(),
    ),
    // Additional routes will be added as we create screens
  ],
  errorBuilder: (context, state) {
    return Scaffold(
      body: Center(
        child: Text('Page not found: ${state.matchedLocation}'),
      ),
    );
  },
);
