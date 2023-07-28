import 'package:era_connect_i18n/i18n_locale.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'dart:ui' as ui;

import 'i18n_locale_test.mocks.dart';

@GenerateMocks([ui.PlatformDispatcher])
void main() {
  group('I18nLocale', () {
    test(
        'getFromSystemLocale returns americanEnglish when system locale is not supported',
        () {
      final mockPlatformDispatcher = MockPlatformDispatcher();
      when(mockPlatformDispatcher.locale).thenReturn(Locale('fr', 'FR'));

      final result = I18nLocale.getFromSystemLocale(mockPlatformDispatcher);

      expect(result, I18nLocale.americanEnglish);
    });

    test(
        'getFromSystemLocale returns the correct locale when system locale is supported',
        () {
      final mockPlatformDispatcher = MockPlatformDispatcher();
      when(mockPlatformDispatcher.locale).thenReturn(Locale('zh', 'TW'));

      final result = I18nLocale.getFromSystemLocale(mockPlatformDispatcher);

      expect(result, I18nLocale.traditionalChineseTW);
    });
  });
}
