import 'package:era_connect_ui/components/dialog/step_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../test_util.dart';

void main() {
  group('StepDialog', () {
    testWidgets('renders with title, description, content, buttons, etc.',
        (tester) async {
      // Arrange
      disableOverflowError(tester);
      final steps = [
        StepData(
          stepName: 'Step 1',
          stepDescription: 'The First Step',
          title: 'Step 1',
          description: 'Hello, World!',
          logoBoxText: 'First',
          contentPages: const [
            Row(
              children: [Text('Test 1'), Icon(Icons.flutter_dash_rounded)],
            ),
          ],
        ),
        StepData(
          stepDescription: 'The Second Step',
          title: 'Step 2',
          description: 'Hello, World!',
          contentPages: [
            const Text('Test 2'),
            const Icon(Icons.flutter_dash_sharp),
          ],
        )
      ];

      await tester.pumpWidget(
        baseWidget(child: Builder(
          builder: (context) {
            return ElevatedButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) => StepDialog(steps: steps));
                },
                child: const Text('Show Dialog'));
          },
        )),
      );

      // Act
      await tester.tap(find.text('Show Dialog'));
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('Step 1'), findsNWidgets(2));
      expect(find.text('Hello, World!'), findsOneWidget);
      expect(find.text('The First Step'), findsOneWidget);
      expect(find.text('First'), findsOneWidget);
      expect(find.text('Test 1'), findsOneWidget);
      expect(find.byIcon(Icons.flutter_dash_rounded), findsOneWidget);
      expect(find.byIcon(Icons.skip_next_rounded), findsOneWidget);
    });

    testWidgets('renders with correct default logo box text', (tester) async {
      // Arrange
      disableOverflowError(tester);
      final steps = [
        StepData(
          stepName: 'Step 1',
          stepDescription: 'The First Step',
          title: 'Step 1',
          description: 'Hello, World!',
          contentPages: const [
            Row(
              children: [Text('Test 1'), Icon(Icons.flutter_dash_rounded)],
            ),
          ],
        ),
        StepData(
          stepDescription: 'The Second Step',
          title: 'Step 2',
          description: 'Hello, World!',
          contentPages: [
            const Text('Test 2'),
            const Icon(Icons.flutter_dash_sharp),
          ],
        )
      ];

      await tester.pumpWidget(
        baseWidget(child: Builder(
          builder: (context) {
            return ElevatedButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) => StepDialog(steps: steps));
                },
                child: const Text('Show Dialog'));
          },
        )),
      );

      // Act
      await tester.tap(find.text('Show Dialog'));
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('01'), findsOneWidget);
    });

    testWidgets(
        'renders with correct content when the previous button is pressed',
        (tester) async {
      // Arrange
      disableOverflowError(tester);
      final steps = [
        StepData(
          stepName: 'Step 1',
          stepDescription: 'The First Step',
          title: 'Step 1',
          description: 'Hello, World!',
          logoBoxText: 'First',
          contentPages: const [
            Row(
              children: [Text('Test 1'), Icon(Icons.flutter_dash_rounded)],
            ),
          ],
        ),
        StepData(
          stepDescription: 'The Second Step',
          title: 'Step 2',
          description: 'Hello, World!',
          contentPages: [
            const Text('Test 2'),
            const Icon(Icons.flutter_dash_sharp),
          ],
        ),
      ];

      await tester.pumpWidget(
        baseWidget(child: Builder(
          builder: (context) {
            return ElevatedButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) => StepDialog(steps: steps));
                },
                child: const Text('Show Dialog'));
          },
        )),
      );

      // Act
      await tester.tap(find.text('Show Dialog'));
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.skip_next_rounded));
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('Step 2'), findsOneWidget);
      expect(find.text('Hello, World!'), findsOneWidget);
      expect(find.text('The Second Step'), findsOneWidget);
      expect(find.text('Test 2'), findsOneWidget);
      expect(find.byIcon(Icons.flutter_dash_rounded), findsNothing);
      expect(find.byIcon(Icons.flutter_dash_sharp), findsNothing);
    });

    testWidgets(
        'renders with correct content when the previous button is pressed',
        (tester) async {
      // Arrange
      disableOverflowError(tester);
      final steps = [
        StepData(
          stepName: 'Step 1',
          stepDescription: 'The First Step',
          title: 'Step 1',
          description: 'Hello, World!',
          logoBoxText: 'First',
          contentPages: const [
            Row(
              children: [Text('Test 1'), Icon(Icons.flutter_dash_rounded)],
            ),
          ],
        ),
        StepData(
          stepDescription: 'The Second Step',
          title: 'Step 2',
          description: 'Hello, World!',
          contentPages: [
            const Text('Test 2'),
            const Icon(Icons.flutter_dash_sharp),
          ],
        ),
      ];

      await tester.pumpWidget(
        baseWidget(child: Builder(
          builder: (context) {
            return ElevatedButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) => StepDialog(steps: steps));
                },
                child: const Text('Show Dialog'));
          },
        )),
      );

      // Act
      await tester.tap(find.text('Show Dialog'));
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.skip_next_rounded));
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.skip_previous_rounded));
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('Step 1'), findsNWidgets(2));
      expect(find.text('Hello, World!'), findsOneWidget);
      expect(find.text('The First Step'), findsOneWidget);
      expect(find.text('Test 1'), findsOneWidget);
      expect(find.byIcon(Icons.flutter_dash_rounded), findsOneWidget);
      expect(find.byIcon(Icons.skip_next_rounded), findsOneWidget);
      expect(find.byIcon(Icons.skip_previous_rounded), findsNothing);
    });

    testWidgets('when the done button is pressed, the dialog will be closed',
        (tester) async {
      // Arrange
      disableOverflowError(tester);
      final steps = [
        StepData(
          stepName: 'Step 1',
          stepDescription: 'The First Step',
          title: 'Step 1',
          description: 'Hello, World!',
          logoBoxText: 'First',
          contentPages: const [
            Row(
              children: [Text('Test 1'), Icon(Icons.flutter_dash_rounded)],
            ),
          ],
        ),
        StepData(
          stepDescription: 'The Second Step',
          title: 'Step 2',
          description: 'Hello, World!',
          contentPages: const [
            Row(
              children: [Text('Test 2'), Icon(Icons.flutter_dash_sharp)],
            ),
          ],
        ),
      ];

      await tester.pumpWidget(
        baseWidget(child: Builder(
          builder: (context) {
            return ElevatedButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) => StepDialog(steps: steps));
                },
                child: const Text('Show Dialog'));
          },
        )),
      );

      // Act
      await tester.tap(find.text('Show Dialog'));
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.skip_next_rounded));
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.check_rounded));
      await tester.pumpAndSettle();

      // Assert
      expect(find.byType(StepDialog), findsNothing);
    });

    testWidgets(
        'if the page contains multiple pieces of content, pressing the next button will switch to the next content."',
        (tester) async {
      // Arrange
      disableOverflowError(tester);
      final steps = [
        StepData(
          stepName: 'Step 1',
          stepDescription: 'The First Step',
          title: 'Step 1',
          description: 'Hello, World!',
          logoBoxText: 'First',
          contentPages: const [
            Row(
              children: [Text('Test 1'), Icon(Icons.flutter_dash_rounded)],
            ),
          ],
        ),
        StepData(
          stepDescription: 'The Second Step',
          title: 'Step 2',
          description: 'Hello, World!',
          contentPages: [
            const Text('Test 2'),
            const Icon(Icons.flutter_dash_sharp),
          ],
        ),
      ];

      await tester.pumpWidget(
        baseWidget(child: Builder(
          builder: (context) {
            return ElevatedButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) => StepDialog(steps: steps));
                },
                child: const Text('Show Dialog'));
          },
        )),
      );

      // Act
      await tester.tap(find.text('Show Dialog'));
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.skip_next_rounded));
      await tester.pumpAndSettle();

      // Act & Assert
      expect(find.text('Test 2'), findsOneWidget);
      expect(find.byIcon(Icons.flutter_dash_sharp), findsNothing);

      await tester.tap(find.byIcon(Icons.skip_next_rounded));
      await tester.pumpAndSettle();

      expect(find.text('Test 2'), findsNothing);
      expect(find.byIcon(Icons.flutter_dash_sharp), findsOneWidget);
    });

    testWidgets(
        'if the page contains multiple pieces of content, pressing the previous button will switch to the previous content',
        (tester) async {
      // Arrange
      disableOverflowError(tester);
      final steps = [
        StepData(
          stepName: 'Step 1',
          stepDescription: 'The First Step',
          title: 'Step 1',
          description: 'Hello, World!',
          logoBoxText: 'First',
          contentPages: const [
            Row(
              children: [Text('Test 1'), Icon(Icons.flutter_dash_rounded)],
            ),
          ],
        ),
        StepData(
          stepDescription: 'The Second Step',
          title: 'Step 2',
          description: 'Hello, World!',
          contentPages: [
            const Text('Test 2'),
            const Icon(Icons.flutter_dash_sharp),
          ],
        ),
      ];

      await tester.pumpWidget(
        baseWidget(child: Builder(
          builder: (context) {
            return ElevatedButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) => StepDialog(steps: steps));
                },
                child: const Text('Show Dialog'));
          },
        )),
      );

      // Act
      await tester.tap(find.text('Show Dialog'));
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.skip_next_rounded));
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.skip_next_rounded));
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.skip_previous_rounded));
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('Test 2'), findsOneWidget);
      expect(find.byIcon(Icons.flutter_dash_sharp), findsNothing);
    });

    testWidgets(
        'when the next/previous button is pressed, the event handler should be called.',
        (tester) async {
      // Arrange
      bool nextEventCalled = false;
      bool previousEventCalled = false;

      disableOverflowError(tester);
      final steps = [
        StepData(
          stepName: 'Step 1',
          stepDescription: 'The First Step',
          title: 'Step 1',
          description: 'Hello, World!',
          logoBoxText: 'First',
          contentPages: const [
            Row(
              children: [Text('Test 1'), Icon(Icons.flutter_dash_rounded)],
            ),
          ],
          onEvent: (event, _) {
            if (event == StepEvent.next) {
              nextEventCalled = true;
            }

            return true;
          },
        ),
        StepData(
          stepDescription: 'The Second Step',
          title: 'Step 2',
          description: 'Hello, World!',
          contentPages: [
            const Text('Test 2'),
            const Icon(Icons.flutter_dash_sharp),
          ],
          onEvent: (event, _) {
            if (event == StepEvent.previous) {
              previousEventCalled = true;
            }

            return true;
          },
        ),
      ];

      await tester.pumpWidget(
        baseWidget(child: Builder(
          builder: (context) {
            return ElevatedButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) => StepDialog(steps: steps));
                },
                child: const Text('Show Dialog'));
          },
        )),
      );

      // Act
      await tester.tap(find.text('Show Dialog'));
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.skip_next_rounded));
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.skip_previous_rounded));
      await tester.pumpAndSettle();

      // Assert
      expect(nextEventCalled, isTrue);
      expect(previousEventCalled, isTrue);
    });
  });
}
