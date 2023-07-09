import 'package:flutter_test/flutter_test.dart';
import 'package:era_connect_ui/era_connect_ui.dart'
    show ThemeChangeNotifier, EraThemeData;

void main() {
  group('ThemeProvider', () {
    test('initializes with default theme', () {
      final notifier = ThemeChangeNotifier(() => EraThemeData.dark());

      expect(notifier.themeData, equals(EraThemeData.dark()));
    });

    test('setTheme should updates the theme data', () {
      final notifier = ThemeChangeNotifier(() => EraThemeData.dark());

      final newTheme = EraThemeData.dark().copyWith(
        fontFamily: 'Roboto',
      );
      notifier.setTheme(newTheme);

      expect(notifier.themeData.fontFamily, equals('Roboto'));
      expect(notifier.themeData, equals(newTheme));
    });

    test('setTheme should triggers listener', () {
      final notifier = ThemeChangeNotifier(() => EraThemeData.dark());
      var listenerCalled = false;
      notifier.addListener(() {
        listenerCalled = true;
      });

      notifier.setTheme(EraThemeData.dark());

      expect(listenerCalled, isTrue);
    });

    test('reassemble should refresh the theme data', () {
      bool getThemeCalled = false;
      final newTheme = EraThemeData.dark().copyWith(fontFamily: 'Roboto');
      final notifier = ThemeChangeNotifier(() {
        if (getThemeCalled) {
          return newTheme;
        }

        getThemeCalled = true;
        return EraThemeData.dark();
      });

      notifier.reassemble();

      expect(notifier.themeData.fontFamily, equals('Roboto'));
      expect(notifier.themeData, equals(newTheme));
    });
  });
}
