// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'account_storage.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

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
abstract class _$$AccountStorageValue_AccountsImplCopyWith<$Res> {
  factory _$$AccountStorageValue_AccountsImplCopyWith(
          _$AccountStorageValue_AccountsImpl value,
          $Res Function(_$AccountStorageValue_AccountsImpl) then) =
      __$$AccountStorageValue_AccountsImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<MinecraftAccount> field0});
}

/// @nodoc
class __$$AccountStorageValue_AccountsImplCopyWithImpl<$Res>
    extends _$AccountStorageValueCopyWithImpl<$Res,
        _$AccountStorageValue_AccountsImpl>
    implements _$$AccountStorageValue_AccountsImplCopyWith<$Res> {
  __$$AccountStorageValue_AccountsImplCopyWithImpl(
      _$AccountStorageValue_AccountsImpl _value,
      $Res Function(_$AccountStorageValue_AccountsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? field0 = null,
  }) {
    return _then(_$AccountStorageValue_AccountsImpl(
      null == field0
          ? _value._field0
          : field0 // ignore: cast_nullable_to_non_nullable
              as List<MinecraftAccount>,
    ));
  }
}

/// @nodoc

class _$AccountStorageValue_AccountsImpl
    implements AccountStorageValue_Accounts {
  const _$AccountStorageValue_AccountsImpl(final List<MinecraftAccount> field0)
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
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AccountStorageValue_AccountsImpl &&
            const DeepCollectionEquality().equals(other._field0, _field0));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_field0));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AccountStorageValue_AccountsImplCopyWith<
          _$AccountStorageValue_AccountsImpl>
      get copyWith => __$$AccountStorageValue_AccountsImplCopyWithImpl<
          _$AccountStorageValue_AccountsImpl>(this, _$identity);

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
      final List<MinecraftAccount> field0) = _$AccountStorageValue_AccountsImpl;

  @override
  List<MinecraftAccount> get field0;
  @JsonKey(ignore: true)
  _$$AccountStorageValue_AccountsImplCopyWith<
          _$AccountStorageValue_AccountsImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AccountStorageValue_MainAccountImplCopyWith<$Res> {
  factory _$$AccountStorageValue_MainAccountImplCopyWith(
          _$AccountStorageValue_MainAccountImpl value,
          $Res Function(_$AccountStorageValue_MainAccountImpl) then) =
      __$$AccountStorageValue_MainAccountImplCopyWithImpl<$Res>;
  @useResult
  $Res call({UuidValue? field0});
}

/// @nodoc
class __$$AccountStorageValue_MainAccountImplCopyWithImpl<$Res>
    extends _$AccountStorageValueCopyWithImpl<$Res,
        _$AccountStorageValue_MainAccountImpl>
    implements _$$AccountStorageValue_MainAccountImplCopyWith<$Res> {
  __$$AccountStorageValue_MainAccountImplCopyWithImpl(
      _$AccountStorageValue_MainAccountImpl _value,
      $Res Function(_$AccountStorageValue_MainAccountImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? field0 = freezed,
  }) {
    return _then(_$AccountStorageValue_MainAccountImpl(
      freezed == field0
          ? _value.field0
          : field0 // ignore: cast_nullable_to_non_nullable
              as UuidValue?,
    ));
  }
}

/// @nodoc

class _$AccountStorageValue_MainAccountImpl
    implements AccountStorageValue_MainAccount {
  const _$AccountStorageValue_MainAccountImpl([this.field0]);

  @override
  final UuidValue? field0;

  @override
  String toString() {
    return 'AccountStorageValue.mainAccount(field0: $field0)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AccountStorageValue_MainAccountImpl &&
            (identical(other.field0, field0) || other.field0 == field0));
  }

  @override
  int get hashCode => Object.hash(runtimeType, field0);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AccountStorageValue_MainAccountImplCopyWith<
          _$AccountStorageValue_MainAccountImpl>
      get copyWith => __$$AccountStorageValue_MainAccountImplCopyWithImpl<
          _$AccountStorageValue_MainAccountImpl>(this, _$identity);

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
      _$AccountStorageValue_MainAccountImpl;

  @override
  UuidValue? get field0;
  @JsonKey(ignore: true)
  _$$AccountStorageValue_MainAccountImplCopyWith<
          _$AccountStorageValue_MainAccountImpl>
      get copyWith => throw _privateConstructorUsedError;
}
