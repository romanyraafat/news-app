import 'package:flutter/material.dart';
import '../features/home/presentation/screens/categories_page.dart';
import 'app_routes.dart';

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.home:
        return MaterialPageRoute(
          builder: (context) => const CategoriesPage(),
          settings: settings,
        );
      default:
        return MaterialPageRoute(
          builder: (context) => const CategoriesPage(),
          settings: settings,
        );
    }
  }
}
