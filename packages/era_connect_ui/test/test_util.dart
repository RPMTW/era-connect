import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:era_connect_ui/theme/lib.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

Widget baseWidget({required Widget child}) {
  return ChangeNotifierProvider(
    create: (_) => ThemeChangeNotifier(getDefaultTheme),
    child: MaterialApp(
      home: Scaffold(
        body: child,
      ),
    ),
  );
}

EraThemeData getDefaultTheme() => EraThemeData.dark();

Future<void> mouseHover(WidgetTester tester, Finder finder) async {
  final gesture = await tester.createGesture(kind: PointerDeviceKind.mouse);
  await gesture.addPointer(location: Offset.zero);
  addTearDown(gesture.removePointer);
  await tester.pump();
  await gesture.moveTo(tester.getCenter(finder));
  await tester.pumpAndSettle();
}
