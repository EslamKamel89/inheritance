import 'package:flutter/material.dart';
import 'package:inheritance/core/router/app_routes_names.dart';
import 'package:inheritance/core/router/middleware.dart';
import 'package:inheritance/features/inheritance/presentation/about_screen.dart';
import 'package:inheritance/features/inheritance/presentation/screens/Inheritance_screen.dart';
import 'package:inheritance/features/splash_screen/splash_screen.dart';

class AppRouter {
  AppMiddleWare appMiddleWare;
  AppRouter({required this.appMiddleWare});
  Route? onGenerateRoute(RouteSettings routeSettings) {
    final args = routeSettings.arguments;
    String? routeName = appMiddleWare.middlleware(routeSettings.name);
    switch (routeName) {
      case AppRoutesNames.splashScreen:
        return CustomPageRoute(builder: (context) => const SplashScreen(), settings: routeSettings);
      case AppRoutesNames.inheritanceScreen:
        return CustomPageRoute(
          builder: (context) => const InheritanceScreen(),
          settings: routeSettings,
        );
      case AppRoutesNames.aboutScreen:
        return CustomPageRoute(builder: (context) => const AboutScreen(), settings: routeSettings);

      default:
        return null;
    }
  }
}

class CustomPageRoute<T> extends MaterialPageRoute<T> {
  CustomPageRoute({required super.builder, required RouteSettings super.settings});
  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return FadeTransition(opacity: animation, child: child);
  }
}
