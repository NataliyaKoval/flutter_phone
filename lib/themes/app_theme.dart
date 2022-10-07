import 'package:flutter/material.dart';

import '../consts/app_colors.dart';

class AppTheme {
  ThemeData lightTheme = ThemeData(
    backgroundColor: AppColors.blue,

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
          const EdgeInsets.all(15.0),
        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
        ),
        elevation: MaterialStateProperty.resolveWith<double>(
          (Set<MaterialState> states) {
            return 0;
          },
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: AppColors.lightBlue,
      filled: true,
      contentPadding:
          const EdgeInsets.symmetric(vertical: 14.0, horizontal: 12.0),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      hintStyle: const TextStyle(
        color: AppColors.hintColor,
        fontSize: 16.0,
        fontWeight: FontWeight.w500,
      ),
    ),

    textTheme: const TextTheme(
      headline1: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        color: AppColors.white,
      ),
      button: TextStyle(
        color: AppColors.buttonTextColor,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      )
    ),
  );
}
