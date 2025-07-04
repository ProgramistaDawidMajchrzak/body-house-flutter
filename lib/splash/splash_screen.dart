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
  int _type = 4;
  double _opacity = 1.0;

  void _changeType() async {
    setState(() {
      _opacity = 0.0;
    });

    await Future.delayed(const Duration(milliseconds: 300));

    setState(() {
      _type = _type == 4 ? 1 : _type + 1;
      _opacity = 1.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget _widget;
    switch (_type) {
      case 1:
        _widget = SvgPicture.asset(
          'assets/images/logo1.svg',
          width: 120,
          height: 120,
        );
        break;
      case 2:
        _widget = SvgPicture.asset(
          'assets/images/logo2.svg',
          width: 120,
          height: 120,
        );
        break;
      case 3:
        _widget = SvgPicture.asset(
          'assets/images/logo-big.svg',
          width: 120,
          height: 120,
        );
        break;
      case 4:
        _widget = GradientText(
          type: 2,
          child: AppText(
            'Добро пожаловать в Body House!',
            // size: 24,
            // weight: FontWeight.bold,
            align: TextAlign.center,
          ),
        );
        break;
      default:
        _widget = GradientText(
          type: 2,
          child: AppText(
            'Добро пожаловать в Body House!',
            // size: 24,
            // weight: FontWeight.bold,
            align: TextAlign.center,
          ),
        );
    }
    return Layout(
      type: _type,
      child: GestureDetector(
        onTap: _changeType,
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 300),
          opacity: _opacity,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [_widget],
            ),
          ),
        ),
      ),
    );
  }
}
