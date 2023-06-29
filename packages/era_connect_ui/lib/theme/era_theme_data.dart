import 'dart:ui' show Color;

import 'package:flutter/material.dart' show Colors;

import 'era_accent_color.dart';

class EraThemeData {
  final Color primaryColor;
  final Color textColor;
  final Color secondaryTextColor;
  final Color tertiaryTextColor;
  final Color accentColor;
  final Color backgroundColor;
  final Color deepBackgroundColor;
  final Color surfaceColor;
  final Color secondarySurfaceColor;

  const EraThemeData({
    required this.primaryColor,
    required this.textColor,
    required this.secondaryTextColor,
    required this.tertiaryTextColor,
    required this.accentColor,
    required this.backgroundColor,
    required this.deepBackgroundColor,
    required this.surfaceColor,
    required this.secondarySurfaceColor,
  });

  factory EraThemeData.dark() {
    return EraThemeData(
      primaryColor: Colors.black,
      textColor: Colors.white,
      secondaryTextColor: const Color(0xFF4f4f4f),
      tertiaryTextColor: const Color(0xFF3d3d3d),
      accentColor: EraAccentColor.green.color,
      surfaceColor: const Color(0xFF1e1e1e),
      backgroundColor: const Color(0xFF0d0d0d),
      deepBackgroundColor: const Color(0xFF0e0e0e),
      secondarySurfaceColor: const Color(0xFF2f2f2f),
    );
  }
}
