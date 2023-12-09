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
mixin _$VersionMetadata {
  String get id => throw _privateConstructorUsedError;
  VersionType get versionType => throw _privateConstructorUsedError;
  String get url => throw _privateConstructorUsedError;
  DateTime get uploadedTime => throw _privateConstructorUsedError;
  DateTime get releaseTime => throw _privateConstructorUsedError;
  String get sha1 => throw _privateConstructorUsedError;
  int get complianceLevel => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $VersionMetadataCopyWith<VersionMetadata> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VersionMetadataCopyWith<$Res> {
  factory $VersionMetadataCopyWith(
          VersionMetadata value, $Res Function(VersionMetadata) then) =
      _$VersionMetadataCopyWithImpl<$Res, VersionMetadata>;
  @useResult
  $Res call(
      {String id,
      VersionType versionType,
      String url,
      DateTime uploadedTime,
      DateTime releaseTime,
      String sha1,
      int complianceLevel});
}

/// @nodoc
class _$VersionMetadataCopyWithImpl<$Res, $Val extends VersionMetadata>
    implements $VersionMetadataCopyWith<$Res> {
  _$VersionMetadataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? versionType = null,
    Object? url = null,
    Object? uploadedTime = null,
    Object? releaseTime = null,
    Object? sha1 = null,
    Object? complianceLevel = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      versionType: null == versionType
          ? _value.versionType
          : versionType // ignore: cast_nullable_to_non_nullable
              as VersionType,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      uploadedTime: null == uploadedTime
          ? _value.uploadedTime
          : uploadedTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      releaseTime: null == releaseTime
          ? _value.releaseTime
          : releaseTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      sha1: null == sha1
          ? _value.sha1
          : sha1 // ignore: cast_nullable_to_non_nullable
              as String,
      complianceLevel: null == complianceLevel
          ? _value.complianceLevel
          : complianceLevel // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$VersionMetadataImplCopyWith<$Res>
    implements $VersionMetadataCopyWith<$Res> {
  factory _$$VersionMetadataImplCopyWith(_$VersionMetadataImpl value,
          $Res Function(_$VersionMetadataImpl) then) =
      __$$VersionMetadataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      VersionType versionType,
      String url,
      DateTime uploadedTime,
      DateTime releaseTime,
      String sha1,
      int complianceLevel});
}

/// @nodoc
class __$$VersionMetadataImplCopyWithImpl<$Res>
    extends _$VersionMetadataCopyWithImpl<$Res, _$VersionMetadataImpl>
    implements _$$VersionMetadataImplCopyWith<$Res> {
  __$$VersionMetadataImplCopyWithImpl(
      _$VersionMetadataImpl _value, $Res Function(_$VersionMetadataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? versionType = null,
    Object? url = null,
    Object? uploadedTime = null,
    Object? releaseTime = null,
    Object? sha1 = null,
    Object? complianceLevel = null,
  }) {
    return _then(_$VersionMetadataImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      versionType: null == versionType
          ? _value.versionType
          : versionType // ignore: cast_nullable_to_non_nullable
              as VersionType,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      uploadedTime: null == uploadedTime
          ? _value.uploadedTime
          : uploadedTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      releaseTime: null == releaseTime
          ? _value.releaseTime
          : releaseTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      sha1: null == sha1
          ? _value.sha1
          : sha1 // ignore: cast_nullable_to_non_nullable
              as String,
      complianceLevel: null == complianceLevel
          ? _value.complianceLevel
          : complianceLevel // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$VersionMetadataImpl implements _VersionMetadata {
  const _$VersionMetadataImpl(
      {required this.id,
      required this.versionType,
      required this.url,
      required this.uploadedTime,
      required this.releaseTime,
      required this.sha1,
      required this.complianceLevel});

  @override
  final String id;
  @override
  final VersionType versionType;
  @override
  final String url;
  @override
  final DateTime uploadedTime;
  @override
  final DateTime releaseTime;
  @override
  final String sha1;
  @override
  final int complianceLevel;

  @override
  String toString() {
    return 'VersionMetadata(id: $id, versionType: $versionType, url: $url, uploadedTime: $uploadedTime, releaseTime: $releaseTime, sha1: $sha1, complianceLevel: $complianceLevel)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VersionMetadataImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.versionType, versionType) ||
                other.versionType == versionType) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.uploadedTime, uploadedTime) ||
                other.uploadedTime == uploadedTime) &&
            (identical(other.releaseTime, releaseTime) ||
                other.releaseTime == releaseTime) &&
            (identical(other.sha1, sha1) || other.sha1 == sha1) &&
            (identical(other.complianceLevel, complianceLevel) ||
                other.complianceLevel == complianceLevel));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, versionType, url,
      uploadedTime, releaseTime, sha1, complianceLevel);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$VersionMetadataImplCopyWith<_$VersionMetadataImpl> get copyWith =>
      __$$VersionMetadataImplCopyWithImpl<_$VersionMetadataImpl>(
          this, _$identity);
}

abstract class _VersionMetadata implements VersionMetadata {
  const factory _VersionMetadata(
      {required final String id,
      required final VersionType versionType,
      required final String url,
      required final DateTime uploadedTime,
      required final DateTime releaseTime,
      required final String sha1,
      required final int complianceLevel}) = _$VersionMetadataImpl;

  @override
  String get id;
  @override
  VersionType get versionType;
  @override
  String get url;
  @override
  DateTime get uploadedTime;
  @override
  DateTime get releaseTime;
  @override
  String get sha1;
  @override
  int get complianceLevel;
  @override
  @JsonKey(ignore: true)
  _$$VersionMetadataImplCopyWith<_$VersionMetadataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
