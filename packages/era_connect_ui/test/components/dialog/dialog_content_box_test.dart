import 'package:era_connect_ui/components/dialog/dialog_content_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../test_util.dart';

void main() {
  group('DialogContentBox', () {
    testWidgets('renders title and content', (tester) async {
      // Arrange
      const title = 'Test Title';
      const content = Text('Test Content');

      // Act
      await tester.pumpWidget(
        baseWidget(
          child: const DialogContentBox(title: title, content: content),
        ),
      );

      // Assert
      expect(find.text(title), findsOneWidget);
      expect(find.byWidget(content), findsOneWidget);
    });

    testWidgets('renders with correct colors', (tester) async {
      // Arrange
      const title = 'Test Title';
      const content = Text('Test Content');

      // Act
      await tester.pumpWidget(
        baseWidget(
          theme: getDefaultTheme().copyWith(
            textColor: Colors.green,
            surfaceColor: Colors.blue,
            backgroundColor: Colors.red,
          ),
          child: const DialogContentBox(title: title, content: content),
        ),
      );

      // Assert
      final titleWidget = tester.widget<Text>(find
          .descendant(
            of: find.byType(DialogContentBox),
            matching: find.byType(Text),
          )
          .first);
      final titleContainerColor = getDecorationColor(tester);
      final contentContainerColor = getDecorationColor(tester, index: 1);
      expect(titleWidget.style?.color, equals(Colors.green));
      expect(titleContainerColor, equals(Colors.blue));
      expect(contentContainerColor, equals(Colors.red));
    });
  });
}
