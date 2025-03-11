import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF54408C),
      body: Center(
        child: Image.asset(
          'lib/assets/logo/app_logo.png',
          width: 130.21,
          height: 37.94,
        ),
      ),
    );
  }
}
