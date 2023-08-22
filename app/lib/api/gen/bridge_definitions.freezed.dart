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
mixin _$AccountToken {
  String get token => throw _privateConstructorUsedError;
  int get expiresAt => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AccountTokenCopyWith<AccountToken> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AccountTokenCopyWith<$Res> {
  factory $AccountTokenCopyWith(
          AccountToken value, $Res Function(AccountToken) then) =
      _$AccountTokenCopyWithImpl<$Res, AccountToken>;
  @useResult
  $Res call({String token, int expiresAt});
}

/// @nodoc
class _$AccountTokenCopyWithImpl<$Res, $Val extends AccountToken>
    implements $AccountTokenCopyWith<$Res> {
  _$AccountTokenCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? token = null,
    Object? expiresAt = null,
  }) {
    return _then(_value.copyWith(
      token: null == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String,
      expiresAt: null == expiresAt
          ? _value.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_AccountTokenCopyWith<$Res>
    implements $AccountTokenCopyWith<$Res> {
  factory _$$_AccountTokenCopyWith(
          _$_AccountToken value, $Res Function(_$_AccountToken) then) =
      __$$_AccountTokenCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String token, int expiresAt});
}

/// @nodoc
class __$$_AccountTokenCopyWithImpl<$Res>
    extends _$AccountTokenCopyWithImpl<$Res, _$_AccountToken>
    implements _$$_AccountTokenCopyWith<$Res> {
  __$$_AccountTokenCopyWithImpl(
      _$_AccountToken _value, $Res Function(_$_AccountToken) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? token = null,
    Object? expiresAt = null,
  }) {
    return _then(_$_AccountToken(
      token: null == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String,
      expiresAt: null == expiresAt
          ? _value.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$_AccountToken implements _AccountToken {
  const _$_AccountToken({required this.token, required this.expiresAt});

  @override
  final String token;
  @override
  final int expiresAt;

  @override
  String toString() {
    return 'AccountToken(token: $token, expiresAt: $expiresAt)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AccountToken &&
            (identical(other.token, token) || other.token == token) &&
            (identical(other.expiresAt, expiresAt) ||
                other.expiresAt == expiresAt));
  }

  @override
  int get hashCode => Object.hash(runtimeType, token, expiresAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AccountTokenCopyWith<_$_AccountToken> get copyWith =>
      __$$_AccountTokenCopyWithImpl<_$_AccountToken>(this, _$identity);
}

abstract class _AccountToken implements AccountToken {
  const factory _AccountToken(
      {required final String token,
      required final int expiresAt}) = _$_AccountToken;

  @override
  String get token;
  @override
  int get expiresAt;
  @override
  @JsonKey(ignore: true)
  _$$_AccountTokenCopyWith<_$_AccountToken> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$LoginFlowErrors {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(XstsTokenErrorType field0) xstsError,
    required TResult Function() gameNotOwned,
    required TResult Function(String field0) unknownError,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(XstsTokenErrorType field0)? xstsError,
    TResult? Function()? gameNotOwned,
    TResult? Function(String field0)? unknownError,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(XstsTokenErrorType field0)? xstsError,
    TResult Function()? gameNotOwned,
    TResult Function(String field0)? unknownError,
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
    required TResult Function(String field0) unknownError,
  }) {
    return xstsError(field0);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(XstsTokenErrorType field0)? xstsError,
    TResult? Function()? gameNotOwned,
    TResult? Function(String field0)? unknownError,
  }) {
    return xstsError?.call(field0);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(XstsTokenErrorType field0)? xstsError,
    TResult Function()? gameNotOwned,
    TResult Function(String field0)? unknownError,
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
    required TResult Function(String field0) unknownError,
  }) {
    return gameNotOwned();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(XstsTokenErrorType field0)? xstsError,
    TResult? Function()? gameNotOwned,
    TResult? Function(String field0)? unknownError,
  }) {
    return gameNotOwned?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(XstsTokenErrorType field0)? xstsError,
    TResult Function()? gameNotOwned,
    TResult Function(String field0)? unknownError,
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
  @useResult
  $Res call({String field0});
}

/// @nodoc
class __$$LoginFlowErrors_UnknownErrorCopyWithImpl<$Res>
    extends _$LoginFlowErrorsCopyWithImpl<$Res, _$LoginFlowErrors_UnknownError>
    implements _$$LoginFlowErrors_UnknownErrorCopyWith<$Res> {
  __$$LoginFlowErrors_UnknownErrorCopyWithImpl(
      _$LoginFlowErrors_UnknownError _value,
      $Res Function(_$LoginFlowErrors_UnknownError) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? field0 = null,
  }) {
    return _then(_$LoginFlowErrors_UnknownError(
      null == field0
          ? _value.field0
          : field0 // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$LoginFlowErrors_UnknownError implements LoginFlowErrors_UnknownError {
  const _$LoginFlowErrors_UnknownError(this.field0);

  @override
  final String field0;

  @override
  String toString() {
    return 'LoginFlowErrors.unknownError(field0: $field0)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoginFlowErrors_UnknownError &&
            (identical(other.field0, field0) || other.field0 == field0));
  }

  @override
  int get hashCode => Object.hash(runtimeType, field0);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LoginFlowErrors_UnknownErrorCopyWith<_$LoginFlowErrors_UnknownError>
      get copyWith => __$$LoginFlowErrors_UnknownErrorCopyWithImpl<
          _$LoginFlowErrors_UnknownError>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(XstsTokenErrorType field0) xstsError,
    required TResult Function() gameNotOwned,
    required TResult Function(String field0) unknownError,
  }) {
    return unknownError(field0);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(XstsTokenErrorType field0)? xstsError,
    TResult? Function()? gameNotOwned,
    TResult? Function(String field0)? unknownError,
  }) {
    return unknownError?.call(field0);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(XstsTokenErrorType field0)? xstsError,
    TResult Function()? gameNotOwned,
    TResult Function(String field0)? unknownError,
    required TResult orElse(),
  }) {
    if (unknownError != null) {
      return unknownError(field0);
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
  const factory LoginFlowErrors_UnknownError(final String field0) =
      _$LoginFlowErrors_UnknownError;

  String get field0;
  @JsonKey(ignore: true)
  _$$LoginFlowErrors_UnknownErrorCopyWith<_$LoginFlowErrors_UnknownError>
      get copyWith => throw _privateConstructorUsedError;
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

  $MinecraftAccountCopyWith<$Res> get field0;
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

  @override
  @pragma('vm:prefer-inline')
  $MinecraftAccountCopyWith<$Res> get field0 {
    return $MinecraftAccountCopyWith<$Res>(_value.field0, (value) {
      return _then(_value.copyWith(field0: value));
    });
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
mixin _$MinecraftAccount {
  String get username => throw _privateConstructorUsedError;
  UuidValue get uuid => throw _privateConstructorUsedError;
  AccountToken get accessToken => throw _privateConstructorUsedError;
  AccountToken get refreshToken => throw _privateConstructorUsedError;
  List<MinecraftSkin> get skins => throw _privateConstructorUsedError;
  List<MinecraftCape> get capes => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MinecraftAccountCopyWith<MinecraftAccount> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MinecraftAccountCopyWith<$Res> {
  factory $MinecraftAccountCopyWith(
          MinecraftAccount value, $Res Function(MinecraftAccount) then) =
      _$MinecraftAccountCopyWithImpl<$Res, MinecraftAccount>;
  @useResult
  $Res call(
      {String username,
      UuidValue uuid,
      AccountToken accessToken,
      AccountToken refreshToken,
      List<MinecraftSkin> skins,
      List<MinecraftCape> capes});

  $AccountTokenCopyWith<$Res> get accessToken;
  $AccountTokenCopyWith<$Res> get refreshToken;
}

/// @nodoc
class _$MinecraftAccountCopyWithImpl<$Res, $Val extends MinecraftAccount>
    implements $MinecraftAccountCopyWith<$Res> {
  _$MinecraftAccountCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? username = null,
    Object? uuid = null,
    Object? accessToken = null,
    Object? refreshToken = null,
    Object? skins = null,
    Object? capes = null,
  }) {
    return _then(_value.copyWith(
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      uuid: null == uuid
          ? _value.uuid
          : uuid // ignore: cast_nullable_to_non_nullable
              as UuidValue,
      accessToken: null == accessToken
          ? _value.accessToken
          : accessToken // ignore: cast_nullable_to_non_nullable
              as AccountToken,
      refreshToken: null == refreshToken
          ? _value.refreshToken
          : refreshToken // ignore: cast_nullable_to_non_nullable
              as AccountToken,
      skins: null == skins
          ? _value.skins
          : skins // ignore: cast_nullable_to_non_nullable
              as List<MinecraftSkin>,
      capes: null == capes
          ? _value.capes
          : capes // ignore: cast_nullable_to_non_nullable
              as List<MinecraftCape>,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $AccountTokenCopyWith<$Res> get accessToken {
    return $AccountTokenCopyWith<$Res>(_value.accessToken, (value) {
      return _then(_value.copyWith(accessToken: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $AccountTokenCopyWith<$Res> get refreshToken {
    return $AccountTokenCopyWith<$Res>(_value.refreshToken, (value) {
      return _then(_value.copyWith(refreshToken: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_MinecraftAccountCopyWith<$Res>
    implements $MinecraftAccountCopyWith<$Res> {
  factory _$$_MinecraftAccountCopyWith(
          _$_MinecraftAccount value, $Res Function(_$_MinecraftAccount) then) =
      __$$_MinecraftAccountCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String username,
      UuidValue uuid,
      AccountToken accessToken,
      AccountToken refreshToken,
      List<MinecraftSkin> skins,
      List<MinecraftCape> capes});

  @override
  $AccountTokenCopyWith<$Res> get accessToken;
  @override
  $AccountTokenCopyWith<$Res> get refreshToken;
}

/// @nodoc
class __$$_MinecraftAccountCopyWithImpl<$Res>
    extends _$MinecraftAccountCopyWithImpl<$Res, _$_MinecraftAccount>
    implements _$$_MinecraftAccountCopyWith<$Res> {
  __$$_MinecraftAccountCopyWithImpl(
      _$_MinecraftAccount _value, $Res Function(_$_MinecraftAccount) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? username = null,
    Object? uuid = null,
    Object? accessToken = null,
    Object? refreshToken = null,
    Object? skins = null,
    Object? capes = null,
  }) {
    return _then(_$_MinecraftAccount(
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      uuid: null == uuid
          ? _value.uuid
          : uuid // ignore: cast_nullable_to_non_nullable
              as UuidValue,
      accessToken: null == accessToken
          ? _value.accessToken
          : accessToken // ignore: cast_nullable_to_non_nullable
              as AccountToken,
      refreshToken: null == refreshToken
          ? _value.refreshToken
          : refreshToken // ignore: cast_nullable_to_non_nullable
              as AccountToken,
      skins: null == skins
          ? _value._skins
          : skins // ignore: cast_nullable_to_non_nullable
              as List<MinecraftSkin>,
      capes: null == capes
          ? _value._capes
          : capes // ignore: cast_nullable_to_non_nullable
              as List<MinecraftCape>,
    ));
  }
}

/// @nodoc

class _$_MinecraftAccount implements _MinecraftAccount {
  const _$_MinecraftAccount(
      {required this.username,
      required this.uuid,
      required this.accessToken,
      required this.refreshToken,
      required final List<MinecraftSkin> skins,
      required final List<MinecraftCape> capes})
      : _skins = skins,
        _capes = capes;

  @override
  final String username;
  @override
  final UuidValue uuid;
  @override
  final AccountToken accessToken;
  @override
  final AccountToken refreshToken;
  final List<MinecraftSkin> _skins;
  @override
  List<MinecraftSkin> get skins {
    if (_skins is EqualUnmodifiableListView) return _skins;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_skins);
  }

  final List<MinecraftCape> _capes;
  @override
  List<MinecraftCape> get capes {
    if (_capes is EqualUnmodifiableListView) return _capes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_capes);
  }

  @override
  String toString() {
    return 'MinecraftAccount(username: $username, uuid: $uuid, accessToken: $accessToken, refreshToken: $refreshToken, skins: $skins, capes: $capes)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_MinecraftAccount &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.uuid, uuid) || other.uuid == uuid) &&
            (identical(other.accessToken, accessToken) ||
                other.accessToken == accessToken) &&
            (identical(other.refreshToken, refreshToken) ||
                other.refreshToken == refreshToken) &&
            const DeepCollectionEquality().equals(other._skins, _skins) &&
            const DeepCollectionEquality().equals(other._capes, _capes));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      username,
      uuid,
      accessToken,
      refreshToken,
      const DeepCollectionEquality().hash(_skins),
      const DeepCollectionEquality().hash(_capes));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_MinecraftAccountCopyWith<_$_MinecraftAccount> get copyWith =>
      __$$_MinecraftAccountCopyWithImpl<_$_MinecraftAccount>(this, _$identity);
}

abstract class _MinecraftAccount implements MinecraftAccount {
  const factory _MinecraftAccount(
      {required final String username,
      required final UuidValue uuid,
      required final AccountToken accessToken,
      required final AccountToken refreshToken,
      required final List<MinecraftSkin> skins,
      required final List<MinecraftCape> capes}) = _$_MinecraftAccount;

  @override
  String get username;
  @override
  UuidValue get uuid;
  @override
  AccountToken get accessToken;
  @override
  AccountToken get refreshToken;
  @override
  List<MinecraftSkin> get skins;
  @override
  List<MinecraftCape> get capes;
  @override
  @JsonKey(ignore: true)
  _$$_MinecraftAccountCopyWith<_$_MinecraftAccount> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$MinecraftCape {
  UuidValue get id => throw _privateConstructorUsedError;
  String get state => throw _privateConstructorUsedError;
  String get url => throw _privateConstructorUsedError;
  String get alias => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MinecraftCapeCopyWith<MinecraftCape> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MinecraftCapeCopyWith<$Res> {
  factory $MinecraftCapeCopyWith(
          MinecraftCape value, $Res Function(MinecraftCape) then) =
      _$MinecraftCapeCopyWithImpl<$Res, MinecraftCape>;
  @useResult
  $Res call({UuidValue id, String state, String url, String alias});
}

/// @nodoc
class _$MinecraftCapeCopyWithImpl<$Res, $Val extends MinecraftCape>
    implements $MinecraftCapeCopyWith<$Res> {
  _$MinecraftCapeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? state = null,
    Object? url = null,
    Object? alias = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as UuidValue,
      state: null == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      alias: null == alias
          ? _value.alias
          : alias // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_MinecraftCapeCopyWith<$Res>
    implements $MinecraftCapeCopyWith<$Res> {
  factory _$$_MinecraftCapeCopyWith(
          _$_MinecraftCape value, $Res Function(_$_MinecraftCape) then) =
      __$$_MinecraftCapeCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({UuidValue id, String state, String url, String alias});
}

/// @nodoc
class __$$_MinecraftCapeCopyWithImpl<$Res>
    extends _$MinecraftCapeCopyWithImpl<$Res, _$_MinecraftCape>
    implements _$$_MinecraftCapeCopyWith<$Res> {
  __$$_MinecraftCapeCopyWithImpl(
      _$_MinecraftCape _value, $Res Function(_$_MinecraftCape) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? state = null,
    Object? url = null,
    Object? alias = null,
  }) {
    return _then(_$_MinecraftCape(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as UuidValue,
      state: null == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      alias: null == alias
          ? _value.alias
          : alias // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_MinecraftCape implements _MinecraftCape {
  const _$_MinecraftCape(
      {required this.id,
      required this.state,
      required this.url,
      required this.alias});

  @override
  final UuidValue id;
  @override
  final String state;
  @override
  final String url;
  @override
  final String alias;

  @override
  String toString() {
    return 'MinecraftCape(id: $id, state: $state, url: $url, alias: $alias)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_MinecraftCape &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.state, state) || other.state == state) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.alias, alias) || other.alias == alias));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, state, url, alias);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_MinecraftCapeCopyWith<_$_MinecraftCape> get copyWith =>
      __$$_MinecraftCapeCopyWithImpl<_$_MinecraftCape>(this, _$identity);
}

abstract class _MinecraftCape implements MinecraftCape {
  const factory _MinecraftCape(
      {required final UuidValue id,
      required final String state,
      required final String url,
      required final String alias}) = _$_MinecraftCape;

  @override
  UuidValue get id;
  @override
  String get state;
  @override
  String get url;
  @override
  String get alias;
  @override
  @JsonKey(ignore: true)
  _$$_MinecraftCapeCopyWith<_$_MinecraftCape> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$MinecraftSkin {
  UuidValue get id => throw _privateConstructorUsedError;
  String get state => throw _privateConstructorUsedError;
  String get url => throw _privateConstructorUsedError;
  MinecraftSkinVariant get variant => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MinecraftSkinCopyWith<MinecraftSkin> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MinecraftSkinCopyWith<$Res> {
  factory $MinecraftSkinCopyWith(
          MinecraftSkin value, $Res Function(MinecraftSkin) then) =
      _$MinecraftSkinCopyWithImpl<$Res, MinecraftSkin>;
  @useResult
  $Res call(
      {UuidValue id, String state, String url, MinecraftSkinVariant variant});
}

/// @nodoc
class _$MinecraftSkinCopyWithImpl<$Res, $Val extends MinecraftSkin>
    implements $MinecraftSkinCopyWith<$Res> {
  _$MinecraftSkinCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? state = null,
    Object? url = null,
    Object? variant = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as UuidValue,
      state: null == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      variant: null == variant
          ? _value.variant
          : variant // ignore: cast_nullable_to_non_nullable
              as MinecraftSkinVariant,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_MinecraftSkinCopyWith<$Res>
    implements $MinecraftSkinCopyWith<$Res> {
  factory _$$_MinecraftSkinCopyWith(
          _$_MinecraftSkin value, $Res Function(_$_MinecraftSkin) then) =
      __$$_MinecraftSkinCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {UuidValue id, String state, String url, MinecraftSkinVariant variant});
}

/// @nodoc
class __$$_MinecraftSkinCopyWithImpl<$Res>
    extends _$MinecraftSkinCopyWithImpl<$Res, _$_MinecraftSkin>
    implements _$$_MinecraftSkinCopyWith<$Res> {
  __$$_MinecraftSkinCopyWithImpl(
      _$_MinecraftSkin _value, $Res Function(_$_MinecraftSkin) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? state = null,
    Object? url = null,
    Object? variant = null,
  }) {
    return _then(_$_MinecraftSkin(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as UuidValue,
      state: null == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      variant: null == variant
          ? _value.variant
          : variant // ignore: cast_nullable_to_non_nullable
              as MinecraftSkinVariant,
    ));
  }
}

/// @nodoc

class _$_MinecraftSkin implements _MinecraftSkin {
  const _$_MinecraftSkin(
      {required this.id,
      required this.state,
      required this.url,
      required this.variant});

  @override
  final UuidValue id;
  @override
  final String state;
  @override
  final String url;
  @override
  final MinecraftSkinVariant variant;

  @override
  String toString() {
    return 'MinecraftSkin(id: $id, state: $state, url: $url, variant: $variant)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_MinecraftSkin &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.state, state) || other.state == state) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.variant, variant) || other.variant == variant));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, state, url, variant);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_MinecraftSkinCopyWith<_$_MinecraftSkin> get copyWith =>
      __$$_MinecraftSkinCopyWithImpl<_$_MinecraftSkin>(this, _$identity);
}

abstract class _MinecraftSkin implements MinecraftSkin {
  const factory _MinecraftSkin(
      {required final UuidValue id,
      required final String state,
      required final String url,
      required final MinecraftSkinVariant variant}) = _$_MinecraftSkin;

  @override
  UuidValue get id;
  @override
  String get state;
  @override
  String get url;
  @override
  MinecraftSkinVariant get variant;
  @override
  @JsonKey(ignore: true)
  _$$_MinecraftSkinCopyWith<_$_MinecraftSkin> get copyWith =>
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
