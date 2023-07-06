import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'era_theme_data.dart';

/// Provides the Era Connect theme to the widget tree.
class ThemeChangeNotifier extends ChangeNotifier implements ReassembleHandler {
  late EraThemeData _themeData;
  final EraThemeData Function() _getDefaultTheme;

  EraThemeData get themeData => _themeData;

  ThemeChangeNotifier(this._getDefaultTheme) {
    _themeData = _getDefaultTheme();
  }

  void setTheme(EraThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  /// Handle hot reload.
  @override
  void reassemble() {
    _themeData = _getDefaultTheme();
  }
}

/// Quick access to the theme data from the build context.
extension ThemeProviderExtension on BuildContext {
  EraThemeData get theme =>
      Provider.of<ThemeChangeNotifier>(this, listen: false).themeData;
}
