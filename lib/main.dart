import 'package:flutter/material.dart';
import 'splash/splash_screen.dart';
import 'splash/logo_splash_screen.dart';
import 'core/theme/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      title: 'Body House',

      // home: const SplashScreen(),
      home: const SplashScreen(),
    );
  }
}
