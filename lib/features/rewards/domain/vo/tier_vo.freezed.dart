// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tier_vo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TierVO {

 String get id; String get name; int get minPoints;/// Position on the ladder, 0 for the lowest tier.
 int get sortOrder;/// The tier's badge, cached from the network with [imageAsset] as
/// the bundled fallback.
 String? get imageUrl; String? get imageAsset;
/// Create a copy of TierVO
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TierVOCopyWith<TierVO> get copyWith => _$TierVOCopyWithImpl<TierVO>(this as TierVO, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as TierVO;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TierVO&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.minPoints, _this.minPoints) || other.minPoints == _this.minPoints)&&(identical(other.sortOrder, _this.sortOrder) || other.sortOrder == _this.sortOrder)&&(identical(other.imageUrl, _this.imageUrl) || other.imageUrl == _this.imageUrl)&&(identical(other.imageAsset, _this.imageAsset) || other.imageAsset == _this.imageAsset));
}


@override
int get hashCode {
  final _this = this as TierVO;
  return Object.hash(runtimeType,_this.id,_this.name,_this.minPoints,_this.sortOrder,_this.imageUrl,_this.imageAsset);
}

@override
String toString() {
  final _this = this as TierVO;
  return 'TierVO(id: ${_this.id}, name: ${_this.name}, minPoints: ${_this.minPoints}, sortOrder: ${_this.sortOrder}, imageUrl: ${_this.imageUrl}, imageAsset: ${_this.imageAsset})';
}


}

/// @nodoc
abstract mixin class $TierVOCopyWith<$Res>  {
  factory $TierVOCopyWith(TierVO value, $Res Function(TierVO) _then) = _$TierVOCopyWithImpl;
@useResult
$Res call({
 String id, String name, int minPoints, int sortOrder, String? imageUrl, String? imageAsset
});




}
/// @nodoc
class _$TierVOCopyWithImpl<$Res>
    implements $TierVOCopyWith<$Res> {
  _$TierVOCopyWithImpl(this._self, this._then);

  final TierVO _self;
  final $Res Function(TierVO) _then;

/// Create a copy of TierVO
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? minPoints = null,Object? sortOrder = null,Object? imageUrl = freezed,Object? imageAsset = freezed,}) {
  return _then(TierVO(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,minPoints: null == minPoints ? _self.minPoints : minPoints // ignore: cast_nullable_to_non_nullable
as int,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,imageAsset: freezed == imageAsset ? _self.imageAsset : imageAsset // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [TierVO].
extension TierVOPatterns on TierVO {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TierVO value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TierVO() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TierVO value)  $default,){
final _that = this;
switch (_that) {
case _TierVO():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TierVO value)?  $default,){
final _that = this;
switch (_that) {
case _TierVO() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  int minPoints,  int sortOrder,  String? imageUrl,  String? imageAsset)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TierVO() when $default != null:
return $default(_that.id,_that.name,_that.minPoints,_that.sortOrder,_that.imageUrl,_that.imageAsset);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  int minPoints,  int sortOrder,  String? imageUrl,  String? imageAsset)  $default,) {final _that = this;
switch (_that) {
case _TierVO():
return $default(_that.id,_that.name,_that.minPoints,_that.sortOrder,_that.imageUrl,_that.imageAsset);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  int minPoints,  int sortOrder,  String? imageUrl,  String? imageAsset)?  $default,) {final _that = this;
switch (_that) {
case _TierVO() when $default != null:
return $default(_that.id,_that.name,_that.minPoints,_that.sortOrder,_that.imageUrl,_that.imageAsset);case _:
  return null;

}
}

}

/// @nodoc


class _TierVO implements TierVO {
  const _TierVO({required this.id, required this.name, required this.minPoints, required this.sortOrder, this.imageUrl, this.imageAsset});
  

@override final  String id;
@override final  String name;
@override final  int minPoints;
/// Position on the ladder, 0 for the lowest tier.
@override final  int sortOrder;
/// The tier's badge, cached from the network with [imageAsset] as
/// the bundled fallback.
@override final  String? imageUrl;
@override final  String? imageAsset;

/// Create a copy of TierVO
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TierVOCopyWith<_TierVO> get copyWith => __$TierVOCopyWithImpl<_TierVO>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TierVO&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.minPoints, minPoints) || other.minPoints == minPoints)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.imageAsset, imageAsset) || other.imageAsset == imageAsset));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,name,minPoints,sortOrder,imageUrl,imageAsset);
}

@override
String toString() {
    return 'TierVO(id: $id, name: $name, minPoints: $minPoints, sortOrder: $sortOrder, imageUrl: $imageUrl, imageAsset: $imageAsset)';
}


}

/// @nodoc
abstract mixin class _$TierVOCopyWith<$Res> implements $TierVOCopyWith<$Res> {
  factory _$TierVOCopyWith(_TierVO value, $Res Function(_TierVO) _then) = __$TierVOCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, int minPoints, int sortOrder, String? imageUrl, String? imageAsset
});




}
/// @nodoc
class __$TierVOCopyWithImpl<$Res>
    implements _$TierVOCopyWith<$Res> {
  __$TierVOCopyWithImpl(this._self, this._then);

  final _TierVO _self;
  final $Res Function(_TierVO) _then;

/// Create a copy of TierVO
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? minPoints = null,Object? sortOrder = null,Object? imageUrl = freezed,Object? imageAsset = freezed,}) {
  return _then(_TierVO(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,minPoints: null == minPoints ? _self.minPoints : minPoints // ignore: cast_nullable_to_non_nullable
as int,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,imageAsset: freezed == imageAsset ? _self.imageAsset : imageAsset // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
