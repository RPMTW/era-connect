import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'era_theme_data.dart';

/// Provides the Era Connect theme to the widget tree.
class ThemeProvider extends StatelessWidget {
  final EraThemeData Function() getDefaultTheme;
  final Widget Function(BuildContext context, EraThemeData theme) builder;

  const ThemeProvider(
      {Key? key, required this.getDefaultTheme, required this.builder})
      : super(key: key);

  static ThemeChangeNotifier of(BuildContext context) {
    return Provider.of<ThemeChangeNotifier>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ThemeChangeNotifier>(
        create: (_) => ThemeChangeNotifier(getDefaultTheme),
        child:
            Consumer<ThemeChangeNotifier>(builder: (context, notifier, child) {
          return builder(context, notifier.themeData);
        }));
  }
}

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
  EraThemeData get theme => ThemeProvider.of(this).themeData;
}
