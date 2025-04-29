import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:preptly/features/contact_us/screen/contact_us_screen.dart';
import 'package:preptly/features/splash/screen/splash_screen.dart';

import 'app_routes.dart';

/// AppRouter provides routing configuration using go_router
@singleton
class AppRouter {
  /// Creates the go_router configuration
  GoRouter get router => _router;

  late final GoRouter _router = GoRouter(
    initialLocation: AppRoutes.initial,
    routes: [
      GoRoute(path: AppRoutes.initial, builder: (context, state) => const SplashScreen()),
      GoRoute(path: AppRoutes.splash, builder: (context, state) => const SplashScreen()),
      GoRoute(path: AppRoutes.contactUs, builder: (context, state) => const ContactUsScreen()),
      // Add more routes as needed
    ],
    // Optional error handling
    errorBuilder:
        (context, state) => Scaffold(body: Center(child: Text('Route not found: ${state.uri}'))),
  );
}
