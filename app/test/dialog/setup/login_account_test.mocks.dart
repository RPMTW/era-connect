// Mocks generated by Mockito 5.4.2 from annotations
// in era_connect/test/dialog/setup/login_account_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i8;

import 'package:era_connect/api/gen/bridge_definitions.dart' as _i7;
import 'package:era_connect/api/gen/bridge_generated.dart' as _i9;
import 'package:era_connect/api/storage/account_storage.dart' as _i3;
import 'package:era_connect/api/storage/storage_api.dart' as _i6;
import 'package:era_connect/api/storage/ui_layout.dart' as _i2;
import 'package:flutter_rust_bridge/flutter_rust_bridge.dart' as _i5;
import 'package:mockito/mockito.dart' as _i1;
import 'package:mockito/src/dummies.dart' as _i10;
import 'package:uuid/uuid.dart' as _i4;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeUILayoutStorage_0 extends _i1.SmartFake
    implements _i2.UILayoutStorage {
  _FakeUILayoutStorage_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeAccountStorage_1 extends _i1.SmartFake
    implements _i3.AccountStorage {
  _FakeAccountStorage_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeUuidValue_2 extends _i1.SmartFake implements _i4.UuidValue {
  _FakeUuidValue_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeFlutterRustBridgeTaskConstMeta_3 extends _i1.SmartFake
    implements _i5.FlutterRustBridgeTaskConstMeta {
  _FakeFlutterRustBridgeTaskConstMeta_3(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [StorageApi].
///
/// See the documentation for Mockito's code generation for more information.
class MockStorageApi extends _i1.Mock implements _i6.StorageApi {
  MockStorageApi() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.UILayoutStorage get uiLayout => (super.noSuchMethod(
        Invocation.getter(#uiLayout),
        returnValue: _FakeUILayoutStorage_0(
          this,
          Invocation.getter(#uiLayout),
        ),
      ) as _i2.UILayoutStorage);

  @override
  _i3.AccountStorage get accountStorage => (super.noSuchMethod(
        Invocation.getter(#accountStorage),
        returnValue: _FakeAccountStorage_1(
          this,
          Invocation.getter(#accountStorage),
        ),
      ) as _i3.AccountStorage);
}

/// A class which mocks [AccountStorage].
///
/// See the documentation for Mockito's code generation for more information.
class MockAccountStorage extends _i1.Mock implements _i3.AccountStorage {
  MockAccountStorage() {
    _i1.throwOnMissingStub(this);
  }

  @override
  List<_i7.MinecraftAccount> get accounts => (super.noSuchMethod(
        Invocation.getter(#accounts),
        returnValue: <_i7.MinecraftAccount>[],
      ) as List<_i7.MinecraftAccount>);

  @override
  _i8.Future<void> removeAccount(_i4.UuidValue? uuid) => (super.noSuchMethod(
        Invocation.method(
          #removeAccount,
          [uuid],
        ),
        returnValue: _i8.Future<void>.value(),
        returnValueForMissingStub: _i8.Future<void>.value(),
      ) as _i8.Future<void>);
}

/// A class which mocks [AccountToken].
///
/// See the documentation for Mockito's code generation for more information.
class MockAccountToken extends _i1.Mock implements _i7.AccountToken {
  MockAccountToken() {
    _i1.throwOnMissingStub(this);
  }

  @override
  String get token => (super.noSuchMethod(
        Invocation.getter(#token),
        returnValue: '',
      ) as String);

  @override
  int get expiresAt => (super.noSuchMethod(
        Invocation.getter(#expiresAt),
        returnValue: 0,
      ) as int);
}

/// A class which mocks [MinecraftSkin].
///
/// See the documentation for Mockito's code generation for more information.
class MockMinecraftSkin extends _i1.Mock implements _i7.MinecraftSkin {
  MockMinecraftSkin() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.UuidValue get id => (super.noSuchMethod(
        Invocation.getter(#id),
        returnValue: _FakeUuidValue_2(
          this,
          Invocation.getter(#id),
        ),
      ) as _i4.UuidValue);

  @override
  String get state => (super.noSuchMethod(
        Invocation.getter(#state),
        returnValue: '',
      ) as String);

  @override
  String get url => (super.noSuchMethod(
        Invocation.getter(#url),
        returnValue: '',
      ) as String);

  @override
  _i7.MinecraftSkinVariant get variant => (super.noSuchMethod(
        Invocation.getter(#variant),
        returnValue: _i7.MinecraftSkinVariant.Classic,
      ) as _i7.MinecraftSkinVariant);
}

/// A class which mocks [NativeImpl].
///
/// See the documentation for Mockito's code generation for more information.
class MockNativeImpl extends _i1.Mock implements _i9.NativeImpl {
  @override
  _i5.FlutterRustBridgeTaskConstMeta get kSetupLoggerConstMeta =>
      (super.noSuchMethod(
        Invocation.getter(#kSetupLoggerConstMeta),
        returnValue: _FakeFlutterRustBridgeTaskConstMeta_3(
          this,
          Invocation.getter(#kSetupLoggerConstMeta),
        ),
        returnValueForMissingStub: _FakeFlutterRustBridgeTaskConstMeta_3(
          this,
          Invocation.getter(#kSetupLoggerConstMeta),
        ),
      ) as _i5.FlutterRustBridgeTaskConstMeta);

  @override
  _i5.FlutterRustBridgeTaskConstMeta get kFetchStateConstMeta =>
      (super.noSuchMethod(
        Invocation.getter(#kFetchStateConstMeta),
        returnValue: _FakeFlutterRustBridgeTaskConstMeta_3(
          this,
          Invocation.getter(#kFetchStateConstMeta),
        ),
        returnValueForMissingStub: _FakeFlutterRustBridgeTaskConstMeta_3(
          this,
          Invocation.getter(#kFetchStateConstMeta),
        ),
      ) as _i5.FlutterRustBridgeTaskConstMeta);

  @override
  _i5.FlutterRustBridgeTaskConstMeta get kWriteStateConstMeta =>
      (super.noSuchMethod(
        Invocation.getter(#kWriteStateConstMeta),
        returnValue: _FakeFlutterRustBridgeTaskConstMeta_3(
          this,
          Invocation.getter(#kWriteStateConstMeta),
        ),
        returnValueForMissingStub: _FakeFlutterRustBridgeTaskConstMeta_3(
          this,
          Invocation.getter(#kWriteStateConstMeta),
        ),
      ) as _i5.FlutterRustBridgeTaskConstMeta);

  @override
  _i5.FlutterRustBridgeTaskConstMeta get kGetUiLayoutStorageConstMeta =>
      (super.noSuchMethod(
        Invocation.getter(#kGetUiLayoutStorageConstMeta),
        returnValue: _FakeFlutterRustBridgeTaskConstMeta_3(
          this,
          Invocation.getter(#kGetUiLayoutStorageConstMeta),
        ),
        returnValueForMissingStub: _FakeFlutterRustBridgeTaskConstMeta_3(
          this,
          Invocation.getter(#kGetUiLayoutStorageConstMeta),
        ),
      ) as _i5.FlutterRustBridgeTaskConstMeta);

  @override
  _i5.FlutterRustBridgeTaskConstMeta get kSetUiLayoutStorageConstMeta =>
      (super.noSuchMethod(
        Invocation.getter(#kSetUiLayoutStorageConstMeta),
        returnValue: _FakeFlutterRustBridgeTaskConstMeta_3(
          this,
          Invocation.getter(#kSetUiLayoutStorageConstMeta),
        ),
        returnValueForMissingStub: _FakeFlutterRustBridgeTaskConstMeta_3(
          this,
          Invocation.getter(#kSetUiLayoutStorageConstMeta),
        ),
      ) as _i5.FlutterRustBridgeTaskConstMeta);

  @override
  _i5.FlutterRustBridgeTaskConstMeta get kGetAccountStorageConstMeta =>
      (super.noSuchMethod(
        Invocation.getter(#kGetAccountStorageConstMeta),
        returnValue: _FakeFlutterRustBridgeTaskConstMeta_3(
          this,
          Invocation.getter(#kGetAccountStorageConstMeta),
        ),
        returnValueForMissingStub: _FakeFlutterRustBridgeTaskConstMeta_3(
          this,
          Invocation.getter(#kGetAccountStorageConstMeta),
        ),
      ) as _i5.FlutterRustBridgeTaskConstMeta);

  @override
  _i5.FlutterRustBridgeTaskConstMeta get kGetSkinFilePathConstMeta =>
      (super.noSuchMethod(
        Invocation.getter(#kGetSkinFilePathConstMeta),
        returnValue: _FakeFlutterRustBridgeTaskConstMeta_3(
          this,
          Invocation.getter(#kGetSkinFilePathConstMeta),
        ),
        returnValueForMissingStub: _FakeFlutterRustBridgeTaskConstMeta_3(
          this,
          Invocation.getter(#kGetSkinFilePathConstMeta),
        ),
      ) as _i5.FlutterRustBridgeTaskConstMeta);

  @override
  _i5.FlutterRustBridgeTaskConstMeta get kRemoveMinecraftAccountConstMeta =>
      (super.noSuchMethod(
        Invocation.getter(#kRemoveMinecraftAccountConstMeta),
        returnValue: _FakeFlutterRustBridgeTaskConstMeta_3(
          this,
          Invocation.getter(#kRemoveMinecraftAccountConstMeta),
        ),
        returnValueForMissingStub: _FakeFlutterRustBridgeTaskConstMeta_3(
          this,
          Invocation.getter(#kRemoveMinecraftAccountConstMeta),
        ),
      ) as _i5.FlutterRustBridgeTaskConstMeta);

  @override
  _i5.FlutterRustBridgeTaskConstMeta get kMinecraftLoginFlowConstMeta =>
      (super.noSuchMethod(
        Invocation.getter(#kMinecraftLoginFlowConstMeta),
        returnValue: _FakeFlutterRustBridgeTaskConstMeta_3(
          this,
          Invocation.getter(#kMinecraftLoginFlowConstMeta),
        ),
        returnValueForMissingStub: _FakeFlutterRustBridgeTaskConstMeta_3(
          this,
          Invocation.getter(#kMinecraftLoginFlowConstMeta),
        ),
      ) as _i5.FlutterRustBridgeTaskConstMeta);

  @override
  _i5.FlutterRustBridgeTaskConstMeta get kGetVanillaVersionsConstMeta =>
      (super.noSuchMethod(
        Invocation.getter(#kGetVanillaVersionsConstMeta),
        returnValue: _FakeFlutterRustBridgeTaskConstMeta_3(
          this,
          Invocation.getter(#kGetVanillaVersionsConstMeta),
        ),
        returnValueForMissingStub: _FakeFlutterRustBridgeTaskConstMeta_3(
          this,
          Invocation.getter(#kGetVanillaVersionsConstMeta),
        ),
      ) as _i5.FlutterRustBridgeTaskConstMeta);

  @override
  _i5.FlutterRustBridgeTaskConstMeta get kCreateCollectionConstMeta =>
      (super.noSuchMethod(
        Invocation.getter(#kCreateCollectionConstMeta),
        returnValue: _FakeFlutterRustBridgeTaskConstMeta_3(
          this,
          Invocation.getter(#kCreateCollectionConstMeta),
        ),
        returnValueForMissingStub: _FakeFlutterRustBridgeTaskConstMeta_3(
          this,
          Invocation.getter(#kCreateCollectionConstMeta),
        ),
      ) as _i5.FlutterRustBridgeTaskConstMeta);

  @override
  _i8.Future<void> setupLogger({dynamic hint}) => (super.noSuchMethod(
        Invocation.method(
          #setupLogger,
          [],
          {#hint: hint},
        ),
        returnValue: _i8.Future<void>.value(),
        returnValueForMissingStub: _i8.Future<void>.value(),
      ) as _i8.Future<void>);

  @override
  _i8.Future<_i7.DownloadState> fetchState({dynamic hint}) =>
      (super.noSuchMethod(
        Invocation.method(
          #fetchState,
          [],
          {#hint: hint},
        ),
        returnValue:
            _i8.Future<_i7.DownloadState>.value(_i7.DownloadState.Downloading),
        returnValueForMissingStub:
            _i8.Future<_i7.DownloadState>.value(_i7.DownloadState.Downloading),
      ) as _i8.Future<_i7.DownloadState>);

  @override
  _i8.Future<void> writeState({
    required _i7.DownloadState? s,
    dynamic hint,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #writeState,
          [],
          {
            #s: s,
            #hint: hint,
          },
        ),
        returnValue: _i8.Future<void>.value(),
        returnValueForMissingStub: _i8.Future<void>.value(),
      ) as _i8.Future<void>);

  @override
  _i7.UILayoutValue getUiLayoutStorage({
    required _i7.UILayoutKey? key,
    dynamic hint,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #getUiLayoutStorage,
          [],
          {
            #key: key,
            #hint: hint,
          },
        ),
        returnValue: _i10.dummyValue<_i7.UILayoutValue>(
          this,
          Invocation.method(
            #getUiLayoutStorage,
            [],
            {
              #key: key,
              #hint: hint,
            },
          ),
        ),
        returnValueForMissingStub: _i10.dummyValue<_i7.UILayoutValue>(
          this,
          Invocation.method(
            #getUiLayoutStorage,
            [],
            {
              #key: key,
              #hint: hint,
            },
          ),
        ),
      ) as _i7.UILayoutValue);

  @override
  _i8.Future<void> setUiLayoutStorage({
    required _i7.UILayoutValue? value,
    dynamic hint,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #setUiLayoutStorage,
          [],
          {
            #value: value,
            #hint: hint,
          },
        ),
        returnValue: _i8.Future<void>.value(),
        returnValueForMissingStub: _i8.Future<void>.value(),
      ) as _i8.Future<void>);

  @override
  _i7.AccountStorageValue getAccountStorage({
    required _i7.AccountStorageKey? key,
    dynamic hint,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #getAccountStorage,
          [],
          {
            #key: key,
            #hint: hint,
          },
        ),
        returnValue: _i10.dummyValue<_i7.AccountStorageValue>(
          this,
          Invocation.method(
            #getAccountStorage,
            [],
            {
              #key: key,
              #hint: hint,
            },
          ),
        ),
        returnValueForMissingStub: _i10.dummyValue<_i7.AccountStorageValue>(
          this,
          Invocation.method(
            #getAccountStorage,
            [],
            {
              #key: key,
              #hint: hint,
            },
          ),
        ),
      ) as _i7.AccountStorageValue);

  @override
  String getSkinFilePath({
    required _i7.MinecraftSkin? skin,
    dynamic hint,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #getSkinFilePath,
          [],
          {
            #skin: skin,
            #hint: hint,
          },
        ),
        returnValue: '',
        returnValueForMissingStub: '',
      ) as String);

  @override
  _i8.Future<void> removeMinecraftAccount({
    required _i4.UuidValue? uuid,
    dynamic hint,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #removeMinecraftAccount,
          [],
          {
            #uuid: uuid,
            #hint: hint,
          },
        ),
        returnValue: _i8.Future<void>.value(),
        returnValueForMissingStub: _i8.Future<void>.value(),
      ) as _i8.Future<void>);

  @override
  _i8.Stream<_i7.LoginFlowEvent> minecraftLoginFlow({dynamic hint}) =>
      (super.noSuchMethod(
        Invocation.method(
          #minecraftLoginFlow,
          [],
          {#hint: hint},
        ),
        returnValue: _i8.Stream<_i7.LoginFlowEvent>.empty(),
        returnValueForMissingStub: _i8.Stream<_i7.LoginFlowEvent>.empty(),
      ) as _i8.Stream<_i7.LoginFlowEvent>);

  @override
  _i8.Future<List<_i7.VersionMetadata>> getVanillaVersions({dynamic hint}) =>
      (super.noSuchMethod(
        Invocation.method(
          #getVanillaVersions,
          [],
          {#hint: hint},
        ),
        returnValue: _i8.Future<List<_i7.VersionMetadata>>.value(
            <_i7.VersionMetadata>[]),
        returnValueForMissingStub: _i8.Future<List<_i7.VersionMetadata>>.value(
            <_i7.VersionMetadata>[]),
      ) as _i8.Future<List<_i7.VersionMetadata>>);

  @override
  _i8.Future<void> createCollection({
    required String? displayName,
    required _i7.VersionMetadata? versionMetadata,
    _i7.ModLoader? modLoader,
    _i7.AdvancedOptions? advancedOptions,
    dynamic hint,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #createCollection,
          [],
          {
            #displayName: displayName,
            #versionMetadata: versionMetadata,
            #modLoader: modLoader,
            #advancedOptions: advancedOptions,
            #hint: hint,
          },
        ),
        returnValue: _i8.Future<void>.value(),
        returnValueForMissingStub: _i8.Future<void>.value(),
      ) as _i8.Future<void>);

  @override
  void dispose() => super.noSuchMethod(
        Invocation.method(
          #dispose,
          [],
        ),
        returnValueForMissingStub: null,
      );
}
