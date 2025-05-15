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
    // titleLarge: TextStyle(
    //   fontSize: 15,
    //   fontWeight: FontWeight.w600,
    //   color: AppColors.lightText,
    // ),
    titleLarge: TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w600,
      color: AppColors.lightText,
      fontFamily: 'Inter', // tu nadpisujemy font
    ),

    labelLarge: TextStyle(
      fontSize: 13,
      fontWeight: FontWeight.w500,
      color: AppColors.lightText,
      fontFamily: 'Inter', // też używa Inter
    ),
  ),
  scaffoldBackgroundColor: AppColors.background,
);
