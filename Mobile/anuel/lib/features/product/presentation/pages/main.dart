import 'add.dart';
import 'details.dart';
import 'package:anuel/features/product/presentation/pages/home.dart';
import 'package:anuel/features/product/presentation/pages/search.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(textTheme: GoogleFonts.poppinsTextTheme()),
      initialRoute: '/home',
      onGenerateRoute: (settings) {
        Widget page;

        switch (settings.name) {
          case '/home':
            page = const HomePage();
            break;
          case '/add':
            page = const AddProductPage();
            break;
          case '/details':
            page = const DetailsPage();
            break;
          case '/search':
            page = const SearchPage();
            break;
          default:
            page = const HomePage();
        }
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

            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        );
      },
    );
  }
}
