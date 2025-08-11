import 'package:flutter/material.dart';
import 'package:anuel/core/router/router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset('assets/images/splash_bg.jpg', fit: BoxFit.cover),
            Container(
              color: Colors.black.withOpacity(0.3),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushReplacementNamed(context, AppRouter.signin);
                },
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: const Color(0xFF3F51FF),
                            width: 2.0,
                          ),
                        ),
                        child: const Text(
                          'ECOM',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF3F51FF),
                            fontSize: 28,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'ECOMMERCE APP',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
