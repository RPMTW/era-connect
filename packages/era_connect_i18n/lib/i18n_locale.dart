import 'package:flutter/widgets.dart';

/// An enum that represents the supported locales for the app.
enum I18nLocale {
  americanEnglish('en-US'),
  traditionalChineseTW('zh-TW');

  /// The code for the locale.
  final String code;

  const I18nLocale(this.code);

  static I18nLocale getFromSystemLocale() {
    final systemLocale = WidgetsBinding.instance.platformDispatcher.locale;
    final languageTag = systemLocale.toLanguageTag();

    return I18nLocale.values.firstWhere(
      (locale) => locale.code == languageTag,
      orElse: () => I18nLocale.americanEnglish,
    );
  }
}
