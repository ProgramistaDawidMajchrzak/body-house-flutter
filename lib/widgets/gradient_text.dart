import 'package:body_house_app/core/theme/colors.dart';
import 'package:flutter/material.dart';

class GradientText extends StatelessWidget {
  final Widget child;
  final int type;

  const GradientText({super.key, required this.child, this.type = 1});

  @override
  Widget build(BuildContext context) {
    Gradient gradientWidget;
    switch (type) {
      case 1:
        gradientWidget = LinearGradient(
          colors: [AppColors.lighterAccent, AppColors.light],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        );
        break;
      case 2:
        gradientWidget = LinearGradient(
          colors: [AppColors.lighterAccent, Color(0xFF6F619B)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        );
      default:
        gradientWidget = LinearGradient(
          colors: [AppColors.lighterAccent, AppColors.light],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        );
    }
    return ShaderMask(
      shaderCallback:
          (bounds) => gradientWidget.createShader(
            Rect.fromLTWH(0, 0, bounds.width, bounds.height),
          ),
      child: child,
    );
  }
}
