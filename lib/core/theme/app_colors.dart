import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Primary Blue
  static const Color primaryBlue = Color(0xFF2563EB);
  static const Color primaryBlueLight = Color(0xFF3B82F6);
  static const Color primaryBlueDark = Color(0xFF1D4ED8);
  static const Color primaryBlueSoft = Color(0xFFDBEAFE);
  static const Color primaryBlueBg = Color(0xFFEFF6FF);

  // Success Green
  static const Color successGreen = Color(0xFF16A34A);
  static const Color successGreenLight = Color(0xFF22C55E);
  static const Color successGreenDark = Color(0xFF15803D);
  static const Color successGreenSoft = Color(0xFFDCFCE7);
  static const Color successGreenBg = Color(0xFFF0FDF4);

  // Warning Amber
  static const Color warningAmber = Color(0xFFD97706);
  static const Color warningAmberLight = Color(0xFFF59E0B);
  static const Color warningAmberDark = Color(0xFFB45309);
  static const Color warningAmberSoft = Color(0xFFFEF3C7);
  static const Color warningAmberBg = Color(0xFFFFFBEB);

  // Error Red
  static const Color errorRed = Color(0xFFDC2626);
  static const Color errorRedLight = Color(0xFFEF4444);
  static const Color errorRedDark = Color(0xFFB91C1C);
  static const Color errorRedSoft = Color(0xFFFEE2E2);
  static const Color errorRedBg = Color(0xFFFEF2F2);

  // Neutral
  static const Color neutral50 = Color(0xFFFAFAFA);
  static const Color neutral100 = Color(0xFFF5F5F5);
  static const Color neutral200 = Color(0xFFE5E5E5);
  static const Color neutral300 = Color(0xFFD4D4D4);
  static const Color neutral400 = Color(0xFFA3A3A3);
  static const Color neutral500 = Color(0xFF737373);
  static const Color neutral600 = Color(0xFF525252);
  static const Color neutral700 = Color(0xFF404040);
  static const Color neutral800 = Color(0xFF262626);
  static const Color neutral900 = Color(0xFF171717);
  static const Color neutral950 = Color(0xFF0A0A0A);

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF2563EB), Color(0xFF7C3AED)],
  );

  static const LinearGradient successGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF16A34A), Color(0xFF06B6D4)],
  );

  static const LinearGradient warningGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFD97706), Color(0xFFF59E0B)],
  );

  // Special
  static const Color glass = Color(0x80FFFFFF);
  static const Color glassDark = Color(0x80000000);
  static const Color overlay = Color(0x52000000);
  static const Color splash = Color(0x1A2563EB);
}
