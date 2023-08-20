// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bridge_definitions.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$AccountStorageValue {
  Object? get field0 => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<MinecraftAccount> field0) accounts,
    required TResult Function(UuidValue? field0) mainAccount,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<MinecraftAccount> field0)? accounts,
    TResult? Function(UuidValue? field0)? mainAccount,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<MinecraftAccount> field0)? accounts,
    TResult Function(UuidValue? field0)? mainAccount,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AccountStorageValue_Accounts value) accounts,
    required TResult Function(AccountStorageValue_MainAccount value)
        mainAccount,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AccountStorageValue_Accounts value)? accounts,
    TResult? Function(AccountStorageValue_MainAccount value)? mainAccount,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AccountStorageValue_Accounts value)? accounts,
    TResult Function(AccountStorageValue_MainAccount value)? mainAccount,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AccountStorageValueCopyWith<$Res> {
  factory $AccountStorageValueCopyWith(
          AccountStorageValue value, $Res Function(AccountStorageValue) then) =
      _$AccountStorageValueCopyWithImpl<$Res, AccountStorageValue>;
}

/// @nodoc
class _$AccountStorageValueCopyWithImpl<$Res, $Val extends AccountStorageValue>
    implements $AccountStorageValueCopyWith<$Res> {
  _$AccountStorageValueCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$AccountStorageValue_AccountsCopyWith<$Res> {
  factory _$$AccountStorageValue_AccountsCopyWith(
          _$AccountStorageValue_Accounts value,
          $Res Function(_$AccountStorageValue_Accounts) then) =
      __$$AccountStorageValue_AccountsCopyWithImpl<$Res>;
  @useResult
  $Res call({List<MinecraftAccount> field0});
}

/// @nodoc
class __$$AccountStorageValue_AccountsCopyWithImpl<$Res>
    extends _$AccountStorageValueCopyWithImpl<$Res,
        _$AccountStorageValue_Accounts>
    implements _$$AccountStorageValue_AccountsCopyWith<$Res> {
  __$$AccountStorageValue_AccountsCopyWithImpl(
      _$AccountStorageValue_Accounts _value,
      $Res Function(_$AccountStorageValue_Accounts) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? field0 = null,
  }) {
    return _then(_$AccountStorageValue_Accounts(
      null == field0
          ? _value._field0
          : field0 // ignore: cast_nullable_to_non_nullable
              as List<MinecraftAccount>,
    ));
  }
}

/// @nodoc

class _$AccountStorageValue_Accounts implements AccountStorageValue_Accounts {
  const _$AccountStorageValue_Accounts(final List<MinecraftAccount> field0)
      : _field0 = field0;

  final List<MinecraftAccount> _field0;
  @override
  List<MinecraftAccount> get field0 {
    if (_field0 is EqualUnmodifiableListView) return _field0;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_field0);
  }

  @override
  String toString() {
    return 'AccountStorageValue.accounts(field0: $field0)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AccountStorageValue_Accounts &&
            const DeepCollectionEquality().equals(other._field0, _field0));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_field0));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AccountStorageValue_AccountsCopyWith<_$AccountStorageValue_Accounts>
      get copyWith => __$$AccountStorageValue_AccountsCopyWithImpl<
          _$AccountStorageValue_Accounts>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<MinecraftAccount> field0) accounts,
    required TResult Function(UuidValue? field0) mainAccount,
  }) {
    return accounts(field0);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<MinecraftAccount> field0)? accounts,
    TResult? Function(UuidValue? field0)? mainAccount,
  }) {
    return accounts?.call(field0);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<MinecraftAccount> field0)? accounts,
    TResult Function(UuidValue? field0)? mainAccount,
    required TResult orElse(),
  }) {
    if (accounts != null) {
      return accounts(field0);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AccountStorageValue_Accounts value) accounts,
    required TResult Function(AccountStorageValue_MainAccount value)
        mainAccount,
  }) {
    return accounts(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AccountStorageValue_Accounts value)? accounts,
    TResult? Function(AccountStorageValue_MainAccount value)? mainAccount,
  }) {
    return accounts?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AccountStorageValue_Accounts value)? accounts,
    TResult Function(AccountStorageValue_MainAccount value)? mainAccount,
    required TResult orElse(),
  }) {
    if (accounts != null) {
      return accounts(this);
    }
    return orElse();
  }
}

abstract class AccountStorageValue_Accounts implements AccountStorageValue {
  const factory AccountStorageValue_Accounts(
      final List<MinecraftAccount> field0) = _$AccountStorageValue_Accounts;

  @override
  List<MinecraftAccount> get field0;
  @JsonKey(ignore: true)
  _$$AccountStorageValue_AccountsCopyWith<_$AccountStorageValue_Accounts>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AccountStorageValue_MainAccountCopyWith<$Res> {
  factory _$$AccountStorageValue_MainAccountCopyWith(
          _$AccountStorageValue_MainAccount value,
          $Res Function(_$AccountStorageValue_MainAccount) then) =
      __$$AccountStorageValue_MainAccountCopyWithImpl<$Res>;
  @useResult
  $Res call({UuidValue? field0});
}

/// @nodoc
class __$$AccountStorageValue_MainAccountCopyWithImpl<$Res>
    extends _$AccountStorageValueCopyWithImpl<$Res,
        _$AccountStorageValue_MainAccount>
    implements _$$AccountStorageValue_MainAccountCopyWith<$Res> {
  __$$AccountStorageValue_MainAccountCopyWithImpl(
      _$AccountStorageValue_MainAccount _value,
      $Res Function(_$AccountStorageValue_MainAccount) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? field0 = freezed,
  }) {
    return _then(_$AccountStorageValue_MainAccount(
      freezed == field0
          ? _value.field0
          : field0 // ignore: cast_nullable_to_non_nullable
              as UuidValue?,
    ));
  }
}

/// @nodoc

class _$AccountStorageValue_MainAccount
    implements AccountStorageValue_MainAccount {
  const _$AccountStorageValue_MainAccount([this.field0]);

  @override
  final UuidValue? field0;

  @override
  String toString() {
    return 'AccountStorageValue.mainAccount(field0: $field0)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AccountStorageValue_MainAccount &&
            (identical(other.field0, field0) || other.field0 == field0));
  }

  @override
  int get hashCode => Object.hash(runtimeType, field0);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AccountStorageValue_MainAccountCopyWith<_$AccountStorageValue_MainAccount>
      get copyWith => __$$AccountStorageValue_MainAccountCopyWithImpl<
          _$AccountStorageValue_MainAccount>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<MinecraftAccount> field0) accounts,
    required TResult Function(UuidValue? field0) mainAccount,
  }) {
    return mainAccount(field0);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<MinecraftAccount> field0)? accounts,
    TResult? Function(UuidValue? field0)? mainAccount,
  }) {
    return mainAccount?.call(field0);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<MinecraftAccount> field0)? accounts,
    TResult Function(UuidValue? field0)? mainAccount,
    required TResult orElse(),
  }) {
    if (mainAccount != null) {
      return mainAccount(field0);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AccountStorageValue_Accounts value) accounts,
    required TResult Function(AccountStorageValue_MainAccount value)
        mainAccount,
  }) {
    return mainAccount(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AccountStorageValue_Accounts value)? accounts,
    TResult? Function(AccountStorageValue_MainAccount value)? mainAccount,
  }) {
    return mainAccount?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AccountStorageValue_Accounts value)? accounts,
    TResult Function(AccountStorageValue_MainAccount value)? mainAccount,
    required TResult orElse(),
  }) {
    if (mainAccount != null) {
      return mainAccount(this);
    }
    return orElse();
  }
}

abstract class AccountStorageValue_MainAccount implements AccountStorageValue {
  const factory AccountStorageValue_MainAccount([final UuidValue? field0]) =
      _$AccountStorageValue_MainAccount;

  @override
  UuidValue? get field0;
  @JsonKey(ignore: true)
  _$$AccountStorageValue_MainAccountCopyWith<_$AccountStorageValue_MainAccount>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$LoginFlowErrors {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(XstsTokenErrorType field0) xstsError,
    required TResult Function() gameNotOwned,
    required TResult Function() unknownError,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(XstsTokenErrorType field0)? xstsError,
    TResult? Function()? gameNotOwned,
    TResult? Function()? unknownError,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(XstsTokenErrorType field0)? xstsError,
    TResult Function()? gameNotOwned,
    TResult Function()? unknownError,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoginFlowErrors_XstsError value) xstsError,
    required TResult Function(LoginFlowErrors_GameNotOwned value) gameNotOwned,
    required TResult Function(LoginFlowErrors_UnknownError value) unknownError,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoginFlowErrors_XstsError value)? xstsError,
    TResult? Function(LoginFlowErrors_GameNotOwned value)? gameNotOwned,
    TResult? Function(LoginFlowErrors_UnknownError value)? unknownError,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoginFlowErrors_XstsError value)? xstsError,
    TResult Function(LoginFlowErrors_GameNotOwned value)? gameNotOwned,
    TResult Function(LoginFlowErrors_UnknownError value)? unknownError,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoginFlowErrorsCopyWith<$Res> {
  factory $LoginFlowErrorsCopyWith(
          LoginFlowErrors value, $Res Function(LoginFlowErrors) then) =
      _$LoginFlowErrorsCopyWithImpl<$Res, LoginFlowErrors>;
}

/// @nodoc
class _$LoginFlowErrorsCopyWithImpl<$Res, $Val extends LoginFlowErrors>
    implements $LoginFlowErrorsCopyWith<$Res> {
  _$LoginFlowErrorsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$LoginFlowErrors_XstsErrorCopyWith<$Res> {
  factory _$$LoginFlowErrors_XstsErrorCopyWith(
          _$LoginFlowErrors_XstsError value,
          $Res Function(_$LoginFlowErrors_XstsError) then) =
      __$$LoginFlowErrors_XstsErrorCopyWithImpl<$Res>;
  @useResult
  $Res call({XstsTokenErrorType field0});
}

/// @nodoc
class __$$LoginFlowErrors_XstsErrorCopyWithImpl<$Res>
    extends _$LoginFlowErrorsCopyWithImpl<$Res, _$LoginFlowErrors_XstsError>
    implements _$$LoginFlowErrors_XstsErrorCopyWith<$Res> {
  __$$LoginFlowErrors_XstsErrorCopyWithImpl(_$LoginFlowErrors_XstsError _value,
      $Res Function(_$LoginFlowErrors_XstsError) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? field0 = null,
  }) {
    return _then(_$LoginFlowErrors_XstsError(
      null == field0
          ? _value.field0
          : field0 // ignore: cast_nullable_to_non_nullable
              as XstsTokenErrorType,
    ));
  }
}

/// @nodoc

class _$LoginFlowErrors_XstsError implements LoginFlowErrors_XstsError {
  const _$LoginFlowErrors_XstsError(this.field0);

  @override
  final XstsTokenErrorType field0;

  @override
  String toString() {
    return 'LoginFlowErrors.xstsError(field0: $field0)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoginFlowErrors_XstsError &&
            (identical(other.field0, field0) || other.field0 == field0));
  }

  @override
  int get hashCode => Object.hash(runtimeType, field0);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LoginFlowErrors_XstsErrorCopyWith<_$LoginFlowErrors_XstsError>
      get copyWith => __$$LoginFlowErrors_XstsErrorCopyWithImpl<
          _$LoginFlowErrors_XstsError>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(XstsTokenErrorType field0) xstsError,
    required TResult Function() gameNotOwned,
    required TResult Function() unknownError,
  }) {
    return xstsError(field0);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(XstsTokenErrorType field0)? xstsError,
    TResult? Function()? gameNotOwned,
    TResult? Function()? unknownError,
  }) {
    return xstsError?.call(field0);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(XstsTokenErrorType field0)? xstsError,
    TResult Function()? gameNotOwned,
    TResult Function()? unknownError,
    required TResult orElse(),
  }) {
    if (xstsError != null) {
      return xstsError(field0);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoginFlowErrors_XstsError value) xstsError,
    required TResult Function(LoginFlowErrors_GameNotOwned value) gameNotOwned,
    required TResult Function(LoginFlowErrors_UnknownError value) unknownError,
  }) {
    return xstsError(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoginFlowErrors_XstsError value)? xstsError,
    TResult? Function(LoginFlowErrors_GameNotOwned value)? gameNotOwned,
    TResult? Function(LoginFlowErrors_UnknownError value)? unknownError,
  }) {
    return xstsError?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoginFlowErrors_XstsError value)? xstsError,
    TResult Function(LoginFlowErrors_GameNotOwned value)? gameNotOwned,
    TResult Function(LoginFlowErrors_UnknownError value)? unknownError,
    required TResult orElse(),
  }) {
    if (xstsError != null) {
      return xstsError(this);
    }
    return orElse();
  }
}

abstract class LoginFlowErrors_XstsError implements LoginFlowErrors {
  const factory LoginFlowErrors_XstsError(final XstsTokenErrorType field0) =
      _$LoginFlowErrors_XstsError;

  XstsTokenErrorType get field0;
  @JsonKey(ignore: true)
  _$$LoginFlowErrors_XstsErrorCopyWith<_$LoginFlowErrors_XstsError>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoginFlowErrors_GameNotOwnedCopyWith<$Res> {
  factory _$$LoginFlowErrors_GameNotOwnedCopyWith(
          _$LoginFlowErrors_GameNotOwned value,
          $Res Function(_$LoginFlowErrors_GameNotOwned) then) =
      __$$LoginFlowErrors_GameNotOwnedCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoginFlowErrors_GameNotOwnedCopyWithImpl<$Res>
    extends _$LoginFlowErrorsCopyWithImpl<$Res, _$LoginFlowErrors_GameNotOwned>
    implements _$$LoginFlowErrors_GameNotOwnedCopyWith<$Res> {
  __$$LoginFlowErrors_GameNotOwnedCopyWithImpl(
      _$LoginFlowErrors_GameNotOwned _value,
      $Res Function(_$LoginFlowErrors_GameNotOwned) _then)
      : super(_value, _then);
}

/// @nodoc

class _$LoginFlowErrors_GameNotOwned implements LoginFlowErrors_GameNotOwned {
  const _$LoginFlowErrors_GameNotOwned();

  @override
  String toString() {
    return 'LoginFlowErrors.gameNotOwned()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoginFlowErrors_GameNotOwned);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(XstsTokenErrorType field0) xstsError,
    required TResult Function() gameNotOwned,
    required TResult Function() unknownError,
  }) {
    return gameNotOwned();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(XstsTokenErrorType field0)? xstsError,
    TResult? Function()? gameNotOwned,
    TResult? Function()? unknownError,
  }) {
    return gameNotOwned?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(XstsTokenErrorType field0)? xstsError,
    TResult Function()? gameNotOwned,
    TResult Function()? unknownError,
    required TResult orElse(),
  }) {
    if (gameNotOwned != null) {
      return gameNotOwned();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoginFlowErrors_XstsError value) xstsError,
    required TResult Function(LoginFlowErrors_GameNotOwned value) gameNotOwned,
    required TResult Function(LoginFlowErrors_UnknownError value) unknownError,
  }) {
    return gameNotOwned(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoginFlowErrors_XstsError value)? xstsError,
    TResult? Function(LoginFlowErrors_GameNotOwned value)? gameNotOwned,
    TResult? Function(LoginFlowErrors_UnknownError value)? unknownError,
  }) {
    return gameNotOwned?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoginFlowErrors_XstsError value)? xstsError,
    TResult Function(LoginFlowErrors_GameNotOwned value)? gameNotOwned,
    TResult Function(LoginFlowErrors_UnknownError value)? unknownError,
    required TResult orElse(),
  }) {
    if (gameNotOwned != null) {
      return gameNotOwned(this);
    }
    return orElse();
  }
}

abstract class LoginFlowErrors_GameNotOwned implements LoginFlowErrors {
  const factory LoginFlowErrors_GameNotOwned() = _$LoginFlowErrors_GameNotOwned;
}

/// @nodoc
abstract class _$$LoginFlowErrors_UnknownErrorCopyWith<$Res> {
  factory _$$LoginFlowErrors_UnknownErrorCopyWith(
          _$LoginFlowErrors_UnknownError value,
          $Res Function(_$LoginFlowErrors_UnknownError) then) =
      __$$LoginFlowErrors_UnknownErrorCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoginFlowErrors_UnknownErrorCopyWithImpl<$Res>
    extends _$LoginFlowErrorsCopyWithImpl<$Res, _$LoginFlowErrors_UnknownError>
    implements _$$LoginFlowErrors_UnknownErrorCopyWith<$Res> {
  __$$LoginFlowErrors_UnknownErrorCopyWithImpl(
      _$LoginFlowErrors_UnknownError _value,
      $Res Function(_$LoginFlowErrors_UnknownError) _then)
      : super(_value, _then);
}

/// @nodoc

class _$LoginFlowErrors_UnknownError implements LoginFlowErrors_UnknownError {
  const _$LoginFlowErrors_UnknownError();

  @override
  String toString() {
    return 'LoginFlowErrors.unknownError()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoginFlowErrors_UnknownError);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(XstsTokenErrorType field0) xstsError,
    required TResult Function() gameNotOwned,
    required TResult Function() unknownError,
  }) {
    return unknownError();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(XstsTokenErrorType field0)? xstsError,
    TResult? Function()? gameNotOwned,
    TResult? Function()? unknownError,
  }) {
    return unknownError?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(XstsTokenErrorType field0)? xstsError,
    TResult Function()? gameNotOwned,
    TResult Function()? unknownError,
    required TResult orElse(),
  }) {
    if (unknownError != null) {
      return unknownError();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoginFlowErrors_XstsError value) xstsError,
    required TResult Function(LoginFlowErrors_GameNotOwned value) gameNotOwned,
    required TResult Function(LoginFlowErrors_UnknownError value) unknownError,
  }) {
    return unknownError(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoginFlowErrors_XstsError value)? xstsError,
    TResult? Function(LoginFlowErrors_GameNotOwned value)? gameNotOwned,
    TResult? Function(LoginFlowErrors_UnknownError value)? unknownError,
  }) {
    return unknownError?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoginFlowErrors_XstsError value)? xstsError,
    TResult Function(LoginFlowErrors_GameNotOwned value)? gameNotOwned,
    TResult Function(LoginFlowErrors_UnknownError value)? unknownError,
    required TResult orElse(),
  }) {
    if (unknownError != null) {
      return unknownError(this);
    }
    return orElse();
  }
}

abstract class LoginFlowErrors_UnknownError implements LoginFlowErrors {
  const factory LoginFlowErrors_UnknownError() = _$LoginFlowErrors_UnknownError;
}

/// @nodoc
mixin _$LoginFlowEvent {
  Object get field0 => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(LoginFlowStage field0) stage,
    required TResult Function(LoginFlowDeviceCode field0) deviceCode,
    required TResult Function(LoginFlowErrors field0) error,
    required TResult Function(MinecraftAccount field0) success,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(LoginFlowStage field0)? stage,
    TResult? Function(LoginFlowDeviceCode field0)? deviceCode,
    TResult? Function(LoginFlowErrors field0)? error,
    TResult? Function(MinecraftAccount field0)? success,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(LoginFlowStage field0)? stage,
    TResult Function(LoginFlowDeviceCode field0)? deviceCode,
    TResult Function(LoginFlowErrors field0)? error,
    TResult Function(MinecraftAccount field0)? success,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoginFlowEvent_Stage value) stage,
    required TResult Function(LoginFlowEvent_DeviceCode value) deviceCode,
    required TResult Function(LoginFlowEvent_Error value) error,
    required TResult Function(LoginFlowEvent_Success value) success,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoginFlowEvent_Stage value)? stage,
    TResult? Function(LoginFlowEvent_DeviceCode value)? deviceCode,
    TResult? Function(LoginFlowEvent_Error value)? error,
    TResult? Function(LoginFlowEvent_Success value)? success,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoginFlowEvent_Stage value)? stage,
    TResult Function(LoginFlowEvent_DeviceCode value)? deviceCode,
    TResult Function(LoginFlowEvent_Error value)? error,
    TResult Function(LoginFlowEvent_Success value)? success,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoginFlowEventCopyWith<$Res> {
  factory $LoginFlowEventCopyWith(
          LoginFlowEvent value, $Res Function(LoginFlowEvent) then) =
      _$LoginFlowEventCopyWithImpl<$Res, LoginFlowEvent>;
}

/// @nodoc
class _$LoginFlowEventCopyWithImpl<$Res, $Val extends LoginFlowEvent>
    implements $LoginFlowEventCopyWith<$Res> {
  _$LoginFlowEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$LoginFlowEvent_StageCopyWith<$Res> {
  factory _$$LoginFlowEvent_StageCopyWith(_$LoginFlowEvent_Stage value,
          $Res Function(_$LoginFlowEvent_Stage) then) =
      __$$LoginFlowEvent_StageCopyWithImpl<$Res>;
  @useResult
  $Res call({LoginFlowStage field0});
}

/// @nodoc
class __$$LoginFlowEvent_StageCopyWithImpl<$Res>
    extends _$LoginFlowEventCopyWithImpl<$Res, _$LoginFlowEvent_Stage>
    implements _$$LoginFlowEvent_StageCopyWith<$Res> {
  __$$LoginFlowEvent_StageCopyWithImpl(_$LoginFlowEvent_Stage _value,
      $Res Function(_$LoginFlowEvent_Stage) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? field0 = null,
  }) {
    return _then(_$LoginFlowEvent_Stage(
      null == field0
          ? _value.field0
          : field0 // ignore: cast_nullable_to_non_nullable
              as LoginFlowStage,
    ));
  }
}

/// @nodoc

class _$LoginFlowEvent_Stage implements LoginFlowEvent_Stage {
  const _$LoginFlowEvent_Stage(this.field0);

  @override
  final LoginFlowStage field0;

  @override
  String toString() {
    return 'LoginFlowEvent.stage(field0: $field0)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoginFlowEvent_Stage &&
            (identical(other.field0, field0) || other.field0 == field0));
  }

  @override
  int get hashCode => Object.hash(runtimeType, field0);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LoginFlowEvent_StageCopyWith<_$LoginFlowEvent_Stage> get copyWith =>
      __$$LoginFlowEvent_StageCopyWithImpl<_$LoginFlowEvent_Stage>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(LoginFlowStage field0) stage,
    required TResult Function(LoginFlowDeviceCode field0) deviceCode,
    required TResult Function(LoginFlowErrors field0) error,
    required TResult Function(MinecraftAccount field0) success,
  }) {
    return stage(field0);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(LoginFlowStage field0)? stage,
    TResult? Function(LoginFlowDeviceCode field0)? deviceCode,
    TResult? Function(LoginFlowErrors field0)? error,
    TResult? Function(MinecraftAccount field0)? success,
  }) {
    return stage?.call(field0);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(LoginFlowStage field0)? stage,
    TResult Function(LoginFlowDeviceCode field0)? deviceCode,
    TResult Function(LoginFlowErrors field0)? error,
    TResult Function(MinecraftAccount field0)? success,
    required TResult orElse(),
  }) {
    if (stage != null) {
      return stage(field0);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoginFlowEvent_Stage value) stage,
    required TResult Function(LoginFlowEvent_DeviceCode value) deviceCode,
    required TResult Function(LoginFlowEvent_Error value) error,
    required TResult Function(LoginFlowEvent_Success value) success,
  }) {
    return stage(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoginFlowEvent_Stage value)? stage,
    TResult? Function(LoginFlowEvent_DeviceCode value)? deviceCode,
    TResult? Function(LoginFlowEvent_Error value)? error,
    TResult? Function(LoginFlowEvent_Success value)? success,
  }) {
    return stage?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoginFlowEvent_Stage value)? stage,
    TResult Function(LoginFlowEvent_DeviceCode value)? deviceCode,
    TResult Function(LoginFlowEvent_Error value)? error,
    TResult Function(LoginFlowEvent_Success value)? success,
    required TResult orElse(),
  }) {
    if (stage != null) {
      return stage(this);
    }
    return orElse();
  }
}

abstract class LoginFlowEvent_Stage implements LoginFlowEvent {
  const factory LoginFlowEvent_Stage(final LoginFlowStage field0) =
      _$LoginFlowEvent_Stage;

  @override
  LoginFlowStage get field0;
  @JsonKey(ignore: true)
  _$$LoginFlowEvent_StageCopyWith<_$LoginFlowEvent_Stage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoginFlowEvent_DeviceCodeCopyWith<$Res> {
  factory _$$LoginFlowEvent_DeviceCodeCopyWith(
          _$LoginFlowEvent_DeviceCode value,
          $Res Function(_$LoginFlowEvent_DeviceCode) then) =
      __$$LoginFlowEvent_DeviceCodeCopyWithImpl<$Res>;
  @useResult
  $Res call({LoginFlowDeviceCode field0});
}

/// @nodoc
class __$$LoginFlowEvent_DeviceCodeCopyWithImpl<$Res>
    extends _$LoginFlowEventCopyWithImpl<$Res, _$LoginFlowEvent_DeviceCode>
    implements _$$LoginFlowEvent_DeviceCodeCopyWith<$Res> {
  __$$LoginFlowEvent_DeviceCodeCopyWithImpl(_$LoginFlowEvent_DeviceCode _value,
      $Res Function(_$LoginFlowEvent_DeviceCode) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? field0 = null,
  }) {
    return _then(_$LoginFlowEvent_DeviceCode(
      null == field0
          ? _value.field0
          : field0 // ignore: cast_nullable_to_non_nullable
              as LoginFlowDeviceCode,
    ));
  }
}

/// @nodoc

class _$LoginFlowEvent_DeviceCode implements LoginFlowEvent_DeviceCode {
  const _$LoginFlowEvent_DeviceCode(this.field0);

  @override
  final LoginFlowDeviceCode field0;

  @override
  String toString() {
    return 'LoginFlowEvent.deviceCode(field0: $field0)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoginFlowEvent_DeviceCode &&
            (identical(other.field0, field0) || other.field0 == field0));
  }

  @override
  int get hashCode => Object.hash(runtimeType, field0);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LoginFlowEvent_DeviceCodeCopyWith<_$LoginFlowEvent_DeviceCode>
      get copyWith => __$$LoginFlowEvent_DeviceCodeCopyWithImpl<
          _$LoginFlowEvent_DeviceCode>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(LoginFlowStage field0) stage,
    required TResult Function(LoginFlowDeviceCode field0) deviceCode,
    required TResult Function(LoginFlowErrors field0) error,
    required TResult Function(MinecraftAccount field0) success,
  }) {
    return deviceCode(field0);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(LoginFlowStage field0)? stage,
    TResult? Function(LoginFlowDeviceCode field0)? deviceCode,
    TResult? Function(LoginFlowErrors field0)? error,
    TResult? Function(MinecraftAccount field0)? success,
  }) {
    return deviceCode?.call(field0);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(LoginFlowStage field0)? stage,
    TResult Function(LoginFlowDeviceCode field0)? deviceCode,
    TResult Function(LoginFlowErrors field0)? error,
    TResult Function(MinecraftAccount field0)? success,
    required TResult orElse(),
  }) {
    if (deviceCode != null) {
      return deviceCode(field0);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoginFlowEvent_Stage value) stage,
    required TResult Function(LoginFlowEvent_DeviceCode value) deviceCode,
    required TResult Function(LoginFlowEvent_Error value) error,
    required TResult Function(LoginFlowEvent_Success value) success,
  }) {
    return deviceCode(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoginFlowEvent_Stage value)? stage,
    TResult? Function(LoginFlowEvent_DeviceCode value)? deviceCode,
    TResult? Function(LoginFlowEvent_Error value)? error,
    TResult? Function(LoginFlowEvent_Success value)? success,
  }) {
    return deviceCode?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoginFlowEvent_Stage value)? stage,
    TResult Function(LoginFlowEvent_DeviceCode value)? deviceCode,
    TResult Function(LoginFlowEvent_Error value)? error,
    TResult Function(LoginFlowEvent_Success value)? success,
    required TResult orElse(),
  }) {
    if (deviceCode != null) {
      return deviceCode(this);
    }
    return orElse();
  }
}

abstract class LoginFlowEvent_DeviceCode implements LoginFlowEvent {
  const factory LoginFlowEvent_DeviceCode(final LoginFlowDeviceCode field0) =
      _$LoginFlowEvent_DeviceCode;

  @override
  LoginFlowDeviceCode get field0;
  @JsonKey(ignore: true)
  _$$LoginFlowEvent_DeviceCodeCopyWith<_$LoginFlowEvent_DeviceCode>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoginFlowEvent_ErrorCopyWith<$Res> {
  factory _$$LoginFlowEvent_ErrorCopyWith(_$LoginFlowEvent_Error value,
          $Res Function(_$LoginFlowEvent_Error) then) =
      __$$LoginFlowEvent_ErrorCopyWithImpl<$Res>;
  @useResult
  $Res call({LoginFlowErrors field0});

  $LoginFlowErrorsCopyWith<$Res> get field0;
}

/// @nodoc
class __$$LoginFlowEvent_ErrorCopyWithImpl<$Res>
    extends _$LoginFlowEventCopyWithImpl<$Res, _$LoginFlowEvent_Error>
    implements _$$LoginFlowEvent_ErrorCopyWith<$Res> {
  __$$LoginFlowEvent_ErrorCopyWithImpl(_$LoginFlowEvent_Error _value,
      $Res Function(_$LoginFlowEvent_Error) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? field0 = null,
  }) {
    return _then(_$LoginFlowEvent_Error(
      null == field0
          ? _value.field0
          : field0 // ignore: cast_nullable_to_non_nullable
              as LoginFlowErrors,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $LoginFlowErrorsCopyWith<$Res> get field0 {
    return $LoginFlowErrorsCopyWith<$Res>(_value.field0, (value) {
      return _then(_value.copyWith(field0: value));
    });
  }
}

/// @nodoc

class _$LoginFlowEvent_Error implements LoginFlowEvent_Error {
  const _$LoginFlowEvent_Error(this.field0);

  @override
  final LoginFlowErrors field0;

  @override
  String toString() {
    return 'LoginFlowEvent.error(field0: $field0)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoginFlowEvent_Error &&
            (identical(other.field0, field0) || other.field0 == field0));
  }

  @override
  int get hashCode => Object.hash(runtimeType, field0);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LoginFlowEvent_ErrorCopyWith<_$LoginFlowEvent_Error> get copyWith =>
      __$$LoginFlowEvent_ErrorCopyWithImpl<_$LoginFlowEvent_Error>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(LoginFlowStage field0) stage,
    required TResult Function(LoginFlowDeviceCode field0) deviceCode,
    required TResult Function(LoginFlowErrors field0) error,
    required TResult Function(MinecraftAccount field0) success,
  }) {
    return error(field0);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(LoginFlowStage field0)? stage,
    TResult? Function(LoginFlowDeviceCode field0)? deviceCode,
    TResult? Function(LoginFlowErrors field0)? error,
    TResult? Function(MinecraftAccount field0)? success,
  }) {
    return error?.call(field0);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(LoginFlowStage field0)? stage,
    TResult Function(LoginFlowDeviceCode field0)? deviceCode,
    TResult Function(LoginFlowErrors field0)? error,
    TResult Function(MinecraftAccount field0)? success,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(field0);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoginFlowEvent_Stage value) stage,
    required TResult Function(LoginFlowEvent_DeviceCode value) deviceCode,
    required TResult Function(LoginFlowEvent_Error value) error,
    required TResult Function(LoginFlowEvent_Success value) success,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoginFlowEvent_Stage value)? stage,
    TResult? Function(LoginFlowEvent_DeviceCode value)? deviceCode,
    TResult? Function(LoginFlowEvent_Error value)? error,
    TResult? Function(LoginFlowEvent_Success value)? success,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoginFlowEvent_Stage value)? stage,
    TResult Function(LoginFlowEvent_DeviceCode value)? deviceCode,
    TResult Function(LoginFlowEvent_Error value)? error,
    TResult Function(LoginFlowEvent_Success value)? success,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class LoginFlowEvent_Error implements LoginFlowEvent {
  const factory LoginFlowEvent_Error(final LoginFlowErrors field0) =
      _$LoginFlowEvent_Error;

  @override
  LoginFlowErrors get field0;
  @JsonKey(ignore: true)
  _$$LoginFlowEvent_ErrorCopyWith<_$LoginFlowEvent_Error> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoginFlowEvent_SuccessCopyWith<$Res> {
  factory _$$LoginFlowEvent_SuccessCopyWith(_$LoginFlowEvent_Success value,
          $Res Function(_$LoginFlowEvent_Success) then) =
      __$$LoginFlowEvent_SuccessCopyWithImpl<$Res>;
  @useResult
  $Res call({MinecraftAccount field0});
}

/// @nodoc
class __$$LoginFlowEvent_SuccessCopyWithImpl<$Res>
    extends _$LoginFlowEventCopyWithImpl<$Res, _$LoginFlowEvent_Success>
    implements _$$LoginFlowEvent_SuccessCopyWith<$Res> {
  __$$LoginFlowEvent_SuccessCopyWithImpl(_$LoginFlowEvent_Success _value,
      $Res Function(_$LoginFlowEvent_Success) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? field0 = null,
  }) {
    return _then(_$LoginFlowEvent_Success(
      null == field0
          ? _value.field0
          : field0 // ignore: cast_nullable_to_non_nullable
              as MinecraftAccount,
    ));
  }
}

/// @nodoc

class _$LoginFlowEvent_Success implements LoginFlowEvent_Success {
  const _$LoginFlowEvent_Success(this.field0);

  @override
  final MinecraftAccount field0;

  @override
  String toString() {
    return 'LoginFlowEvent.success(field0: $field0)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoginFlowEvent_Success &&
            (identical(other.field0, field0) || other.field0 == field0));
  }

  @override
  int get hashCode => Object.hash(runtimeType, field0);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LoginFlowEvent_SuccessCopyWith<_$LoginFlowEvent_Success> get copyWith =>
      __$$LoginFlowEvent_SuccessCopyWithImpl<_$LoginFlowEvent_Success>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(LoginFlowStage field0) stage,
    required TResult Function(LoginFlowDeviceCode field0) deviceCode,
    required TResult Function(LoginFlowErrors field0) error,
    required TResult Function(MinecraftAccount field0) success,
  }) {
    return success(field0);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(LoginFlowStage field0)? stage,
    TResult? Function(LoginFlowDeviceCode field0)? deviceCode,
    TResult? Function(LoginFlowErrors field0)? error,
    TResult? Function(MinecraftAccount field0)? success,
  }) {
    return success?.call(field0);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(LoginFlowStage field0)? stage,
    TResult Function(LoginFlowDeviceCode field0)? deviceCode,
    TResult Function(LoginFlowErrors field0)? error,
    TResult Function(MinecraftAccount field0)? success,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(field0);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoginFlowEvent_Stage value) stage,
    required TResult Function(LoginFlowEvent_DeviceCode value) deviceCode,
    required TResult Function(LoginFlowEvent_Error value) error,
    required TResult Function(LoginFlowEvent_Success value) success,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoginFlowEvent_Stage value)? stage,
    TResult? Function(LoginFlowEvent_DeviceCode value)? deviceCode,
    TResult? Function(LoginFlowEvent_Error value)? error,
    TResult? Function(LoginFlowEvent_Success value)? success,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoginFlowEvent_Stage value)? stage,
    TResult Function(LoginFlowEvent_DeviceCode value)? deviceCode,
    TResult Function(LoginFlowEvent_Error value)? error,
    TResult Function(LoginFlowEvent_Success value)? success,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class LoginFlowEvent_Success implements LoginFlowEvent {
  const factory LoginFlowEvent_Success(final MinecraftAccount field0) =
      _$LoginFlowEvent_Success;

  @override
  MinecraftAccount get field0;
  @JsonKey(ignore: true)
  _$$LoginFlowEvent_SuccessCopyWith<_$LoginFlowEvent_Success> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$MyError {
  Object get field0 => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(VanillaLaunchError field0) launch,
    required TResult Function(String field0) joinError,
    required TResult Function(String field0) anyhow,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(VanillaLaunchError field0)? launch,
    TResult? Function(String field0)? joinError,
    TResult? Function(String field0)? anyhow,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(VanillaLaunchError field0)? launch,
    TResult Function(String field0)? joinError,
    TResult Function(String field0)? anyhow,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(MyError_Launch value) launch,
    required TResult Function(MyError_JoinError value) joinError,
    required TResult Function(MyError_Anyhow value) anyhow,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MyError_Launch value)? launch,
    TResult? Function(MyError_JoinError value)? joinError,
    TResult? Function(MyError_Anyhow value)? anyhow,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MyError_Launch value)? launch,
    TResult Function(MyError_JoinError value)? joinError,
    TResult Function(MyError_Anyhow value)? anyhow,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MyErrorCopyWith<$Res> {
  factory $MyErrorCopyWith(MyError value, $Res Function(MyError) then) =
      _$MyErrorCopyWithImpl<$Res, MyError>;
}

/// @nodoc
class _$MyErrorCopyWithImpl<$Res, $Val extends MyError>
    implements $MyErrorCopyWith<$Res> {
  _$MyErrorCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$MyError_LaunchCopyWith<$Res> {
  factory _$$MyError_LaunchCopyWith(
          _$MyError_Launch value, $Res Function(_$MyError_Launch) then) =
      __$$MyError_LaunchCopyWithImpl<$Res>;
  @useResult
  $Res call({VanillaLaunchError field0});

  $VanillaLaunchErrorCopyWith<$Res> get field0;
}

/// @nodoc
class __$$MyError_LaunchCopyWithImpl<$Res>
    extends _$MyErrorCopyWithImpl<$Res, _$MyError_Launch>
    implements _$$MyError_LaunchCopyWith<$Res> {
  __$$MyError_LaunchCopyWithImpl(
      _$MyError_Launch _value, $Res Function(_$MyError_Launch) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? field0 = null,
  }) {
    return _then(_$MyError_Launch(
      null == field0
          ? _value.field0
          : field0 // ignore: cast_nullable_to_non_nullable
              as VanillaLaunchError,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $VanillaLaunchErrorCopyWith<$Res> get field0 {
    return $VanillaLaunchErrorCopyWith<$Res>(_value.field0, (value) {
      return _then(_value.copyWith(field0: value));
    });
  }
}

/// @nodoc

class _$MyError_Launch implements MyError_Launch {
  const _$MyError_Launch(this.field0);

  @override
  final VanillaLaunchError field0;

  @override
  String toString() {
    return 'MyError.launch(field0: $field0)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MyError_Launch &&
            (identical(other.field0, field0) || other.field0 == field0));
  }

  @override
  int get hashCode => Object.hash(runtimeType, field0);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MyError_LaunchCopyWith<_$MyError_Launch> get copyWith =>
      __$$MyError_LaunchCopyWithImpl<_$MyError_Launch>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(VanillaLaunchError field0) launch,
    required TResult Function(String field0) joinError,
    required TResult Function(String field0) anyhow,
  }) {
    return launch(field0);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(VanillaLaunchError field0)? launch,
    TResult? Function(String field0)? joinError,
    TResult? Function(String field0)? anyhow,
  }) {
    return launch?.call(field0);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(VanillaLaunchError field0)? launch,
    TResult Function(String field0)? joinError,
    TResult Function(String field0)? anyhow,
    required TResult orElse(),
  }) {
    if (launch != null) {
      return launch(field0);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(MyError_Launch value) launch,
    required TResult Function(MyError_JoinError value) joinError,
    required TResult Function(MyError_Anyhow value) anyhow,
  }) {
    return launch(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MyError_Launch value)? launch,
    TResult? Function(MyError_JoinError value)? joinError,
    TResult? Function(MyError_Anyhow value)? anyhow,
  }) {
    return launch?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MyError_Launch value)? launch,
    TResult Function(MyError_JoinError value)? joinError,
    TResult Function(MyError_Anyhow value)? anyhow,
    required TResult orElse(),
  }) {
    if (launch != null) {
      return launch(this);
    }
    return orElse();
  }
}

abstract class MyError_Launch implements MyError {
  const factory MyError_Launch(final VanillaLaunchError field0) =
      _$MyError_Launch;

  @override
  VanillaLaunchError get field0;
  @JsonKey(ignore: true)
  _$$MyError_LaunchCopyWith<_$MyError_Launch> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$MyError_JoinErrorCopyWith<$Res> {
  factory _$$MyError_JoinErrorCopyWith(
          _$MyError_JoinError value, $Res Function(_$MyError_JoinError) then) =
      __$$MyError_JoinErrorCopyWithImpl<$Res>;
  @useResult
  $Res call({String field0});
}

/// @nodoc
class __$$MyError_JoinErrorCopyWithImpl<$Res>
    extends _$MyErrorCopyWithImpl<$Res, _$MyError_JoinError>
    implements _$$MyError_JoinErrorCopyWith<$Res> {
  __$$MyError_JoinErrorCopyWithImpl(
      _$MyError_JoinError _value, $Res Function(_$MyError_JoinError) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? field0 = null,
  }) {
    return _then(_$MyError_JoinError(
      null == field0
          ? _value.field0
          : field0 // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$MyError_JoinError implements MyError_JoinError {
  const _$MyError_JoinError(this.field0);

  @override
  final String field0;

  @override
  String toString() {
    return 'MyError.joinError(field0: $field0)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MyError_JoinError &&
            (identical(other.field0, field0) || other.field0 == field0));
  }

  @override
  int get hashCode => Object.hash(runtimeType, field0);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MyError_JoinErrorCopyWith<_$MyError_JoinError> get copyWith =>
      __$$MyError_JoinErrorCopyWithImpl<_$MyError_JoinError>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(VanillaLaunchError field0) launch,
    required TResult Function(String field0) joinError,
    required TResult Function(String field0) anyhow,
  }) {
    return joinError(field0);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(VanillaLaunchError field0)? launch,
    TResult? Function(String field0)? joinError,
    TResult? Function(String field0)? anyhow,
  }) {
    return joinError?.call(field0);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(VanillaLaunchError field0)? launch,
    TResult Function(String field0)? joinError,
    TResult Function(String field0)? anyhow,
    required TResult orElse(),
  }) {
    if (joinError != null) {
      return joinError(field0);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(MyError_Launch value) launch,
    required TResult Function(MyError_JoinError value) joinError,
    required TResult Function(MyError_Anyhow value) anyhow,
  }) {
    return joinError(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MyError_Launch value)? launch,
    TResult? Function(MyError_JoinError value)? joinError,
    TResult? Function(MyError_Anyhow value)? anyhow,
  }) {
    return joinError?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MyError_Launch value)? launch,
    TResult Function(MyError_JoinError value)? joinError,
    TResult Function(MyError_Anyhow value)? anyhow,
    required TResult orElse(),
  }) {
    if (joinError != null) {
      return joinError(this);
    }
    return orElse();
  }
}

abstract class MyError_JoinError implements MyError {
  const factory MyError_JoinError(final String field0) = _$MyError_JoinError;

  @override
  String get field0;
  @JsonKey(ignore: true)
  _$$MyError_JoinErrorCopyWith<_$MyError_JoinError> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$MyError_AnyhowCopyWith<$Res> {
  factory _$$MyError_AnyhowCopyWith(
          _$MyError_Anyhow value, $Res Function(_$MyError_Anyhow) then) =
      __$$MyError_AnyhowCopyWithImpl<$Res>;
  @useResult
  $Res call({String field0});
}

/// @nodoc
class __$$MyError_AnyhowCopyWithImpl<$Res>
    extends _$MyErrorCopyWithImpl<$Res, _$MyError_Anyhow>
    implements _$$MyError_AnyhowCopyWith<$Res> {
  __$$MyError_AnyhowCopyWithImpl(
      _$MyError_Anyhow _value, $Res Function(_$MyError_Anyhow) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? field0 = null,
  }) {
    return _then(_$MyError_Anyhow(
      null == field0
          ? _value.field0
          : field0 // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$MyError_Anyhow implements MyError_Anyhow {
  const _$MyError_Anyhow(this.field0);

  @override
  final String field0;

  @override
  String toString() {
    return 'MyError.anyhow(field0: $field0)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MyError_Anyhow &&
            (identical(other.field0, field0) || other.field0 == field0));
  }

  @override
  int get hashCode => Object.hash(runtimeType, field0);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MyError_AnyhowCopyWith<_$MyError_Anyhow> get copyWith =>
      __$$MyError_AnyhowCopyWithImpl<_$MyError_Anyhow>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(VanillaLaunchError field0) launch,
    required TResult Function(String field0) joinError,
    required TResult Function(String field0) anyhow,
  }) {
    return anyhow(field0);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(VanillaLaunchError field0)? launch,
    TResult? Function(String field0)? joinError,
    TResult? Function(String field0)? anyhow,
  }) {
    return anyhow?.call(field0);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(VanillaLaunchError field0)? launch,
    TResult Function(String field0)? joinError,
    TResult Function(String field0)? anyhow,
    required TResult orElse(),
  }) {
    if (anyhow != null) {
      return anyhow(field0);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(MyError_Launch value) launch,
    required TResult Function(MyError_JoinError value) joinError,
    required TResult Function(MyError_Anyhow value) anyhow,
  }) {
    return anyhow(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MyError_Launch value)? launch,
    TResult? Function(MyError_JoinError value)? joinError,
    TResult? Function(MyError_Anyhow value)? anyhow,
  }) {
    return anyhow?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MyError_Launch value)? launch,
    TResult Function(MyError_JoinError value)? joinError,
    TResult Function(MyError_Anyhow value)? anyhow,
    required TResult orElse(),
  }) {
    if (anyhow != null) {
      return anyhow(this);
    }
    return orElse();
  }
}

abstract class MyError_Anyhow implements MyError {
  const factory MyError_Anyhow(final String field0) = _$MyError_Anyhow;

  @override
  String get field0;
  @JsonKey(ignore: true)
  _$$MyError_AnyhowCopyWith<_$MyError_Anyhow> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$Progress {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(double speed, double percentages,
            double currentSize, double totalSize)
        ok,
    required TResult Function(MyError field0) err,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(double speed, double percentages, double currentSize,
            double totalSize)?
        ok,
    TResult? Function(MyError field0)? err,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(double speed, double percentages, double currentSize,
            double totalSize)?
        ok,
    TResult Function(MyError field0)? err,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Progress_Ok value) ok,
    required TResult Function(Progress_Err value) err,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Progress_Ok value)? ok,
    TResult? Function(Progress_Err value)? err,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Progress_Ok value)? ok,
    TResult Function(Progress_Err value)? err,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProgressCopyWith<$Res> {
  factory $ProgressCopyWith(Progress value, $Res Function(Progress) then) =
      _$ProgressCopyWithImpl<$Res, Progress>;
}

/// @nodoc
class _$ProgressCopyWithImpl<$Res, $Val extends Progress>
    implements $ProgressCopyWith<$Res> {
  _$ProgressCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$Progress_OkCopyWith<$Res> {
  factory _$$Progress_OkCopyWith(
          _$Progress_Ok value, $Res Function(_$Progress_Ok) then) =
      __$$Progress_OkCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {double speed, double percentages, double currentSize, double totalSize});
}

/// @nodoc
class __$$Progress_OkCopyWithImpl<$Res>
    extends _$ProgressCopyWithImpl<$Res, _$Progress_Ok>
    implements _$$Progress_OkCopyWith<$Res> {
  __$$Progress_OkCopyWithImpl(
      _$Progress_Ok _value, $Res Function(_$Progress_Ok) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? speed = null,
    Object? percentages = null,
    Object? currentSize = null,
    Object? totalSize = null,
  }) {
    return _then(_$Progress_Ok(
      speed: null == speed
          ? _value.speed
          : speed // ignore: cast_nullable_to_non_nullable
              as double,
      percentages: null == percentages
          ? _value.percentages
          : percentages // ignore: cast_nullable_to_non_nullable
              as double,
      currentSize: null == currentSize
          ? _value.currentSize
          : currentSize // ignore: cast_nullable_to_non_nullable
              as double,
      totalSize: null == totalSize
          ? _value.totalSize
          : totalSize // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc

class _$Progress_Ok implements Progress_Ok {
  const _$Progress_Ok(
      {required this.speed,
      required this.percentages,
      required this.currentSize,
      required this.totalSize});

  @override
  final double speed;
  @override
  final double percentages;
  @override
  final double currentSize;
  @override
  final double totalSize;

  @override
  String toString() {
    return 'Progress.ok(speed: $speed, percentages: $percentages, currentSize: $currentSize, totalSize: $totalSize)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Progress_Ok &&
            (identical(other.speed, speed) || other.speed == speed) &&
            (identical(other.percentages, percentages) ||
                other.percentages == percentages) &&
            (identical(other.currentSize, currentSize) ||
                other.currentSize == currentSize) &&
            (identical(other.totalSize, totalSize) ||
                other.totalSize == totalSize));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, speed, percentages, currentSize, totalSize);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$Progress_OkCopyWith<_$Progress_Ok> get copyWith =>
      __$$Progress_OkCopyWithImpl<_$Progress_Ok>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(double speed, double percentages,
            double currentSize, double totalSize)
        ok,
    required TResult Function(MyError field0) err,
  }) {
    return ok(speed, percentages, currentSize, totalSize);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(double speed, double percentages, double currentSize,
            double totalSize)?
        ok,
    TResult? Function(MyError field0)? err,
  }) {
    return ok?.call(speed, percentages, currentSize, totalSize);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(double speed, double percentages, double currentSize,
            double totalSize)?
        ok,
    TResult Function(MyError field0)? err,
    required TResult orElse(),
  }) {
    if (ok != null) {
      return ok(speed, percentages, currentSize, totalSize);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Progress_Ok value) ok,
    required TResult Function(Progress_Err value) err,
  }) {
    return ok(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Progress_Ok value)? ok,
    TResult? Function(Progress_Err value)? err,
  }) {
    return ok?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Progress_Ok value)? ok,
    TResult Function(Progress_Err value)? err,
    required TResult orElse(),
  }) {
    if (ok != null) {
      return ok(this);
    }
    return orElse();
  }
}

abstract class Progress_Ok implements Progress {
  const factory Progress_Ok(
      {required final double speed,
      required final double percentages,
      required final double currentSize,
      required final double totalSize}) = _$Progress_Ok;

  double get speed;
  double get percentages;
  double get currentSize;
  double get totalSize;
  @JsonKey(ignore: true)
  _$$Progress_OkCopyWith<_$Progress_Ok> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$Progress_ErrCopyWith<$Res> {
  factory _$$Progress_ErrCopyWith(
          _$Progress_Err value, $Res Function(_$Progress_Err) then) =
      __$$Progress_ErrCopyWithImpl<$Res>;
  @useResult
  $Res call({MyError field0});

  $MyErrorCopyWith<$Res> get field0;
}

/// @nodoc
class __$$Progress_ErrCopyWithImpl<$Res>
    extends _$ProgressCopyWithImpl<$Res, _$Progress_Err>
    implements _$$Progress_ErrCopyWith<$Res> {
  __$$Progress_ErrCopyWithImpl(
      _$Progress_Err _value, $Res Function(_$Progress_Err) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? field0 = null,
  }) {
    return _then(_$Progress_Err(
      null == field0
          ? _value.field0
          : field0 // ignore: cast_nullable_to_non_nullable
              as MyError,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $MyErrorCopyWith<$Res> get field0 {
    return $MyErrorCopyWith<$Res>(_value.field0, (value) {
      return _then(_value.copyWith(field0: value));
    });
  }
}

/// @nodoc

class _$Progress_Err implements Progress_Err {
  const _$Progress_Err(this.field0);

  @override
  final MyError field0;

  @override
  String toString() {
    return 'Progress.err(field0: $field0)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Progress_Err &&
            (identical(other.field0, field0) || other.field0 == field0));
  }

  @override
  int get hashCode => Object.hash(runtimeType, field0);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$Progress_ErrCopyWith<_$Progress_Err> get copyWith =>
      __$$Progress_ErrCopyWithImpl<_$Progress_Err>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(double speed, double percentages,
            double currentSize, double totalSize)
        ok,
    required TResult Function(MyError field0) err,
  }) {
    return err(field0);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(double speed, double percentages, double currentSize,
            double totalSize)?
        ok,
    TResult? Function(MyError field0)? err,
  }) {
    return err?.call(field0);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(double speed, double percentages, double currentSize,
            double totalSize)?
        ok,
    TResult Function(MyError field0)? err,
    required TResult orElse(),
  }) {
    if (err != null) {
      return err(field0);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Progress_Ok value) ok,
    required TResult Function(Progress_Err value) err,
  }) {
    return err(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Progress_Ok value)? ok,
    TResult? Function(Progress_Err value)? err,
  }) {
    return err?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Progress_Ok value)? ok,
    TResult Function(Progress_Err value)? err,
    required TResult orElse(),
  }) {
    if (err != null) {
      return err(this);
    }
    return orElse();
  }
}

abstract class Progress_Err implements Progress {
  const factory Progress_Err(final MyError field0) = _$Progress_Err;

  MyError get field0;
  @JsonKey(ignore: true)
  _$$Progress_ErrCopyWith<_$Progress_Err> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$UILayoutValue {
  bool get field0 => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(bool field0) completedSetup,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(bool field0)? completedSetup,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(bool field0)? completedSetup,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(UILayoutValue_CompletedSetup value)
        completedSetup,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(UILayoutValue_CompletedSetup value)? completedSetup,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(UILayoutValue_CompletedSetup value)? completedSetup,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $UILayoutValueCopyWith<UILayoutValue> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UILayoutValueCopyWith<$Res> {
  factory $UILayoutValueCopyWith(
          UILayoutValue value, $Res Function(UILayoutValue) then) =
      _$UILayoutValueCopyWithImpl<$Res, UILayoutValue>;
  @useResult
  $Res call({bool field0});
}

/// @nodoc
class _$UILayoutValueCopyWithImpl<$Res, $Val extends UILayoutValue>
    implements $UILayoutValueCopyWith<$Res> {
  _$UILayoutValueCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? field0 = null,
  }) {
    return _then(_value.copyWith(
      field0: null == field0
          ? _value.field0
          : field0 // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UILayoutValue_CompletedSetupCopyWith<$Res>
    implements $UILayoutValueCopyWith<$Res> {
  factory _$$UILayoutValue_CompletedSetupCopyWith(
          _$UILayoutValue_CompletedSetup value,
          $Res Function(_$UILayoutValue_CompletedSetup) then) =
      __$$UILayoutValue_CompletedSetupCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool field0});
}

/// @nodoc
class __$$UILayoutValue_CompletedSetupCopyWithImpl<$Res>
    extends _$UILayoutValueCopyWithImpl<$Res, _$UILayoutValue_CompletedSetup>
    implements _$$UILayoutValue_CompletedSetupCopyWith<$Res> {
  __$$UILayoutValue_CompletedSetupCopyWithImpl(
      _$UILayoutValue_CompletedSetup _value,
      $Res Function(_$UILayoutValue_CompletedSetup) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? field0 = null,
  }) {
    return _then(_$UILayoutValue_CompletedSetup(
      null == field0
          ? _value.field0
          : field0 // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$UILayoutValue_CompletedSetup implements UILayoutValue_CompletedSetup {
  const _$UILayoutValue_CompletedSetup(this.field0);

  @override
  final bool field0;

  @override
  String toString() {
    return 'UILayoutValue.completedSetup(field0: $field0)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UILayoutValue_CompletedSetup &&
            (identical(other.field0, field0) || other.field0 == field0));
  }

  @override
  int get hashCode => Object.hash(runtimeType, field0);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UILayoutValue_CompletedSetupCopyWith<_$UILayoutValue_CompletedSetup>
      get copyWith => __$$UILayoutValue_CompletedSetupCopyWithImpl<
          _$UILayoutValue_CompletedSetup>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(bool field0) completedSetup,
  }) {
    return completedSetup(field0);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(bool field0)? completedSetup,
  }) {
    return completedSetup?.call(field0);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(bool field0)? completedSetup,
    required TResult orElse(),
  }) {
    if (completedSetup != null) {
      return completedSetup(field0);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(UILayoutValue_CompletedSetup value)
        completedSetup,
  }) {
    return completedSetup(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(UILayoutValue_CompletedSetup value)? completedSetup,
  }) {
    return completedSetup?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(UILayoutValue_CompletedSetup value)? completedSetup,
    required TResult orElse(),
  }) {
    if (completedSetup != null) {
      return completedSetup(this);
    }
    return orElse();
  }
}

abstract class UILayoutValue_CompletedSetup implements UILayoutValue {
  const factory UILayoutValue_CompletedSetup(final bool field0) =
      _$UILayoutValue_CompletedSetup;

  @override
  bool get field0;
  @override
  @JsonKey(ignore: true)
  _$$UILayoutValue_CompletedSetupCopyWith<_$UILayoutValue_CompletedSetup>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$VanillaLaunchError {
  Object get field0 => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(DateTime field0) tokenExpire,
    required TResult Function(CustomIoErrorKind field0) io,
    required TResult Function(String field0) other,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(DateTime field0)? tokenExpire,
    TResult? Function(CustomIoErrorKind field0)? io,
    TResult? Function(String field0)? other,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(DateTime field0)? tokenExpire,
    TResult Function(CustomIoErrorKind field0)? io,
    TResult Function(String field0)? other,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(VanillaLaunchError_TokenExpire value) tokenExpire,
    required TResult Function(VanillaLaunchError_Io value) io,
    required TResult Function(VanillaLaunchError_Other value) other,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(VanillaLaunchError_TokenExpire value)? tokenExpire,
    TResult? Function(VanillaLaunchError_Io value)? io,
    TResult? Function(VanillaLaunchError_Other value)? other,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(VanillaLaunchError_TokenExpire value)? tokenExpire,
    TResult Function(VanillaLaunchError_Io value)? io,
    TResult Function(VanillaLaunchError_Other value)? other,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VanillaLaunchErrorCopyWith<$Res> {
  factory $VanillaLaunchErrorCopyWith(
          VanillaLaunchError value, $Res Function(VanillaLaunchError) then) =
      _$VanillaLaunchErrorCopyWithImpl<$Res, VanillaLaunchError>;
}

/// @nodoc
class _$VanillaLaunchErrorCopyWithImpl<$Res, $Val extends VanillaLaunchError>
    implements $VanillaLaunchErrorCopyWith<$Res> {
  _$VanillaLaunchErrorCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$VanillaLaunchError_TokenExpireCopyWith<$Res> {
  factory _$$VanillaLaunchError_TokenExpireCopyWith(
          _$VanillaLaunchError_TokenExpire value,
          $Res Function(_$VanillaLaunchError_TokenExpire) then) =
      __$$VanillaLaunchError_TokenExpireCopyWithImpl<$Res>;
  @useResult
  $Res call({DateTime field0});
}

/// @nodoc
class __$$VanillaLaunchError_TokenExpireCopyWithImpl<$Res>
    extends _$VanillaLaunchErrorCopyWithImpl<$Res,
        _$VanillaLaunchError_TokenExpire>
    implements _$$VanillaLaunchError_TokenExpireCopyWith<$Res> {
  __$$VanillaLaunchError_TokenExpireCopyWithImpl(
      _$VanillaLaunchError_TokenExpire _value,
      $Res Function(_$VanillaLaunchError_TokenExpire) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? field0 = null,
  }) {
    return _then(_$VanillaLaunchError_TokenExpire(
      null == field0
          ? _value.field0
          : field0 // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc

class _$VanillaLaunchError_TokenExpire
    implements VanillaLaunchError_TokenExpire {
  const _$VanillaLaunchError_TokenExpire(this.field0);

  @override
  final DateTime field0;

  @override
  String toString() {
    return 'VanillaLaunchError.tokenExpire(field0: $field0)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VanillaLaunchError_TokenExpire &&
            (identical(other.field0, field0) || other.field0 == field0));
  }

  @override
  int get hashCode => Object.hash(runtimeType, field0);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$VanillaLaunchError_TokenExpireCopyWith<_$VanillaLaunchError_TokenExpire>
      get copyWith => __$$VanillaLaunchError_TokenExpireCopyWithImpl<
          _$VanillaLaunchError_TokenExpire>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(DateTime field0) tokenExpire,
    required TResult Function(CustomIoErrorKind field0) io,
    required TResult Function(String field0) other,
  }) {
    return tokenExpire(field0);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(DateTime field0)? tokenExpire,
    TResult? Function(CustomIoErrorKind field0)? io,
    TResult? Function(String field0)? other,
  }) {
    return tokenExpire?.call(field0);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(DateTime field0)? tokenExpire,
    TResult Function(CustomIoErrorKind field0)? io,
    TResult Function(String field0)? other,
    required TResult orElse(),
  }) {
    if (tokenExpire != null) {
      return tokenExpire(field0);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(VanillaLaunchError_TokenExpire value) tokenExpire,
    required TResult Function(VanillaLaunchError_Io value) io,
    required TResult Function(VanillaLaunchError_Other value) other,
  }) {
    return tokenExpire(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(VanillaLaunchError_TokenExpire value)? tokenExpire,
    TResult? Function(VanillaLaunchError_Io value)? io,
    TResult? Function(VanillaLaunchError_Other value)? other,
  }) {
    return tokenExpire?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(VanillaLaunchError_TokenExpire value)? tokenExpire,
    TResult Function(VanillaLaunchError_Io value)? io,
    TResult Function(VanillaLaunchError_Other value)? other,
    required TResult orElse(),
  }) {
    if (tokenExpire != null) {
      return tokenExpire(this);
    }
    return orElse();
  }
}

abstract class VanillaLaunchError_TokenExpire implements VanillaLaunchError {
  const factory VanillaLaunchError_TokenExpire(final DateTime field0) =
      _$VanillaLaunchError_TokenExpire;

  @override
  DateTime get field0;
  @JsonKey(ignore: true)
  _$$VanillaLaunchError_TokenExpireCopyWith<_$VanillaLaunchError_TokenExpire>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$VanillaLaunchError_IoCopyWith<$Res> {
  factory _$$VanillaLaunchError_IoCopyWith(_$VanillaLaunchError_Io value,
          $Res Function(_$VanillaLaunchError_Io) then) =
      __$$VanillaLaunchError_IoCopyWithImpl<$Res>;
  @useResult
  $Res call({CustomIoErrorKind field0});
}

/// @nodoc
class __$$VanillaLaunchError_IoCopyWithImpl<$Res>
    extends _$VanillaLaunchErrorCopyWithImpl<$Res, _$VanillaLaunchError_Io>
    implements _$$VanillaLaunchError_IoCopyWith<$Res> {
  __$$VanillaLaunchError_IoCopyWithImpl(_$VanillaLaunchError_Io _value,
      $Res Function(_$VanillaLaunchError_Io) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? field0 = null,
  }) {
    return _then(_$VanillaLaunchError_Io(
      null == field0
          ? _value.field0
          : field0 // ignore: cast_nullable_to_non_nullable
              as CustomIoErrorKind,
    ));
  }
}

/// @nodoc

class _$VanillaLaunchError_Io implements VanillaLaunchError_Io {
  const _$VanillaLaunchError_Io(this.field0);

  @override
  final CustomIoErrorKind field0;

  @override
  String toString() {
    return 'VanillaLaunchError.io(field0: $field0)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VanillaLaunchError_Io &&
            (identical(other.field0, field0) || other.field0 == field0));
  }

  @override
  int get hashCode => Object.hash(runtimeType, field0);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$VanillaLaunchError_IoCopyWith<_$VanillaLaunchError_Io> get copyWith =>
      __$$VanillaLaunchError_IoCopyWithImpl<_$VanillaLaunchError_Io>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(DateTime field0) tokenExpire,
    required TResult Function(CustomIoErrorKind field0) io,
    required TResult Function(String field0) other,
  }) {
    return io(field0);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(DateTime field0)? tokenExpire,
    TResult? Function(CustomIoErrorKind field0)? io,
    TResult? Function(String field0)? other,
  }) {
    return io?.call(field0);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(DateTime field0)? tokenExpire,
    TResult Function(CustomIoErrorKind field0)? io,
    TResult Function(String field0)? other,
    required TResult orElse(),
  }) {
    if (io != null) {
      return io(field0);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(VanillaLaunchError_TokenExpire value) tokenExpire,
    required TResult Function(VanillaLaunchError_Io value) io,
    required TResult Function(VanillaLaunchError_Other value) other,
  }) {
    return io(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(VanillaLaunchError_TokenExpire value)? tokenExpire,
    TResult? Function(VanillaLaunchError_Io value)? io,
    TResult? Function(VanillaLaunchError_Other value)? other,
  }) {
    return io?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(VanillaLaunchError_TokenExpire value)? tokenExpire,
    TResult Function(VanillaLaunchError_Io value)? io,
    TResult Function(VanillaLaunchError_Other value)? other,
    required TResult orElse(),
  }) {
    if (io != null) {
      return io(this);
    }
    return orElse();
  }
}

abstract class VanillaLaunchError_Io implements VanillaLaunchError {
  const factory VanillaLaunchError_Io(final CustomIoErrorKind field0) =
      _$VanillaLaunchError_Io;

  @override
  CustomIoErrorKind get field0;
  @JsonKey(ignore: true)
  _$$VanillaLaunchError_IoCopyWith<_$VanillaLaunchError_Io> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$VanillaLaunchError_OtherCopyWith<$Res> {
  factory _$$VanillaLaunchError_OtherCopyWith(_$VanillaLaunchError_Other value,
          $Res Function(_$VanillaLaunchError_Other) then) =
      __$$VanillaLaunchError_OtherCopyWithImpl<$Res>;
  @useResult
  $Res call({String field0});
}

/// @nodoc
class __$$VanillaLaunchError_OtherCopyWithImpl<$Res>
    extends _$VanillaLaunchErrorCopyWithImpl<$Res, _$VanillaLaunchError_Other>
    implements _$$VanillaLaunchError_OtherCopyWith<$Res> {
  __$$VanillaLaunchError_OtherCopyWithImpl(_$VanillaLaunchError_Other _value,
      $Res Function(_$VanillaLaunchError_Other) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? field0 = null,
  }) {
    return _then(_$VanillaLaunchError_Other(
      null == field0
          ? _value.field0
          : field0 // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$VanillaLaunchError_Other implements VanillaLaunchError_Other {
  const _$VanillaLaunchError_Other(this.field0);

  @override
  final String field0;

  @override
  String toString() {
    return 'VanillaLaunchError.other(field0: $field0)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VanillaLaunchError_Other &&
            (identical(other.field0, field0) || other.field0 == field0));
  }

  @override
  int get hashCode => Object.hash(runtimeType, field0);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$VanillaLaunchError_OtherCopyWith<_$VanillaLaunchError_Other>
      get copyWith =>
          __$$VanillaLaunchError_OtherCopyWithImpl<_$VanillaLaunchError_Other>(
              this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(DateTime field0) tokenExpire,
    required TResult Function(CustomIoErrorKind field0) io,
    required TResult Function(String field0) other,
  }) {
    return other(field0);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(DateTime field0)? tokenExpire,
    TResult? Function(CustomIoErrorKind field0)? io,
    TResult? Function(String field0)? other,
  }) {
    return other?.call(field0);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(DateTime field0)? tokenExpire,
    TResult Function(CustomIoErrorKind field0)? io,
    TResult Function(String field0)? other,
    required TResult orElse(),
  }) {
    if (other != null) {
      return other(field0);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(VanillaLaunchError_TokenExpire value) tokenExpire,
    required TResult Function(VanillaLaunchError_Io value) io,
    required TResult Function(VanillaLaunchError_Other value) other,
  }) {
    return other(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(VanillaLaunchError_TokenExpire value)? tokenExpire,
    TResult? Function(VanillaLaunchError_Io value)? io,
    TResult? Function(VanillaLaunchError_Other value)? other,
  }) {
    return other?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(VanillaLaunchError_TokenExpire value)? tokenExpire,
    TResult Function(VanillaLaunchError_Io value)? io,
    TResult Function(VanillaLaunchError_Other value)? other,
    required TResult orElse(),
  }) {
    if (other != null) {
      return other(this);
    }
    return orElse();
  }
}

abstract class VanillaLaunchError_Other implements VanillaLaunchError {
  const factory VanillaLaunchError_Other(final String field0) =
      _$VanillaLaunchError_Other;

  @override
  String get field0;
  @JsonKey(ignore: true)
  _$$VanillaLaunchError_OtherCopyWith<_$VanillaLaunchError_Other>
      get copyWith => throw _privateConstructorUsedError;
}
