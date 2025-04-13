import 'package:body_house_app/route_generator.dart';
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
      onGenerateRoute: RouteGenerator.generateRoute,
      theme: appTheme,
      title: 'Body House',

      // home: const SplashScreen(),
      home: const SplashScreen(),
    );
  }
}
