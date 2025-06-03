import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF1976D2);
  static const Color primaryLight = Color(0xFF90CAF9);
  static const Color accent = Color(0xFF42A5F5);
  static const Color background = Colors.white;
  static const Color card = Color(0xFFF5F7FA);
  static const Color textPrimary = Color(0xFF222B45);
  static const Color textSecondary = Color(0xFF8F9BB3);
  static const Color done = Color(0xFF66BB6A);
  static const Color warning = Color(0xFFFFF176);
  static const Color danger = Color(0xFFEF5350);
  static const Color info = Color(0xFF42A5F5);
}

class AppTextStyles {
  static const TextStyle header = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );
  static const TextStyle subtitle = TextStyle(
    fontSize: 15,
    color: AppColors.textSecondary,
  );
  static const TextStyle taskTitle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );
  static const TextStyle taskSubtitle = TextStyle(
    fontSize: 15,
    color: AppColors.textSecondary,
  );
  static const TextStyle button = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );
}

final ThemeData appTheme = ThemeData(
  primaryColor: AppColors.primary,
  scaffoldBackgroundColor: AppColors.background,
  colorScheme: ColorScheme.fromSwatch().copyWith(
    primary: AppColors.primary,
    secondary: AppColors.accent,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      elevation: 2,
      textStyle: AppTextStyles.button,
    ),
  ),
  textTheme: const TextTheme(
    titleLarge: AppTextStyles.header,
    titleMedium: AppTextStyles.subtitle,
    bodyLarge: AppTextStyles.taskTitle,
    bodyMedium: AppTextStyles.taskSubtitle,
    labelLarge: AppTextStyles.button,
  ),
);
