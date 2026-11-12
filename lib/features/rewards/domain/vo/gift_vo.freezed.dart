// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'gift_vo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$GiftVO {

 String get id; String get title; int get costPoints; String? get imageAsset;
/// Create a copy of GiftVO
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GiftVOCopyWith<GiftVO> get copyWith => _$GiftVOCopyWithImpl<GiftVO>(this as GiftVO, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as GiftVO;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GiftVO&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.costPoints, _this.costPoints) || other.costPoints == _this.costPoints)&&(identical(other.imageAsset, _this.imageAsset) || other.imageAsset == _this.imageAsset));
}


@override
int get hashCode {
  final _this = this as GiftVO;
  return Object.hash(runtimeType,_this.id,_this.title,_this.costPoints,_this.imageAsset);
}

@override
String toString() {
  final _this = this as GiftVO;
  return 'GiftVO(id: ${_this.id}, title: ${_this.title}, costPoints: ${_this.costPoints}, imageAsset: ${_this.imageAsset})';
}


}

/// @nodoc
abstract mixin class $GiftVOCopyWith<$Res>  {
  factory $GiftVOCopyWith(GiftVO value, $Res Function(GiftVO) _then) = _$GiftVOCopyWithImpl;
@useResult
$Res call({
 String id, String title, int costPoints, String? imageAsset
});




}
/// @nodoc
class _$GiftVOCopyWithImpl<$Res>
    implements $GiftVOCopyWith<$Res> {
  _$GiftVOCopyWithImpl(this._self, this._then);

  final GiftVO _self;
  final $Res Function(GiftVO) _then;

/// Create a copy of GiftVO
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? costPoints = null,Object? imageAsset = freezed,}) {
  return _then(GiftVO(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,costPoints: null == costPoints ? _self.costPoints : costPoints // ignore: cast_nullable_to_non_nullable
as int,imageAsset: freezed == imageAsset ? _self.imageAsset : imageAsset // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [GiftVO].
extension GiftVOPatterns on GiftVO {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GiftVO value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GiftVO() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GiftVO value)  $default,){
final _that = this;
switch (_that) {
case _GiftVO():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GiftVO value)?  $default,){
final _that = this;
switch (_that) {
case _GiftVO() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  int costPoints,  String? imageAsset)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GiftVO() when $default != null:
return $default(_that.id,_that.title,_that.costPoints,_that.imageAsset);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  int costPoints,  String? imageAsset)  $default,) {final _that = this;
switch (_that) {
case _GiftVO():
return $default(_that.id,_that.title,_that.costPoints,_that.imageAsset);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  int costPoints,  String? imageAsset)?  $default,) {final _that = this;
switch (_that) {
case _GiftVO() when $default != null:
return $default(_that.id,_that.title,_that.costPoints,_that.imageAsset);case _:
  return null;

}
}

}

/// @nodoc


class _GiftVO implements GiftVO {
  const _GiftVO({required this.id, required this.title, required this.costPoints, this.imageAsset});
  

@override final  String id;
@override final  String title;
@override final  int costPoints;
@override final  String? imageAsset;

/// Create a copy of GiftVO
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GiftVOCopyWith<_GiftVO> get copyWith => __$GiftVOCopyWithImpl<_GiftVO>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _GiftVO&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.costPoints, costPoints) || other.costPoints == costPoints)&&(identical(other.imageAsset, imageAsset) || other.imageAsset == imageAsset));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,title,costPoints,imageAsset);
}

@override
String toString() {
    return 'GiftVO(id: $id, title: $title, costPoints: $costPoints, imageAsset: $imageAsset)';
}


}

/// @nodoc
abstract mixin class _$GiftVOCopyWith<$Res> implements $GiftVOCopyWith<$Res> {
  factory _$GiftVOCopyWith(_GiftVO value, $Res Function(_GiftVO) _then) = __$GiftVOCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, int costPoints, String? imageAsset
});




}
/// @nodoc
class __$GiftVOCopyWithImpl<$Res>
    implements _$GiftVOCopyWith<$Res> {
  __$GiftVOCopyWithImpl(this._self, this._then);

  final _GiftVO _self;
  final $Res Function(_GiftVO) _then;

/// Create a copy of GiftVO
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? costPoints = null,Object? imageAsset = freezed,}) {
  return _then(_GiftVO(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,costPoints: null == costPoints ? _self.costPoints : costPoints // ignore: cast_nullable_to_non_nullable
as int,imageAsset: freezed == imageAsset ? _self.imageAsset : imageAsset // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
