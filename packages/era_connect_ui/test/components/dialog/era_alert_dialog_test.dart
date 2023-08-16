import 'package:era_connect_ui/era_connect_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../test_util.dart';

void main() {
  group('EraAlertDialog', () {
    testWidgets('renders correct title, description, content and actions',
        (tester) async {
      // Arrange
      disableOverflowError(tester);
      await tester.pumpWidget(baseWidget(child: Builder(
        builder: (context) {
          return ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => const EraAlertDialog(
                  title: 'Title',
                  description: 'Description',
                  content: Text('Content'),
                  actions: [
                    IconButton(
                      onPressed: null,
                      icon: Icon(Icons.add),
                    ),
                    IconButton(
                      onPressed: null,
                      icon: Icon(Icons.close),
                    ),
                  ],
                ),
              );
            },
            child: const Text('Show Dialog'),
          );
        },
      )));

      // Act
      await tester.tap(find.text('Show Dialog'));
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('Title'), findsOneWidget);
      expect(find.text('Description'), findsOneWidget);
      expect(find.text('Content'), findsOneWidget);
      expect(find.byIcon(Icons.add), findsOneWidget);
      expect(find.byIcon(Icons.close), findsOneWidget);
    });
  });
}
