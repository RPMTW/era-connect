import 'dart:ui' show Color;

/// The accent color for Era Connect.
///
/// Used to make text or interactive elements more prominent in the screen.
/// User can choose the accent color they prefer in the settings.
enum EraAccentColor {
  green(Color(0xFF14ae5c)),
  blue(Color(0xFF7caed3)),
  yellow(Color(0xFFd3e950)),
  purple(Color(0xFF9747FF));

  final Color color;

  const EraAccentColor(this.color);
}
