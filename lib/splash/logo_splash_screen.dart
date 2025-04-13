import 'package:flutter/material.dart';
import '../core/theme/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:ui';

class LogoSplashScreen extends StatelessWidget {
  const LogoSplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Twoje tło — np. obraz lub kolor
          Positioned(
            top: -200,
            left: -250,
            child: Image.asset(
              'assets/images/ellipse.png',
              width: 600,
              height: 600,
            ),
          ),
          // Dolny prawy ellipse
          Positioned(
            bottom: -100,
            right: -200,
            child: Image.asset(
              'assets/images/ellipse.png',
              width: 600,
              height: 600,
            ),
          ),

          // Rozmycie nałożone na tło
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
              child: Container(
                color:
                    Colors.transparent, // musi być tu coś, by filtr zadziałał
              ),
            ),
          ),

          // Reszta UI
          Center(
            child: SvgPicture.asset(
              'assets/images/logo-big.svg',
              width: 120,
              height: 120,
            ),
          ),
        ],
      ),
    );
  }
}
