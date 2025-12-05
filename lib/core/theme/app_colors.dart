import 'package:flutter/material.dart';

/// ConnectMe App Color System
/// Provides light and dark theme colors with precise design specifications
class AppColors {
  // Prevent instantiation
  AppColors._();

  // Light Theme Colors
  static const Color lightPrimary = Color(0xFFFF6B6B); // coral red
  static const Color lightPrimaryHover = Color(0xFFFF5252); // darker coral
  static const Color lightSecondary = Color(0xFF4ECDC4); // turquoise
  static const Color lightAccent = Color(0xFFFFE66D); // warm yellow
  static const Color lightBackground = Color(0xFFFAFAFA); // off-white
  static const Color lightSurface = Color(0xFFFFFFFF); // white
  static const Color lightSurfaceElevated = Color(0xFFFFFFFF); // white
  static const Color lightText = Color(0xFF2D3436); // dark gray
  static const Color lightTextSecondary = Color(0xFF636E72); // medium gray
  static const Color lightTextTertiary = Color(0xFFB2BEC3); // light gray
  static const Color lightBorder = Color(0xFFE8ECEF); // very light gray
  static const Color lightSuccess = Color(0xFF00B894); // green
  static const Color lightError = Color(0xFFFF6B6B); // coral red

  // Dark Theme Colors
  static const Color darkPrimary = Color(0xFFFF8E8E); // lighter coral
  static const Color darkPrimaryHover = Color(0xFFFFA3A3); // even lighter coral
  static const Color darkSecondary = Color(0xFF5DD9D1); // lighter turquoise
  static const Color darkAccent = Color(0xFFFFE66D); // warm yellow - same
  static const Color darkBackground = Color(0xFF0F1419); // very dark blue-black
  static const Color darkSurface = Color(0xFF1A1F2E); // dark blue-gray
  static const Color darkSurfaceElevated = Color(
    0xFF252B3B,
  ); // lighter dark blue-gray
  static const Color darkText = Color(0xFFE8ECEF); // light gray
  static const Color darkTextSecondary = Color(0xFFB2BEC3); // medium gray
  static const Color darkTextTertiary = Color(0xFF636E72); // darker gray
  static const Color darkBorder = Color(0xFF2D3748); // dark border
  static const Color darkSuccess = Color(0xFF00B894); // green - same
  static const Color darkError = Color(0xFFFF8E8E); // lighter coral

  // Shadow Colors
  static List<BoxShadow> lightShadowSmall = [
    BoxShadow(
      color: const Color(0xFFFF6B6B).withValues(alpha: 0.08),
      offset: const Offset(0, 2),
      blurRadius: 8,
    ),
  ];

  static List<BoxShadow> lightShadowMedium = [
    BoxShadow(
      color: const Color(0xFFFF6B6B).withValues(alpha: 0.12),
      offset: const Offset(0, 4),
      blurRadius: 16,
    ),
  ];

  static List<BoxShadow> lightShadowLarge = [
    BoxShadow(
      color: const Color(0xFFFF6B6B).withValues(alpha: 0.16),
      offset: const Offset(0, 8),
      blurRadius: 32,
    ),
  ];

  static List<BoxShadow> darkShadowSmall = [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.3),
      offset: const Offset(0, 2),
      blurRadius: 8,
    ),
  ];

  static List<BoxShadow> darkShadowMedium = [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.4),
      offset: const Offset(0, 4),
      blurRadius: 16,
    ),
  ];

  static List<BoxShadow> darkShadowLarge = [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.5),
      offset: const Offset(0, 8),
      blurRadius: 32,
    ),
  ];
}
