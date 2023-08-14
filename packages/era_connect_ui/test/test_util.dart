import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:era_connect_ui/theme/lib.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

Widget baseWidget({required final Widget child, final EraThemeData? theme}) {
  return ChangeNotifierProvider(
    create: (_) => ThemeChangeNotifier(() {
      if (theme != null) {
        return theme;
      }

      return getDefaultTheme();
    }),
    child: MaterialApp(
      home: Scaffold(
        body: child,
      ),
    ),
  );
}

EraThemeData getDefaultTheme() => EraThemeData.dark();

Future<void> mouseHover(final WidgetTester tester, final Finder finder) async {
  final gesture = await tester.createGesture(kind: PointerDeviceKind.mouse);
  await gesture.addPointer(location: Offset.zero);
  addTearDown(gesture.removePointer);
  await tester.pump();
  await gesture.moveTo(tester.getCenter(finder));
  await tester.pumpAndSettle();
}

Color? getDecorationColor(final WidgetTester tester, {final int index = 0}) {
  int currentIndex = 0;

  for (var widget in tester.allWidgets) {
    if (widget is Container) {
      final decoration = widget.decoration;
      if (decoration is BoxDecoration && decoration.color != null) {
        if (currentIndex == index) {
          return decoration.color!;
        }

        currentIndex++;
      }
    }
  }

  return null;
}

/// This is a bad workaround for overflow errors that only occur in widget tests.
/// Please use with caution and only if you know what you are doing.
// TODO: Use a better solution for overflow errors in widget tests.
void disableOverflowError(WidgetTester tester) {
  tester.view.devicePixelRatio = 1;
  tester.view.physicalSize = const Size(1600, 900);
  addTearDown(() {
    tester.view.resetDevicePixelRatio();
    tester.view.resetPhysicalSize();
  });

  final defaultErrorHandler = FlutterError.onError;
  FlutterError.onError = (details) {
    final exception = details.exception;

    if (exception is FlutterError) {
      final isOverflowError = exception.diagnostics.any(
        (node) => node.value.toString().contains(' overflowed by '),
      );
      if (isOverflowError) {
        print('Overflow error in widget test: ${details.exception}');
        return;
      }
    }

    defaultErrorHandler?.call(details);
  };
}
