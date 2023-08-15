import 'package:era_connect/api/config/config_api.dart';
import 'package:era_connect/api/config/ui_layout.dart';
import 'package:era_connect/dialog/setup_dialog.dart';
import 'package:era_connect/pages/main_page.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../test_util.dart';
import 'main_page_test.mocks.dart';

@GenerateMocks([UILayoutConfig])
void main() {
  testWidgets('show the setup dialog when the setup isn\'t completed',
      (tester) async {
    // Arrange
    disableOverflowError(tester);
    configApi.uiLayout = MockUILayoutConfig();
    when(configApi.uiLayout.completedSetup).thenReturn(false);

    // Act
    await tester.pumpWidget(baseWidget(child: const MainPage()));

    await tester.pumpAndSettle();

    // Assert
    expect(find.byType(MainPage), findsOneWidget);
    expect(find.byType(SetupDialog), findsOneWidget);
  });
}
