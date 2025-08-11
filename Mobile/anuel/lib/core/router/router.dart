import 'package:flutter/material.dart';
import 'package:anuel/features/product/presentation/pages/add.dart';
import 'package:anuel/features/product/presentation/pages/details.dart';
import 'package:anuel/features/product/presentation/pages/home.dart';
import 'package:anuel/features/product/presentation/pages/search.dart';
import 'package:anuel/features/auth/presentation/pages/sign_up_page.dart';
import 'package:anuel/features/auth/presentation/pages/sign_in_page.dart';
import 'package:anuel/features/auth/presentation/pages/splash_page.dart';
class AppRouter {
  static const String home = '/home';
  static const String add = '/add';
  static const String details = '/details';
  static const String search = '/search';
  static const String signup = 'signup';
  static const String signin = 'signin';
  static const String splash = 'splash';
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return _buildRoute(settings, const HomePage());
      case add:
        return _buildRoute(settings, const AddProductPage());
      case details:
        return _buildRoute(settings, const DetailsPage());
      case search:
        return _buildRoute(settings, const SearchPage());
      case signup:
        return _buildRoute(settings, const SignUpPage());
      case signin:
        return _buildRoute(settings, const SignInPage());
      case splash:
        return _buildRoute(settings, const SplashScreen());
      default:
        return _buildRoute(settings, const HomePage());
    }
  }

  static PageRouteBuilder _buildRoute(RouteSettings settings, Widget page) {
    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (_, __, ___) => page,
      transitionsBuilder: (_, animation, __, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        final tween = Tween(
          begin: begin,
          end: end,
        ).chain(CurveTween(curve: Curves.easeInOut));

        return SlideTransition(position: animation.drive(tween), child: child);
      },
    );
  }
}
