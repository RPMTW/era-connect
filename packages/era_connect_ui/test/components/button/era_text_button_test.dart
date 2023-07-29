import 'package:era_connect_ui/components/button/era_text_button.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../test_util.dart';

void main() {
  group('EraTextButton', () {
    testWidgets('renders with correct text', (tester) async {
      // Arrange & Act
      await tester.pumpWidget(baseWidget(
        child: EraTextButton.primary(
          text: 'Click me!',
          onPressed: () {},
        ),
      ));

      // Assert
      expect(find.text('Click me!'), findsOneWidget);
    });

    testWidgets('calls onTap when button is tapped', (tester) async {
      // Arrange
      var tapped = false;
      await tester.pumpWidget(
        baseWidget(
          child: EraTextButton.primary(
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
          child: EraTextButton.primary(
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

    testWidgets('primary button background color should be surface color',
        (tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        baseWidget(
          child: EraTextButton.primary(
            text: 'Click me!',
            onPressed: () {},
          ),
        ),
      );
      final backgroundColor = getDecorationColor(tester)!;

      // Assert
      expect(backgroundColor, equals(getDefaultTheme().surfaceColor));
    });

    testWidgets('primary button hover color should be accent color',
        (tester) async {
      // Arrange
      await tester.pumpWidget(
        baseWidget(
          child: EraTextButton.primary(
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

    testWidgets('secondary button background color should be background color',
        (tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        baseWidget(
          child: EraTextButton.secondary(
            text: 'Click me!',
            onPressed: () {},
          ),
        ),
      );

      final backgroundColor = getDecorationColor(tester);

      // Assert
      expect(backgroundColor, equals(getDefaultTheme().backgroundColor));
    });

    testWidgets('secondary button hover color should be surface color',
        (tester) async {
      // Arrange
      await tester.pumpWidget(
        baseWidget(
          child: EraTextButton.secondary(
            text: 'Click me!',
            onPressed: () {},
          ),
        ),
      );

      // Act
      await mouseHover(tester, find.text('Click me!'));
      final hoverColor = getDecorationColor(tester)!;

      // Assert
      expect(hoverColor, equals(getDefaultTheme().surfaceColor));
    });
  });
}

