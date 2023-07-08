/// An enum that represents the supported locales for the app.
enum I18nLocale {
  americanEnglish('en_us'),
  traditionalChineseTW('zh_tw');

  /// The code for the locale.
  final String code;

  const I18nLocale(this.code);
}
