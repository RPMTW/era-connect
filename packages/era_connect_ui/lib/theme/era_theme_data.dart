import 'dart:ui' show Color;

import 'package:era_connect_ui/era_connect_ui.dart';
import 'package:flutter/material.dart' show Colors;

class EraThemeData {
  final Color primaryColor;
  final Color textColor;
  final Color secondaryTextColor;
  final Color tertiaryTextColor;
  final Color accentColor;
  final Color backgroundColor;
  final Color surfaceColor;
  final Color secondarySurfaceColor;

  const EraThemeData({
    required this.primaryColor,
    required this.textColor,
    required this.secondaryTextColor,
    required this.tertiaryTextColor,
    required this.accentColor,
    required this.backgroundColor,
    required this.surfaceColor,
    required this.secondarySurfaceColor,
  });
}

final eraDarkTheme = EraThemeData(
  primaryColor: Colors.black,
  textColor: Colors.white,
  secondaryTextColor: const Color(0x004f4f4f),
  tertiaryTextColor: const Color(0x003d3d3d),
  accentColor: EraAccentColor.green.color,
  surfaceColor: const Color(0x001e1e1e),
  backgroundColor: const Color(0x000e0e0e),
  secondarySurfaceColor: const Color(0x002f2f2f),
);
