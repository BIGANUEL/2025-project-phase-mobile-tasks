import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:anuel/home.dart';
import 'package:anuel/add.dart';
import 'package:anuel/details.dart';
import 'package:anuel/search.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      initialRoute: '/search',
      routes: {
        '/home': (context) => HomePage(),
        '/add': (context) => AddProductPage(),
        '/details': (context) => DetailsPage(),
        '/search': (context) => SearchPage(),
      },
    );
  }
}
