import 'dart:ui' show Color;

/// The accent color for Era Connect.
///
/// Used to make text or interactive elements more prominent in the screen.
/// User can choose the accent color they prefer in the settings.
enum EraAccentColor {
  green(Color(0x0014ae5c)),
  blue(Color(0x007caed3)),
  yellow(Color(0x00d3e950)),
  purple(Color(0x00d3e950));

  final Color color;

  const EraAccentColor(this.color);
}
