// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'challenge_vo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ChallengeVO {

 String get id; String get title; ChallengeKind get kind; int get progress; int get target; int get rewardPoints; String? get imageAsset;
/// Create a copy of ChallengeVO
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChallengeVOCopyWith<ChallengeVO> get copyWith => _$ChallengeVOCopyWithImpl<ChallengeVO>(this as ChallengeVO, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ChallengeVO;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChallengeVO&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.kind, _this.kind) || other.kind == _this.kind)&&(identical(other.progress, _this.progress) || other.progress == _this.progress)&&(identical(other.target, _this.target) || other.target == _this.target)&&(identical(other.rewardPoints, _this.rewardPoints) || other.rewardPoints == _this.rewardPoints)&&(identical(other.imageAsset, _this.imageAsset) || other.imageAsset == _this.imageAsset));
}


@override
int get hashCode {
  final _this = this as ChallengeVO;
  return Object.hash(runtimeType,_this.id,_this.title,_this.kind,_this.progress,_this.target,_this.rewardPoints,_this.imageAsset);
}

@override
String toString() {
  final _this = this as ChallengeVO;
  return 'ChallengeVO(id: ${_this.id}, title: ${_this.title}, kind: ${_this.kind}, progress: ${_this.progress}, target: ${_this.target}, rewardPoints: ${_this.rewardPoints}, imageAsset: ${_this.imageAsset})';
}


}

/// @nodoc
abstract mixin class $ChallengeVOCopyWith<$Res>  {
  factory $ChallengeVOCopyWith(ChallengeVO value, $Res Function(ChallengeVO) _then) = _$ChallengeVOCopyWithImpl;
@useResult
$Res call({
 String id, String title, ChallengeKind kind, int progress, int target, int rewardPoints, String? imageAsset
});




}
/// @nodoc
class _$ChallengeVOCopyWithImpl<$Res>
    implements $ChallengeVOCopyWith<$Res> {
  _$ChallengeVOCopyWithImpl(this._self, this._then);

  final ChallengeVO _self;
  final $Res Function(ChallengeVO) _then;

/// Create a copy of ChallengeVO
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? kind = null,Object? progress = null,Object? target = null,Object? rewardPoints = null,Object? imageAsset = freezed,}) {
  return _then(ChallengeVO(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as ChallengeKind,progress: null == progress ? _self.progress : progress // ignore: cast_nullable_to_non_nullable
as int,target: null == target ? _self.target : target // ignore: cast_nullable_to_non_nullable
as int,rewardPoints: null == rewardPoints ? _self.rewardPoints : rewardPoints // ignore: cast_nullable_to_non_nullable
as int,imageAsset: freezed == imageAsset ? _self.imageAsset : imageAsset // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ChallengeVO].
extension ChallengeVOPatterns on ChallengeVO {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChallengeVO value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChallengeVO() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChallengeVO value)  $default,){
final _that = this;
switch (_that) {
case _ChallengeVO():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChallengeVO value)?  $default,){
final _that = this;
switch (_that) {
case _ChallengeVO() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  ChallengeKind kind,  int progress,  int target,  int rewardPoints,  String? imageAsset)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChallengeVO() when $default != null:
return $default(_that.id,_that.title,_that.kind,_that.progress,_that.target,_that.rewardPoints,_that.imageAsset);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  ChallengeKind kind,  int progress,  int target,  int rewardPoints,  String? imageAsset)  $default,) {final _that = this;
switch (_that) {
case _ChallengeVO():
return $default(_that.id,_that.title,_that.kind,_that.progress,_that.target,_that.rewardPoints,_that.imageAsset);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  ChallengeKind kind,  int progress,  int target,  int rewardPoints,  String? imageAsset)?  $default,) {final _that = this;
switch (_that) {
case _ChallengeVO() when $default != null:
return $default(_that.id,_that.title,_that.kind,_that.progress,_that.target,_that.rewardPoints,_that.imageAsset);case _:
  return null;

}
}

}

/// @nodoc


class _ChallengeVO extends ChallengeVO {
  const _ChallengeVO({required this.id, required this.title, required this.kind, required this.progress, required this.target, required this.rewardPoints, this.imageAsset}): super._();
  

@override final  String id;
@override final  String title;
@override final  ChallengeKind kind;
@override final  int progress;
@override final  int target;
@override final  int rewardPoints;
@override final  String? imageAsset;

/// Create a copy of ChallengeVO
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChallengeVOCopyWith<_ChallengeVO> get copyWith => __$ChallengeVOCopyWithImpl<_ChallengeVO>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChallengeVO&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.progress, progress) || other.progress == progress)&&(identical(other.target, target) || other.target == target)&&(identical(other.rewardPoints, rewardPoints) || other.rewardPoints == rewardPoints)&&(identical(other.imageAsset, imageAsset) || other.imageAsset == imageAsset));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,title,kind,progress,target,rewardPoints,imageAsset);
}

@override
String toString() {
    return 'ChallengeVO(id: $id, title: $title, kind: $kind, progress: $progress, target: $target, rewardPoints: $rewardPoints, imageAsset: $imageAsset)';
}


}

/// @nodoc
abstract mixin class _$ChallengeVOCopyWith<$Res> implements $ChallengeVOCopyWith<$Res> {
  factory _$ChallengeVOCopyWith(_ChallengeVO value, $Res Function(_ChallengeVO) _then) = __$ChallengeVOCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, ChallengeKind kind, int progress, int target, int rewardPoints, String? imageAsset
});




}
/// @nodoc
class __$ChallengeVOCopyWithImpl<$Res>
    implements _$ChallengeVOCopyWith<$Res> {
  __$ChallengeVOCopyWithImpl(this._self, this._then);

  final _ChallengeVO _self;
  final $Res Function(_ChallengeVO) _then;

/// Create a copy of ChallengeVO
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? kind = null,Object? progress = null,Object? target = null,Object? rewardPoints = null,Object? imageAsset = freezed,}) {
  return _then(_ChallengeVO(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as ChallengeKind,progress: null == progress ? _self.progress : progress // ignore: cast_nullable_to_non_nullable
as int,target: null == target ? _self.target : target // ignore: cast_nullable_to_non_nullable
as int,rewardPoints: null == rewardPoints ? _self.rewardPoints : rewardPoints // ignore: cast_nullable_to_non_nullable
as int,imageAsset: freezed == imageAsset ? _self.imageAsset : imageAsset // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
