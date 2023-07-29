import 'package:era_connect_ui/components/misc/era_brand_text.dart';
import 'package:era_connect_ui/components/misc/era_logo.dart';
import 'package:era_connect_ui/components/title_bar/era_title_bar.dart';
import 'package:era_connect_ui/components/title_bar/era_title_bar_action.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../test_util.dart';

void main() {
  group('EraTitleBar', () {
    testWidgets(
      'displays title and actions on non-macOS platforms',
      (tester) async {
        // Arrange & Act
        await tester.pumpWidget(baseWidget(child: const EraTitleBar()));
        await tester.pumpAndSettle();

        // Assert
        expect(find.byType(EraLogo), findsOneWidget);
        expect(find.byType(EraBrandText), findsOneWidget);
        expect(find.byType(EraTitleBarAction), findsNWidgets(3));
      },
      variant: TargetPlatformVariant.all(
        excluding: {TargetPlatform.macOS},
      ),
    );

    testWidgets(
      'displays centered title on macOS platform',
      (tester) async {
        // Arrange & Act
        await tester.pumpWidget(baseWidget(child: const EraTitleBar()));
        await tester.pumpAndSettle();

        // Assert
        expect(find.byType(EraLogo), findsOneWidget);
        expect(find.byType(EraBrandText), findsOneWidget);
        expect(find.byType(Center), findsOneWidget);
        expect(find.byType(EraTitleBarAction), findsNothing);
      },
      variant: TargetPlatformVariant.only(TargetPlatform.macOS),
    );

    testWidgets('title bar is on the top of the app', (tester) async {
      // Arrange & Act
      await tester.pumpWidget(baseWidget(child: const EraTitleBar()));
      await tester.pumpAndSettle();

      // Assert
      final titleBar = tester.widget<Positioned>(
        find
            .descendant(
                of: find.byType(Overlay), matching: find.byType(Positioned))
            .first,
      );
      expect(titleBar.top, 0);
    });
  });
}
