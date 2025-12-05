import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_typography.dart';

/// ConnectMe App Theme
/// Provides light and dark theme configurations
class AppTheme {
  // Prevent instantiation
  AppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: AppColors.lightPrimary,
    scaffoldBackgroundColor: AppColors.lightBackground,
    colorScheme: const ColorScheme.light(
      primary: AppColors.lightPrimary,
      secondary: AppColors.lightSecondary,
      surface: AppColors.lightSurface,
      error: AppColors.lightError,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: AppColors.lightText,
      onError: Colors.white,
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontSize: AppTypography.font3XL,
        fontWeight: FontWeight.w700,
        color: AppColors.lightText,
        height: AppTypography.lineHeightTight,
      ),
      displayMedium: TextStyle(
        fontSize: AppTypography.font2XL,
        fontWeight: FontWeight.w700,
        color: AppColors.lightText,
        height: AppTypography.lineHeightTight,
      ),
      displaySmall: TextStyle(
        fontSize: AppTypography.fontXL,
        fontWeight: FontWeight.w700,
        color: AppColors.lightText,
        height: AppTypography.lineHeightNormal,
      ),
      headlineMedium: TextStyle(
        fontSize: AppTypography.fontLG,
        fontWeight: FontWeight.w600,
        color: AppColors.lightText,
        height: AppTypography.lineHeightNormal,
      ),
      bodyLarge: TextStyle(
        fontSize: AppTypography.fontBase,
        fontWeight: FontWeight.w400,
        color: AppColors.lightText,
        height: AppTypography.lineHeightNormal,
      ),
      bodyMedium: TextStyle(
        fontSize: AppTypography.fontSM,
        fontWeight: FontWeight.w400,
        color: AppColors.lightTextSecondary,
        height: AppTypography.lineHeightNormal,
      ),
      bodySmall: TextStyle(
        fontSize: AppTypography.fontXS,
        fontWeight: FontWeight.w400,
        color: AppColors.lightTextTertiary,
        height: AppTypography.lineHeightNormal,
      ),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.lightSurface,
      foregroundColor: AppColors.lightText,
      elevation: 0,
      centerTitle: false,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: AppColors.darkPrimary,
    scaffoldBackgroundColor: AppColors.darkBackground,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.darkPrimary,
      secondary: AppColors.darkSecondary,
      surface: AppColors.darkSurface,
      error: AppColors.darkError,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: AppColors.darkText,
      onError: Colors.white,
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontSize: AppTypography.font3XL,
        fontWeight: FontWeight.w700,
        color: AppColors.darkText,
        height: AppTypography.lineHeightTight,
      ),
      displayMedium: TextStyle(
        fontSize: AppTypography.font2XL,
        fontWeight: FontWeight.w700,
        color: AppColors.darkText,
        height: AppTypography.lineHeightTight,
      ),
      displaySmall: TextStyle(
        fontSize: AppTypography.fontXL,
        fontWeight: FontWeight.w700,
        color: AppColors.darkText,
        height: AppTypography.lineHeightNormal,
      ),
      headlineMedium: TextStyle(
        fontSize: AppTypography.fontLG,
        fontWeight: FontWeight.w600,
        color: AppColors.darkText,
        height: AppTypography.lineHeightNormal,
      ),
      bodyLarge: TextStyle(
        fontSize: AppTypography.fontBase,
        fontWeight: FontWeight.w400,
        color: AppColors.darkText,
        height: AppTypography.lineHeightNormal,
      ),
      bodyMedium: TextStyle(
        fontSize: AppTypography.fontSM,
        fontWeight: FontWeight.w400,
        color: AppColors.darkTextSecondary,
        height: AppTypography.lineHeightNormal,
      ),
      bodySmall: TextStyle(
        fontSize: AppTypography.fontXS,
        fontWeight: FontWeight.w400,
        color: AppColors.darkTextTertiary,
        height: AppTypography.lineHeightNormal,
      ),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.darkSurface,
      foregroundColor: AppColors.darkText,
      elevation: 0,
      centerTitle: false,
    ),
  );
}
