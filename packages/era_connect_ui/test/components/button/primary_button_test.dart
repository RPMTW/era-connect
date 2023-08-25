import 'package:era_connect_ui/components/buttons/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../test_util.dart';

void main() {
  group('EraPrimaryButton', () {
    testWidgets('renders with correct text', (tester) async {
      // Arrange & Act
      await tester.pumpWidget(baseWidget(
        child: EraPrimaryButton.text(
          text: 'Click me!',
          onPressed: () {},
        ),
      ));

      // Assert
      expect(find.text('Click me!'), findsOneWidget);
    });

    testWidgets('renders with correct icon', (tester) async {
      // Arrange & Act
      await tester.pumpWidget(baseWidget(
        child: EraPrimaryButton.icon(
          icon: const Icon(Icons.check_rounded),
          onPressed: () {},
        ),
      ));

      // Assert
      expect(find.byIcon(Icons.check_rounded), findsOneWidget);
    });

    testWidgets('calls onTap when button is tapped', (tester) async {
      // Arrange
      var tapped = false;
      await tester.pumpWidget(
        baseWidget(
          child: EraPrimaryButton.text(
            text: 'Click me!',
            onPressed: () => tapped = true,
          ),
        ),
      );

      // Act
      await tester.tap(find.text('Click me!'));
      await tester.pumpAndSettle();

      // Assert
      expect(tapped, isTrue);
    });

    testWidgets('changes background color on hover', (tester) async {
      // Arrange
      await tester.pumpWidget(
        baseWidget(
          child: EraPrimaryButton.text(
            text: 'Click me!',
            onPressed: () {},
          ),
        ),
      );
      final beforeColor = getDecorationColor(tester)!;

      // Act
      await mouseHover(tester, find.text('Click me!'));
      final afterColor = getDecorationColor(tester)!;

      // Assert
      expect(beforeColor, isNot(equals(afterColor)));
    });

    testWidgets('the button background color should be surface color',
        (tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        baseWidget(
          child: EraPrimaryButton.text(
            text: 'Click me!',
            onPressed: () {},
          ),
        ),
      );
      final backgroundColor = getDecorationColor(tester)!;

      // Assert
      expect(backgroundColor, equals(getDefaultTheme().surfaceColor));
    });

    testWidgets('the button hover color should be accent color',
        (tester) async {
      // Arrange
      await tester.pumpWidget(
        baseWidget(
          child: EraPrimaryButton.text(
            text: 'Click me!',
            onPressed: () {},
          ),
        ),
      );

      // Act
      await mouseHover(tester, find.text('Click me!'));
      final hoverColor = getDecorationColor(tester)!;

      // Assert
      expect(hoverColor, equals(getDefaultTheme().accentColor));
    });
  });
}
