import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Add this dependency
import 'screens/splash_screen.dart';
import 'screens/onboarding/onboarding_firstpage.dart';

class MyApp extends StatelessWidget {
  final FluroRouter router;

  const MyApp({super.key, required this.router});

  static void setupRouter(FluroRouter router) {
    // Define the route for splash screen
    router.define('/', handler: Handler(
        handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
      return const SplashScreen();
    }));

    // Define the route for onboarding screen
    router.define('/onboarding', handler: Handler(
        handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
      return const OnboardingFirstPage();
    }));

    // Optional: Define a not found handler that redirects to splash
    router.notFoundHandler = Handler(
        handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
      return const SplashScreen();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Your App Name',
      initialRoute: '/', // Always start with splash
      onGenerateRoute: router.generator,
      debugShowCheckedModeBanner: false,
    );
  }
}

void main() {
  final router = FluroRouter();
  MyApp.setupRouter(router);
  runApp(MyApp(router: router));
}
