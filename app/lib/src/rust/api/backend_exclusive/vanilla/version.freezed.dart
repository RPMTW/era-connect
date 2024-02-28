// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'version.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

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
  bool operator ==(Object other) {
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
