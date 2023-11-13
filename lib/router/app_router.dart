import 'package:eden_demo/presentation/views/views.dart';
import 'package:eden_demo/router/router.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static PageRoute _getPageRoute({
    required RouteSettings settings,
    required Widget viewToShow,
  }) {
    return MaterialPageRoute(
        builder: (context) => viewToShow, settings: settings);
  }

  static Route<dynamic> generateRoute(RouteSettings settings) {
    // ignore: unused_local_variable

    T? extractArguments<T>(RouteSettings settings) {
      return settings.arguments as T?;
    }

// Usage
    var routeArgs = extractArguments<Map<String, dynamic>>(settings);

    // Map<String, dynamic> routeArgs = settings.arguments != null
    //     ? settings.arguments as Map<String, dynamic>
    //     : {};

    switch (settings.name) {
      case (RoutePaths.splashScreenView):
        return _getPageRoute(
            settings: settings, viewToShow: const SplashScreenView());

      default:
        return _getPageRoute(
          settings: settings,
          viewToShow: const Scaffold(),
        );
    }
  }
}
