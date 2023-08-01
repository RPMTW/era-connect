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
mixin _$Value {
  Object get field0 => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String field0) fail,
    required TResult Function(bool field0) completedSetup,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String field0)? fail,
    TResult? Function(bool field0)? completedSetup,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String field0)? fail,
    TResult Function(bool field0)? completedSetup,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Value_Fail value) fail,
    required TResult Function(Value_CompletedSetup value) completedSetup,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Value_Fail value)? fail,
    TResult? Function(Value_CompletedSetup value)? completedSetup,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Value_Fail value)? fail,
    TResult Function(Value_CompletedSetup value)? completedSetup,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ValueCopyWith<$Res> {
  factory $ValueCopyWith(Value value, $Res Function(Value) then) =
      _$ValueCopyWithImpl<$Res, Value>;
}

/// @nodoc
class _$ValueCopyWithImpl<$Res, $Val extends Value>
    implements $ValueCopyWith<$Res> {
  _$ValueCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$Value_FailCopyWith<$Res> {
  factory _$$Value_FailCopyWith(
          _$Value_Fail value, $Res Function(_$Value_Fail) then) =
      __$$Value_FailCopyWithImpl<$Res>;
  @useResult
  $Res call({String field0});
}

/// @nodoc
class __$$Value_FailCopyWithImpl<$Res>
    extends _$ValueCopyWithImpl<$Res, _$Value_Fail>
    implements _$$Value_FailCopyWith<$Res> {
  __$$Value_FailCopyWithImpl(
      _$Value_Fail _value, $Res Function(_$Value_Fail) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? field0 = null,
  }) {
    return _then(_$Value_Fail(
      null == field0
          ? _value.field0
          : field0 // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$Value_Fail implements Value_Fail {
  const _$Value_Fail(this.field0);

  @override
  final String field0;

  @override
  String toString() {
    return 'Value.fail(field0: $field0)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Value_Fail &&
            (identical(other.field0, field0) || other.field0 == field0));
  }

  @override
  int get hashCode => Object.hash(runtimeType, field0);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$Value_FailCopyWith<_$Value_Fail> get copyWith =>
      __$$Value_FailCopyWithImpl<_$Value_Fail>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String field0) fail,
    required TResult Function(bool field0) completedSetup,
  }) {
    return fail(field0);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String field0)? fail,
    TResult? Function(bool field0)? completedSetup,
  }) {
    return fail?.call(field0);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String field0)? fail,
    TResult Function(bool field0)? completedSetup,
    required TResult orElse(),
  }) {
    if (fail != null) {
      return fail(field0);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Value_Fail value) fail,
    required TResult Function(Value_CompletedSetup value) completedSetup,
  }) {
    return fail(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Value_Fail value)? fail,
    TResult? Function(Value_CompletedSetup value)? completedSetup,
  }) {
    return fail?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Value_Fail value)? fail,
    TResult Function(Value_CompletedSetup value)? completedSetup,
    required TResult orElse(),
  }) {
    if (fail != null) {
      return fail(this);
    }
    return orElse();
  }
}

abstract class Value_Fail implements Value {
  const factory Value_Fail(final String field0) = _$Value_Fail;

  @override
  String get field0;
  @JsonKey(ignore: true)
  _$$Value_FailCopyWith<_$Value_Fail> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$Value_CompletedSetupCopyWith<$Res> {
  factory _$$Value_CompletedSetupCopyWith(_$Value_CompletedSetup value,
          $Res Function(_$Value_CompletedSetup) then) =
      __$$Value_CompletedSetupCopyWithImpl<$Res>;
  @useResult
  $Res call({bool field0});
}

/// @nodoc
class __$$Value_CompletedSetupCopyWithImpl<$Res>
    extends _$ValueCopyWithImpl<$Res, _$Value_CompletedSetup>
    implements _$$Value_CompletedSetupCopyWith<$Res> {
  __$$Value_CompletedSetupCopyWithImpl(_$Value_CompletedSetup _value,
      $Res Function(_$Value_CompletedSetup) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? field0 = null,
  }) {
    return _then(_$Value_CompletedSetup(
      null == field0
          ? _value.field0
          : field0 // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$Value_CompletedSetup implements Value_CompletedSetup {
  const _$Value_CompletedSetup(this.field0);

  @override
  final bool field0;

  @override
  String toString() {
    return 'Value.completedSetup(field0: $field0)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Value_CompletedSetup &&
            (identical(other.field0, field0) || other.field0 == field0));
  }

  @override
  int get hashCode => Object.hash(runtimeType, field0);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$Value_CompletedSetupCopyWith<_$Value_CompletedSetup> get copyWith =>
      __$$Value_CompletedSetupCopyWithImpl<_$Value_CompletedSetup>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String field0) fail,
    required TResult Function(bool field0) completedSetup,
  }) {
    return completedSetup(field0);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String field0)? fail,
    TResult? Function(bool field0)? completedSetup,
  }) {
    return completedSetup?.call(field0);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String field0)? fail,
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
    required TResult Function(Value_Fail value) fail,
    required TResult Function(Value_CompletedSetup value) completedSetup,
  }) {
    return completedSetup(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Value_Fail value)? fail,
    TResult? Function(Value_CompletedSetup value)? completedSetup,
  }) {
    return completedSetup?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Value_Fail value)? fail,
    TResult Function(Value_CompletedSetup value)? completedSetup,
    required TResult orElse(),
  }) {
    if (completedSetup != null) {
      return completedSetup(this);
    }
    return orElse();
  }
}

abstract class Value_CompletedSetup implements Value {
  const factory Value_CompletedSetup(final bool field0) =
      _$Value_CompletedSetup;

  @override
  bool get field0;
  @JsonKey(ignore: true)
  _$$Value_CompletedSetupCopyWith<_$Value_CompletedSetup> get copyWith =>
      throw _privateConstructorUsedError;
}
