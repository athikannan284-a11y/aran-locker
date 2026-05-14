import 'package:flutter/material.dart';

class AppColors {
  // Primary Palette
  static const Color background = Color(0xFF050505);
  static const Color primary = Color(0xFF6C3BFF);
  static const Color accent = Color(0xFF00D1FF);
  static const Color secondary = Color(0xFF4169E1);
  static const Color gold = Color(0xFFFFD700);
  static const Color text = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFB0B0B0);

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, secondary],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient accentGradient = LinearGradient(
    colors: [accent, secondary],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient glassGradient = LinearGradient(
    colors: [
      Colors.white10,
      Colors.white05,
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Surface Colors
  static const Color cardBackground = Color(0xFF1A1A1A);
  static const Color glassBorder = Color(0x33FFFFFF);
  static const Color glassBackground = Color(0x1AFFFFFF);
}
