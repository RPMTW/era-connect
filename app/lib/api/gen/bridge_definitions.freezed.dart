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
  $Res call({bool completedSetup});
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
    Object? completedSetup = null,
  }) {
    return _then(_value.copyWith(
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
  $Res call({bool completedSetup});
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
    Object? completedSetup = null,
  }) {
    return _then(_$_UILayout(
      completedSetup: null == completedSetup
          ? _value.completedSetup
          : completedSetup // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_UILayout implements _UILayout {
  const _$_UILayout({required this.completedSetup});

  @override
  final bool completedSetup;

  @override
  String toString() {
    return 'UILayout(completedSetup: $completedSetup)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UILayout &&
            (identical(other.completedSetup, completedSetup) ||
                other.completedSetup == completedSetup));
  }

  @override
  int get hashCode => Object.hash(runtimeType, completedSetup);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_UILayoutCopyWith<_$_UILayout> get copyWith =>
      __$$_UILayoutCopyWithImpl<_$_UILayout>(this, _$identity);
}

abstract class _UILayout implements UILayout {
  const factory _UILayout({required final bool completedSetup}) = _$_UILayout;

  @override
  bool get completedSetup;
  @override
  @JsonKey(ignore: true)
  _$$_UILayoutCopyWith<_$_UILayout> get copyWith =>
      throw _privateConstructorUsedError;
}
