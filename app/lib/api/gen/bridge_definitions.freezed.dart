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
mixin _$UILayout {
  String get fail => throw _privateConstructorUsedError;
  bool get completedSetup => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $UILayoutCopyWith<UILayout> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UILayoutCopyWith<$Res> {
  factory $UILayoutCopyWith(UILayout value, $Res Function(UILayout) then) =
      _$UILayoutCopyWithImpl<$Res, UILayout>;
  @useResult
  $Res call({String fail, bool completedSetup});
}

/// @nodoc
class _$UILayoutCopyWithImpl<$Res, $Val extends UILayout>
    implements $UILayoutCopyWith<$Res> {
  _$UILayoutCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fail = null,
    Object? completedSetup = null,
  }) {
    return _then(_value.copyWith(
      fail: null == fail
          ? _value.fail
          : fail // ignore: cast_nullable_to_non_nullable
              as String,
      completedSetup: null == completedSetup
          ? _value.completedSetup
          : completedSetup // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_UILayoutCopyWith<$Res> implements $UILayoutCopyWith<$Res> {
  factory _$$_UILayoutCopyWith(
          _$_UILayout value, $Res Function(_$_UILayout) then) =
      __$$_UILayoutCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String fail, bool completedSetup});
}

/// @nodoc
class __$$_UILayoutCopyWithImpl<$Res>
    extends _$UILayoutCopyWithImpl<$Res, _$_UILayout>
    implements _$$_UILayoutCopyWith<$Res> {
  __$$_UILayoutCopyWithImpl(
      _$_UILayout _value, $Res Function(_$_UILayout) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fail = null,
    Object? completedSetup = null,
  }) {
    return _then(_$_UILayout(
      fail: null == fail
          ? _value.fail
          : fail // ignore: cast_nullable_to_non_nullable
              as String,
      completedSetup: null == completedSetup
          ? _value.completedSetup
          : completedSetup // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_UILayout implements _UILayout {
  const _$_UILayout({required this.fail, required this.completedSetup});

  @override
  final String fail;
  @override
  final bool completedSetup;

  @override
  String toString() {
    return 'UILayout(fail: $fail, completedSetup: $completedSetup)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UILayout &&
            (identical(other.fail, fail) || other.fail == fail) &&
            (identical(other.completedSetup, completedSetup) ||
                other.completedSetup == completedSetup));
  }

  @override
  int get hashCode => Object.hash(runtimeType, fail, completedSetup);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_UILayoutCopyWith<_$_UILayout> get copyWith =>
      __$$_UILayoutCopyWithImpl<_$_UILayout>(this, _$identity);
}

abstract class _UILayout implements UILayout {
  const factory _UILayout(
      {required final String fail,
      required final bool completedSetup}) = _$_UILayout;

  @override
  String get fail;
  @override
  bool get completedSetup;
  @override
  @JsonKey(ignore: true)
  _$$_UILayoutCopyWith<_$_UILayout> get copyWith =>
      throw _privateConstructorUsedError;
}

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
    required TResult Function(Value_fail value) fail,
    required TResult Function(Value_completed_setup value) completedSetup,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Value_fail value)? fail,
    TResult? Function(Value_completed_setup value)? completedSetup,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Value_fail value)? fail,
    TResult Function(Value_completed_setup value)? completedSetup,
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
abstract class _$$Value_failCopyWith<$Res> {
  factory _$$Value_failCopyWith(
          _$Value_fail value, $Res Function(_$Value_fail) then) =
      __$$Value_failCopyWithImpl<$Res>;
  @useResult
  $Res call({String field0});
}

/// @nodoc
class __$$Value_failCopyWithImpl<$Res>
    extends _$ValueCopyWithImpl<$Res, _$Value_fail>
    implements _$$Value_failCopyWith<$Res> {
  __$$Value_failCopyWithImpl(
      _$Value_fail _value, $Res Function(_$Value_fail) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? field0 = null,
  }) {
    return _then(_$Value_fail(
      null == field0
          ? _value.field0
          : field0 // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$Value_fail implements Value_fail {
  const _$Value_fail(this.field0);

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
            other is _$Value_fail &&
            (identical(other.field0, field0) || other.field0 == field0));
  }

  @override
  int get hashCode => Object.hash(runtimeType, field0);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$Value_failCopyWith<_$Value_fail> get copyWith =>
      __$$Value_failCopyWithImpl<_$Value_fail>(this, _$identity);

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
    required TResult Function(Value_fail value) fail,
    required TResult Function(Value_completed_setup value) completedSetup,
  }) {
    return fail(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Value_fail value)? fail,
    TResult? Function(Value_completed_setup value)? completedSetup,
  }) {
    return fail?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Value_fail value)? fail,
    TResult Function(Value_completed_setup value)? completedSetup,
    required TResult orElse(),
  }) {
    if (fail != null) {
      return fail(this);
    }
    return orElse();
  }
}

abstract class Value_fail implements Value {
  const factory Value_fail(final String field0) = _$Value_fail;

  @override
  String get field0;
  @JsonKey(ignore: true)
  _$$Value_failCopyWith<_$Value_fail> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$Value_completed_setupCopyWith<$Res> {
  factory _$$Value_completed_setupCopyWith(_$Value_completed_setup value,
          $Res Function(_$Value_completed_setup) then) =
      __$$Value_completed_setupCopyWithImpl<$Res>;
  @useResult
  $Res call({bool field0});
}

/// @nodoc
class __$$Value_completed_setupCopyWithImpl<$Res>
    extends _$ValueCopyWithImpl<$Res, _$Value_completed_setup>
    implements _$$Value_completed_setupCopyWith<$Res> {
  __$$Value_completed_setupCopyWithImpl(_$Value_completed_setup _value,
      $Res Function(_$Value_completed_setup) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? field0 = null,
  }) {
    return _then(_$Value_completed_setup(
      null == field0
          ? _value.field0
          : field0 // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$Value_completed_setup implements Value_completed_setup {
  const _$Value_completed_setup(this.field0);

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
            other is _$Value_completed_setup &&
            (identical(other.field0, field0) || other.field0 == field0));
  }

  @override
  int get hashCode => Object.hash(runtimeType, field0);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$Value_completed_setupCopyWith<_$Value_completed_setup> get copyWith =>
      __$$Value_completed_setupCopyWithImpl<_$Value_completed_setup>(
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
    required TResult Function(Value_fail value) fail,
    required TResult Function(Value_completed_setup value) completedSetup,
  }) {
    return completedSetup(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Value_fail value)? fail,
    TResult? Function(Value_completed_setup value)? completedSetup,
  }) {
    return completedSetup?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Value_fail value)? fail,
    TResult Function(Value_completed_setup value)? completedSetup,
    required TResult orElse(),
  }) {
    if (completedSetup != null) {
      return completedSetup(this);
    }
    return orElse();
  }
}

abstract class Value_completed_setup implements Value {
  const factory Value_completed_setup(final bool field0) =
      _$Value_completed_setup;

  @override
  bool get field0;
  @JsonKey(ignore: true)
  _$$Value_completed_setupCopyWith<_$Value_completed_setup> get copyWith =>
      throw _privateConstructorUsedError;
}
