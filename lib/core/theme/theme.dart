import 'package:flutter/material.dart';
import 'colors.dart';

final ThemeData appTheme = ThemeData(
  fontFamily: 'Montserrat Alternates',
  textTheme: const TextTheme(
    bodyMedium: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w600,
      color: AppColors.white,
    ),
    titleLarge: TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w600,
      color: AppColors.lightText,
    ),
  ),
  scaffoldBackgroundColor: AppColors.background,
);
