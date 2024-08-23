import 'package:flutter/material.dart';
import 'package:flutter_journey/pages/dashboard_page.dart';
import 'package:flutter_journey/pages/login_page.dart';
import 'pages/splash_page.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized(); // Ensures proper initialization

  // Set the status bar to have a white background and black text
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.white, // Background color of the status bar
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness:
          Brightness.dark, // Text/icon color on the status bar
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SplashPage(),
      routes: {
        '/dashboard': (context) => const DashboardPage(),
        '/login': (context) => const LoginPage(),
      },
    );
  }
}
