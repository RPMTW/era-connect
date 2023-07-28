import 'package:era_connect_i18n/i18n_locale.dart';
import 'package:era_connect_i18n/i18n_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import 'i18n_manager_test.mocks.dart';

@GenerateNiceMocks(
    [MockSpec<AssetBundle>(onMissingStub: OnMissingStub.throwException)])
void main() {
  group('I18nManager', () {
    test('loads translations from JSON files', () async {
      // Arrange
      final i18nManager = I18nManager(
        path: 'assets/i18n',
        defaultLocale: I18nLocale.americanEnglish,
      );
      final mockAssetBundle = MockAssetBundle();
      const jsonString = '{"hello": "Hello", "world": "World"}';

      when(mockAssetBundle.loadString('assets/i18n/en-US.json'))
          .thenAnswer((_) => Future.value(jsonString));
      when(mockAssetBundle.loadString('assets/i18n/zh-TW.json'))
          .thenAnswer((_) => Future.value('{}'));

      // Act
      await i18nManager.load(mockAssetBundle);

      // Assert
      expect(i18nManager.defaultLocale, equals(I18nLocale.americanEnglish));
      expect(i18nManager['hello'], equals('Hello'));
      expect(i18nManager['world'], equals('World'));
    });

    test('returns the key if no translation is found', () async {
      // Arrange
      final i18nManager = I18nManager(
        path: 'assets/i18n',
        defaultLocale: I18nLocale.americanEnglish,
      );

      final mockAssetBundle = MockAssetBundle();
      when(mockAssetBundle.loadString('assets/i18n/en-US.json'))
          .thenAnswer((_) => Future.value('{}'));
      when(mockAssetBundle.loadString('assets/i18n/zh-TW.json'))
          .thenAnswer((_) => Future.value('{}'));

      // Act
      await i18nManager.load(mockAssetBundle);

      // Assert
      expect(i18nManager['missing_key'], equals('missing_key'));
    });

    test('sets the current locale', () {
      // Arrange
      final i18nManager = I18nManager(
        path: 'assets/i18n',
        defaultLocale: I18nLocale.americanEnglish,
      );

      // Act
      i18nManager.setLocale(I18nLocale.traditionalChineseTW);

      // Assert
      expect(i18nManager.locale, equals(I18nLocale.traditionalChineseTW));
    });

    test('notifies listeners when the locale is changed', () {
      // Arrange
      final i18nManager = I18nManager(
        path: 'assets/i18n',
        defaultLocale: I18nLocale.americanEnglish,
      );
      var notified = false;
      i18nManager.addListener(() {
        notified = true;
      });

      // Act
      i18nManager.setLocale(I18nLocale.traditionalChineseTW);

      // Assert
      expect(notified, isTrue);
    });

    testWidgets('get i18n manager from build context', (tester) async {
      // Arrange
      final i18nManager = I18nManager(
        path: 'assets/i18n',
        defaultLocale: I18nLocale.americanEnglish,
      );
      final mockAssetBundle = MockAssetBundle();
      const jsonString = '{"hello": "Hello", "world": "World"}';

      when(mockAssetBundle.loadString('assets/i18n/en-US.json'))
          .thenAnswer((_) => Future.value(jsonString));
      when(mockAssetBundle.loadString('assets/i18n/zh-TW.json'))
          .thenAnswer((_) => Future.value('{}'));

      // Act
      await i18nManager.load(mockAssetBundle);
      await tester.pumpWidget(
        MaterialApp(
            home: ChangeNotifierProvider(
          create: (context) => i18nManager,
          child: Builder(
            builder: (context) {
              final i18nManager = context.i18n;
              return Column(
                children: [
                  Text(i18nManager['hello']),
                  Text(i18nManager['world']),
                ],
              );
            },
          ),
        )),
      );

      // Assert
      expect(find.text('Hello'), findsOneWidget);
      expect(find.text('World'), findsOneWidget);
    });
  });
}
