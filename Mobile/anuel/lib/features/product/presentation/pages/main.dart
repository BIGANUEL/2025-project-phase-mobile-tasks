import 'add.dart';
import 'details.dart';
import 'package:anuel/features/product/presentation/pages/home.dart';
import 'package:anuel/features/product/presentation/pages/search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:anuel/core/router/router.dart';
import '../../../../injection_container.dart' as di;
import 'package:anuel/features/auth/presentation/bloc/auth_bloc.dart'; // adjust import if needed

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => di.sl<AuthBloc>(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(textTheme: GoogleFonts.poppinsTextTheme()),
        initialRoute: AppRouter.splash,
        onGenerateRoute: AppRouter.generateRoute,
      ),
    );
  }
}
