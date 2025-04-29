import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Navigation helper functions for use with go_router
///
/// This class provides static methods for navigating between screens
/// using the go_router package.
class NavigationHelper {
  /// Navigate to a new route
  static void goTo(BuildContext context, String route, {Object? extra}) {
    context.go(route, extra: extra);
  }

  /// Navigate to a new route and replace the current one
  static void replaceTo(BuildContext context, String route, {Object? extra}) {
    context.replace(route, extra: extra);
  }

  /// Push a new route onto the navigation stack
  static Future<T?> pushTo<T>(BuildContext context, String route, {Object? extra}) {
    return context.push<T>(route, extra: extra);
  }

  /// Pop the current route
  static void pop<T>(BuildContext context, [T? result]) {
    context.pop(result);
  }

  /// Check if we can pop the current route
  static bool canPop(BuildContext context) {
    return context.canPop();
  }

  /// Pop until we reach a specific route
  static void popUntil(BuildContext context, String route) {
    while (context.canPop() && GoRouterState.of(context).uri.toString() != route) {
      context.pop();
    }
  }
}
