import 'package:favoritospix/utils/app_colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get theme => ThemeData(
        scaffoldBackgroundColor: AppColors.bgColor,
        colorScheme: colorScheme,
        useMaterial3: true,
      );

  static ColorScheme get colorScheme => const ColorScheme(
        brightness: Brightness.dark,
        primary: AppColors.bgColor,
        onPrimary: Colors.white,
        secondary: Colors.black,
        onSecondary: Colors.white,
        error: Colors.red,
        onError: Colors.white,
        background: AppColors.bgColor,
        onBackground: Colors.white,
        surface: Colors.white,
        onSurface: Colors.red,
      );
}
