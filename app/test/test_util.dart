import 'package:era_connect_i18n/era_connect_i18n.dart';
import 'package:flutter/material.dart';
import 'package:era_connect_ui/theme/lib.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

Widget baseWidget({required final Widget child, final EraThemeData? theme}) {
  return MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (_) => ThemeChangeNotifier(
          () => EraThemeData.dark(fontFamily: 'GenSenRounded'),
        ),
      ),
      ChangeNotifierProvider(
        create: (_) => I18nManager(
            path: 'assets/i18n',
            defaultLocale: I18nLocale.traditionalChineseTW),
      )
    ],
    child: MaterialApp(
      home: Scaffold(
        body: child,
      ),
    ),
  );
}

EraThemeData getDefaultTheme() => EraThemeData.dark();

/// This is a bad workaround for overflow errors that only occur in widget tests.
/// Please use with caution and only if you know what you are doing.
// TODO: Use a better solution for overflow errors in widget tests.
void disableOverflowError(WidgetTester tester) {
  tester.view.devicePixelRatio = 1;
  addTearDown(() {
    tester.view.resetDevicePixelRatio();
  });

  final defaultErrorHandler = FlutterError.onError;
  FlutterError.onError = (details) {
    final exception = details.exception;

    if (exception is FlutterError) {
      final isOverflowError = exception.diagnostics.any(
        (node) => node.value.toString().contains(' overflowed by '),
      );
      if (isOverflowError) {
        return;
      }
    }

    defaultErrorHandler?.call(details);
  };
}
