import 'package:body_house_app/core/theme/colors.dart';
import 'package:body_house_app/layouts/layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '/widgets/app_text.dart';
import '/widgets/gradient_text.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  int _type = 1;
  double _opacity = 1.0;

  void _changeType() async {
    setState(() {
      _opacity = 0.0; // najpierw znika
    });

    // Czekamy na zakończenie animacji znikania
    await Future.delayed(const Duration(milliseconds: 300));

    setState(() {
      _type = _type == 4 ? 1 : _type + 1; // zmieniamy typ
      _opacity = 1.0; // pojawia się ponownie
    });
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      type: _type,
      child: Center(
        child: Column(
          children: [
            GestureDetector(
              onTap: _changeType,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 300),
                opacity: _opacity,
                child: SvgPicture.asset(
                  'assets/images/logo-big.svg',
                  width: 120,
                  height: 120,
                ),
              ),
            ),
            GradientText(
              type: 2,
              child: AppText(
                'Добро пожаловать в Body House!',
                // size: 24,
                // weight: FontWeight.bold,
                align: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
