import 'dart:ui' show Color;

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart' show Colors;

import 'era_accent_color.dart';

class EraThemeData extends Equatable {
  final Color primaryColor;
  final Color textColor;
  final Color secondaryTextColor;
  final Color tertiaryTextColor;
  final Color accentColor;
  final Color backgroundColor;
  final Color deepBackgroundColor;
  final Color surfaceColor;
  final Color secondarySurfaceColor;
  final String? fontFamily;

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
    this.fontFamily,
  });

  factory EraThemeData.dark({String? fontFamily}) {
    return EraThemeData(
      primaryColor: Colors.black,
      textColor: Colors.white,
      secondaryTextColor: const Color(0xFF7D7D7D),
      tertiaryTextColor: const Color(0xFF4F4F4F),
      accentColor: EraAccentColor.green.color,
      surfaceColor: const Color(0xFF1e1e1e),
      backgroundColor: const Color(0xFF191919),
      deepBackgroundColor: const Color(0xFF0e0e0e),
      secondarySurfaceColor: const Color(0xFF2f2f2f),
      fontFamily: fontFamily,
    );
  }

  EraThemeData copyWith({
    Color? primaryColor,
    Color? textColor,
    Color? secondaryTextColor,
    Color? tertiaryTextColor,
    Color? accentColor,
    Color? backgroundColor,
    Color? deepBackgroundColor,
    Color? surfaceColor,
    Color? secondarySurfaceColor,
    String? fontFamily,
  }) {
    return EraThemeData(
      primaryColor: primaryColor ?? this.primaryColor,
      textColor: textColor ?? this.textColor,
      secondaryTextColor: secondaryTextColor ?? this.secondaryTextColor,
      tertiaryTextColor: tertiaryTextColor ?? this.tertiaryTextColor,
      accentColor: accentColor ?? this.accentColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      deepBackgroundColor: deepBackgroundColor ?? this.deepBackgroundColor,
      surfaceColor: surfaceColor ?? this.surfaceColor,
      secondarySurfaceColor:
          secondarySurfaceColor ?? this.secondarySurfaceColor,
      fontFamily: fontFamily ?? this.fontFamily,
    );
  }

  @override
  List<Object?> get props => [
        primaryColor,
        textColor,
        secondaryTextColor,
        tertiaryTextColor,
        accentColor,
        backgroundColor,
        deepBackgroundColor,
        surfaceColor,
        secondarySurfaceColor,
        fontFamily,
      ];
}
