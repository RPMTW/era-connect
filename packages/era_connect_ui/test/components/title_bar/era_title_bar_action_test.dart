import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:era_connect_ui/components/lib.dart';

import '../../test_util.dart';

void main() {
  const MethodChannel channel = MethodChannel('window_manager');

  group('EraTitleBarAction', () {
    setUp(() {
      TestWidgetsFlutterBinding.ensureInitialized();
    });

    testWidgets('minimize button calls windowManager.minimize()',
        (tester) async {
      // Arrange
      bool isCalled = false;
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(channel, (methodCall) async {
        if (methodCall.method == 'minimize') {
          isCalled = true;
        }

        return null;
      });

      // Act
      await tester.pumpWidget(
        baseWidget(child: EraTitleBarAction.minimize()),
      );
      await tester.tap(find.byType(EraTitleBarAction));
      await tester.pumpAndSettle();

      // Assert
      expect(isCalled, true);
    });

    testWidgets(
        'maximize button calls windowManager.maximize() when not already maximized',
        (tester) async {
      // Arrange
      bool isCalled = false;
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(channel, (methodCall) async {
        switch (methodCall.method) {
          case 'maximize':
            isCalled = true;
            break;
          case 'isMaximized':
            return false;
        }

        return null;
      });

      // Act
      await tester.pumpWidget(
        baseWidget(child: EraTitleBarAction.maximize()),
      );
      await tester.tap(find.byType(EraTitleBarAction));
      await tester.pumpAndSettle();

      // Assert
      expect(isCalled, true);
    });

    testWidgets(
        'maximize button calls windowManager.unmaximize() when already maximized',
        (tester) async {
      // Arrange
      bool isCalled = false;
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(channel, (methodCall) async {
        switch (methodCall.method) {
          case 'unmaximize':
            isCalled = true;
            break;
          case 'isMaximized':
            return true;
        }

        return null;
      });

      // Act
      await tester.pumpWidget(
        baseWidget(child: EraTitleBarAction.maximize()),
      );
      await tester.tap(find.byType(EraTitleBarAction));
      await tester.pumpAndSettle();

      // Assert
      expect(isCalled, true);
    });

    testWidgets('close button calls windowManager.close()', (tester) async {
      // Arrange
      bool isCalled = false;
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(channel, (methodCall) async {
        if (methodCall.method == 'close') {
          isCalled = true;
        }

        return null;
      });

      // Act
      await tester.pumpWidget(
        baseWidget(child: EraTitleBarAction.close()),
      );
      await tester.tap(find.byType(EraTitleBarAction));
      await tester.pumpAndSettle();

      // Assert
      expect(isCalled, true);
    });

    testWidgets('background color is red when hovered close button',
        (tester) async {
      // Arrange
      await tester.pumpWidget(
        baseWidget(child: EraTitleBarAction.close()),
      );

      // Act
      await mouseHover(tester, find.byType(EraTitleBarAction));
      await tester.pumpAndSettle();

      // Assert
      expect(
        (find.byWidgetPredicate((widget) =>
            widget is InkResponse &&
            widget.hoverColor == const Color(0xffff0000))),
        findsOneWidget,
      );
    });
  });
}
