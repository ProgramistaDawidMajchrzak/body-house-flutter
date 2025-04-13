import 'package:flutter/material.dart';
import 'dart:ui';
import '../core/theme/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Layout extends StatelessWidget {
  final Widget child;
  final int type;

  const Layout({super.key, required this.child, this.type = 1});

  @override
  Widget build(BuildContext context) {
    Widget typeWidget;

    switch (type) {
      case 1:
        typeWidget = Stack(
          children: [
            Positioned(
              top: 100,
              left: -150,
              child: SvgPicture.asset(
                'assets/images/ellipse.svg',
                width: 500,
                height: 500,
              ),
            ),
            Positioned(
              bottom: -200,
              right: -300,
              child: SvgPicture.asset(
                'assets/images/ellipse.svg',
                width: 500,
                height: 500,
              ),
            ),
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
                child: Container(color: Colors.transparent),
              ),
            ),
            SafeArea(
              child: Padding(padding: const EdgeInsets.all(16.0), child: child),
            ),
          ],
        );
        break;
      case 2:
        typeWidget = Stack(
          children: [
            Positioned(
              top: 200,
              right: -200,
              child: SvgPicture.asset(
                'assets/images/ellipse.svg',
                width: 700,
                height: 700,
              ),
            ),
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
                child: Container(color: Colors.transparent),
              ),
            ),
            SafeArea(
              child: Padding(padding: const EdgeInsets.all(16.0), child: child),
            ),
          ],
        );
        break;
      case 3:
        typeWidget = Stack(
          children: [
            Positioned(
              top: 100,
              left: 250,
              child: SvgPicture.asset(
                'assets/images/ellipse.svg',
                width: 600,
                height: 600,
              ),
            ),
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
                child: Container(color: Colors.transparent),
              ),
            ),
            SafeArea(
              child: Padding(padding: const EdgeInsets.all(16.0), child: child),
            ),
          ],
        );
        break;
      case 4:
        typeWidget = Stack(
          children: [
            Positioned(
              top: 00,
              left: -250,
              child: SvgPicture.asset(
                'assets/images/ellipse.svg',
                width: 600,
                height: 600,
              ),
            ),
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
                child: Container(color: Colors.transparent),
              ),
            ),
            SafeArea(
              child: Padding(padding: const EdgeInsets.all(16.0), child: child),
            ),
          ],
        );
      default:
        typeWidget = const SizedBox();
    }

    return Scaffold(backgroundColor: AppColors.background, body: typeWidget);
  }
}
