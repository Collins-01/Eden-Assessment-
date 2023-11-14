import 'package:eden_demo/core/models/models.dart';
import 'package:eden_demo/presentation/views/orders_view.dart';
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
      case (RoutePaths.authView):
        return _getPageRoute(settings: settings, viewToShow: const AuthView());
      case (RoutePaths.homeView):
        return _getPageRoute(settings: settings, viewToShow: const HomeView());
      case (RoutePaths.ordersView):
        return _getPageRoute(
            settings: settings, viewToShow: const OrdersView());

      case (RoutePaths.orderInfoView):
        final order = routeArgs as OrderModel;

        return _getPageRoute(
            settings: settings,
            viewToShow: OrderInfoView(
              orderModel: order,
            ));
      default:
        return _getPageRoute(
          settings: settings,
          viewToShow: const Scaffold(),
        );
    }
  }
}
