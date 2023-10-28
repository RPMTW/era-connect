import 'package:era_connect/api/ffi.dart' as ffi;
import 'package:era_connect/api/gen/bridge_generated.dart' as bridge;
import 'package:era_connect/api/lib.dart';
import 'package:era_connect/api/storage/account_storage.dart';
import 'package:era_connect/dialog/setup/login_account.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:uuid/uuid.dart';

import '../../test_util.dart';
import 'login_account_test.mocks.dart';

@GenerateMocks([StorageApi, AccountStorage, AccountToken, MinecraftSkin])
@GenerateNiceMocks([MockSpec<bridge.NativeImpl>()])
void main() {
  testWidgets('renders a login button when the user isn\'t logged in',
      (tester) async {
    // Arrange
    storageApi = MockStorageApi();
    final accountStorage = MockAccountStorage();
    when(storageApi.accountStorage).thenReturn(accountStorage);
    when(accountStorage.accounts).thenReturn(List.empty());

    // Act
    await tester.pumpWidget(baseWidget(child: const LoginAccountStep()));

    // Assert
    expect(find.byKey(const Key('login_account_button')), findsOneWidget);
  });

  testWidgets('renders an account tile when the user is logged in',
      (tester) async {
    // Arrange
    ffi.api = MockNativeImpl();
    storageApi = MockStorageApi();
    final accountStorage = MockAccountStorage();
    const uuid = UuidValue('00000000-0000-0000-0000-000000000000');

    when((ffi.api as MockNativeImpl)
            .getSkinFilePath(skin: anyNamed('skin'), hint: anyNamed('hint')))
        .thenReturn("stuff.png");
    when(storageApi.accountStorage).thenReturn(accountStorage);
    when(accountStorage.mainAccount).thenReturn(uuid);
    when(accountStorage.accounts).thenReturn([
      MinecraftAccount(
        username: 'Steve',
        uuid: uuid,
        accessToken: MockAccountToken(),
        refreshToken: MockAccountToken(),
        skins: [MockMinecraftSkin()],
        capes: [],
      )
    ]);

    // Act
    await tester.pumpWidget(baseWidget(child: const LoginAccountStep()));

    // Assert
    expect(find.byKey(const Key('account_tile')), findsOneWidget);
    expect(find.text('Steve'), findsOneWidget);
    expect(find.byType(Image), findsOneWidget);
  });
}
