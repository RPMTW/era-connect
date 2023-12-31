import 'dart:ui';

import 'package:era_connect_ui/era_connect_ui.dart' show EraAccentColor;
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Check accent colors', () {
    test('green color', () {
      expect(EraAccentColor.green.color, equals(const Color(0xFF14ae5c)));
    });

    test('blue color', () {
      expect(EraAccentColor.blue.color, equals(const Color(0xFF7caed3)));
    });

    test('yellow color', () {
      expect(EraAccentColor.yellow.color, equals(const Color(0xFFd3e950)));
    });

    test('purple color', () {
      expect(EraAccentColor.purple.color, equals(const Color(0xFF9747FF)));
    });
  });
}
