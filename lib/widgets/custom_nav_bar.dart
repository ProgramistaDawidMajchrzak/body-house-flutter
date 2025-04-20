import 'dart:ui';
import 'package:body_house_app/core/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomNavBar extends StatelessWidget {
  const CustomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final route = ModalRoute.of(context);
    final currentPath = route?.settings.name ?? '/home';

    return SafeArea(
      top: false,
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(color: Colors.white.withOpacity(0.2)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildIcon(
                  context,
                  currentPath: currentPath,
                  path: '/home',
                  icon: 'home',
                ),
                _buildIcon(
                  context,
                  currentPath: currentPath,
                  path: '/sessions',
                  icon: 'sessions',
                ),
                _buildCenterButton(context),
                _buildIcon(
                  context,
                  currentPath: currentPath,
                  path: '/calendar',
                  icon: 'calendar',
                ),
                _buildIcon(
                  context,
                  currentPath: currentPath,
                  path: '/profile',
                  icon: 'profile',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCenterButton(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.black,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: IconButton(
        icon: const Icon(Icons.add, color: Colors.white),
        onPressed: () {
          Navigator.pushNamed(context, '/shop');
        },
      ),
    );
  }

  Widget _buildIcon(
    BuildContext context, {
    required String currentPath,
    required String path,
    required String icon,
  }) {
    final isActive = currentPath == path;
    return IconButton(
      icon: SvgPicture.asset(
        'assets/nav_icons/$icon${isActive ? "_active" : ""}.svg',
        width: 50,
        height: 50,
      ),
      onPressed: () {
        Navigator.pushNamed(context, path);
      },
    );
  }
}
