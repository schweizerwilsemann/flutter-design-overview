import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'screens/splash_screen.dart'; // Assuming this is your splash screen file

class MyApp extends StatelessWidget {
  final FluroRouter router;

  const MyApp({super.key, required this.router});

  static void setupRouter(FluroRouter router) {
    // Define the route for splash screen
    router.define('/', handler: Handler(
        handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
      return const SplashScreen();
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
      initialRoute: '/', // Set initial route to splash screen
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
