// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'i18n_locale.dart';

/// A class that manages internationalization (i18n) for the app.
class I18nManager extends ChangeNotifier implements ReassembleHandler {
  final String path;
  final I18nLocale defaultLocale;
  final Map<I18nLocale, Map<String, String>> _data = {};
  I18nLocale _locale;

  I18nLocale get locale => _locale;

  /// Returns the translation for the given [key].
  operator [](final String key) {
    final translation = _data[_locale]?[key] ?? _data[defaultLocale]?[key];
    return translation ?? key;
  }

  I18nManager({required this.path, required this.defaultLocale})
      : _locale = defaultLocale;

  /// Initializes the i18n manager by loading the translations from the given [path].
  ///
  /// The [path] should contain JSON files for each supported locale.
  /// The JSON files should have a map of key-value pairs for the translations.
  ///
  /// Example file structure ([path] = `assets/i18n`):
  /// ```
  /// assets/
  ///  i18n/
  ///   en-US.json
  ///   zh-TW.json
  /// ```
  Future<void> load() async {
    _data.clear();

    for (final locale in I18nLocale.values) {
      final json = await rootBundle.loadString('$path/${locale.code}.json');
      final map = jsonDecode(json) as Map<String, dynamic>;

      _data[locale] = map.cast<String, String>();
    }
  }

  /// Sets the current locale to the given [locale].
  void setLocale(final I18nLocale locale) {
    _locale = locale;
    notifyListeners();
  }

  @override
  void reassemble() {
    load();
  }
}

/// Quick access to the theme data from the build context.
extension I18nManagerExtension on BuildContext {
  I18nManager get i18n => Provider.of<I18nManager>(this, listen: false);
}
