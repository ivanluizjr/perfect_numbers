import 'package:flutter/material.dart';
import 'package:perfect_numbers/app/features/perfect_number/presentation/pages/main/main_page.dart';
import 'package:perfect_numbers/app/features/perfect_number/presentation/pages/onboarding/onboarding_page.dart';

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

class Routes {
  Routes._();

  static const String onboarding = '/';
  static const String main = '/main';

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case onboarding:
        return _fade(const OnboardingPage(), settings);
      case main:
        final index = settings.arguments as int? ?? 0;
        return _fade(MainPage(initialIndex: index), settings);
      default:
        return _fade(const OnboardingPage(), settings);
    }
  }

  static PageRoute _fade(Widget page, RouteSettings settings) =>
      PageRouteBuilder(
        settings: settings,
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionsBuilder:
            (context, anim, secondaryAnimation, child) =>
                FadeTransition(opacity: anim, child: child),
        transitionDuration: const Duration(milliseconds: 300),
      );

  static Future<T?> pushNamed<T>(
    BuildContext context,
    String name, {
    Object? arguments,
  }) => Navigator.of(context).pushNamed<T>(name, arguments: arguments);

  static Future<T?> pushReplacementNamed<T, TO>(
    BuildContext context,
    String name, {
    Object? arguments,
  }) => Navigator.of(
    context,
  ).pushReplacementNamed<T, TO>(name, arguments: arguments);

  static Future<T?> pushNamedAndRemoveAll<T>(
    BuildContext context,
    String name, {
    Object? arguments,
  }) => Navigator.of(
    context,
  ).pushNamedAndRemoveUntil<T>(name, (_) => false, arguments: arguments);

  static void pop<T>(BuildContext context, [T? result]) =>
      Navigator.of(context).pop(result);
}
