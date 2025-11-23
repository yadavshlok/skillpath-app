import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryBlue = Color(0xFF4F9CF9);
  static const Color primaryPurple = Color(0xFF9B59B6);
  static const Color gradientStart = Color(0xFF56B4F7);
  static const Color gradientEnd = Color(0xFF9F5FFF);
  static const Color bgLight = Color(0xFFF8F9FA);
  static const Color white = Color(0xFFFFFFFF);
  static const Color textDark = Color(0xFF1E293B);
  static const Color textGrey = Color(0xFF64748B);
  static const Color borderGrey = Color(0xFFE2E8F0);
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFFBBF24);
  static const Color error = Color(0xFFEF4444);

  // Career card colors
  static const Color softwareBlue = Color(0xFF3B82F6);
  static const Color dataPurple = Color(0xFF8B5CF6);
  static const Color cloudGreen = Color(0xFF10B981);
  static const Color securityOrange = Color(0xFFF59E0B);
  static const Color aiPink = Color(0xFFEC4899);
  static const Color webIndigo = Color(0xFF6366F1);

  static LinearGradient primaryGradient = const LinearGradient(
    colors: [gradientStart, gradientEnd],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
}
