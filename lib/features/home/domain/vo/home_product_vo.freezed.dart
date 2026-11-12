// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_product_vo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$HomeProductVO {

 String get id; String get name; String get imageUrl; int? get discountPercent; String? get imageAsset;
/// Create a copy of HomeProductVO
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HomeProductVOCopyWith<HomeProductVO> get copyWith => _$HomeProductVOCopyWithImpl<HomeProductVO>(this as HomeProductVO, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as HomeProductVO;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeProductVO&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.imageUrl, _this.imageUrl) || other.imageUrl == _this.imageUrl)&&(identical(other.discountPercent, _this.discountPercent) || other.discountPercent == _this.discountPercent)&&(identical(other.imageAsset, _this.imageAsset) || other.imageAsset == _this.imageAsset));
}


@override
int get hashCode {
  final _this = this as HomeProductVO;
  return Object.hash(runtimeType,_this.id,_this.name,_this.imageUrl,_this.discountPercent,_this.imageAsset);
}

@override
String toString() {
  final _this = this as HomeProductVO;
  return 'HomeProductVO(id: ${_this.id}, name: ${_this.name}, imageUrl: ${_this.imageUrl}, discountPercent: ${_this.discountPercent}, imageAsset: ${_this.imageAsset})';
}


}

/// @nodoc
abstract mixin class $HomeProductVOCopyWith<$Res>  {
  factory $HomeProductVOCopyWith(HomeProductVO value, $Res Function(HomeProductVO) _then) = _$HomeProductVOCopyWithImpl;
@useResult
$Res call({
 String id, String name, String imageUrl, int? discountPercent, String? imageAsset
});




}
/// @nodoc
class _$HomeProductVOCopyWithImpl<$Res>
    implements $HomeProductVOCopyWith<$Res> {
  _$HomeProductVOCopyWithImpl(this._self, this._then);

  final HomeProductVO _self;
  final $Res Function(HomeProductVO) _then;

/// Create a copy of HomeProductVO
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? imageUrl = null,Object? discountPercent = freezed,Object? imageAsset = freezed,}) {
  return _then(HomeProductVO(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,discountPercent: freezed == discountPercent ? _self.discountPercent : discountPercent // ignore: cast_nullable_to_non_nullable
as int?,imageAsset: freezed == imageAsset ? _self.imageAsset : imageAsset // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [HomeProductVO].
extension HomeProductVOPatterns on HomeProductVO {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HomeProductVO value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HomeProductVO() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HomeProductVO value)  $default,){
final _that = this;
switch (_that) {
case _HomeProductVO():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HomeProductVO value)?  $default,){
final _that = this;
switch (_that) {
case _HomeProductVO() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String imageUrl,  int? discountPercent,  String? imageAsset)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HomeProductVO() when $default != null:
return $default(_that.id,_that.name,_that.imageUrl,_that.discountPercent,_that.imageAsset);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String imageUrl,  int? discountPercent,  String? imageAsset)  $default,) {final _that = this;
switch (_that) {
case _HomeProductVO():
return $default(_that.id,_that.name,_that.imageUrl,_that.discountPercent,_that.imageAsset);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String imageUrl,  int? discountPercent,  String? imageAsset)?  $default,) {final _that = this;
switch (_that) {
case _HomeProductVO() when $default != null:
return $default(_that.id,_that.name,_that.imageUrl,_that.discountPercent,_that.imageAsset);case _:
  return null;

}
}

}

/// @nodoc


class _HomeProductVO implements HomeProductVO {
  const _HomeProductVO({required this.id, required this.name, required this.imageUrl, this.discountPercent, this.imageAsset});
  

@override final  String id;
@override final  String name;
@override final  String imageUrl;
@override final  int? discountPercent;
@override final  String? imageAsset;

/// Create a copy of HomeProductVO
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HomeProductVOCopyWith<_HomeProductVO> get copyWith => __$HomeProductVOCopyWithImpl<_HomeProductVO>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _HomeProductVO&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.discountPercent, discountPercent) || other.discountPercent == discountPercent)&&(identical(other.imageAsset, imageAsset) || other.imageAsset == imageAsset));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,name,imageUrl,discountPercent,imageAsset);
}

@override
String toString() {
    return 'HomeProductVO(id: $id, name: $name, imageUrl: $imageUrl, discountPercent: $discountPercent, imageAsset: $imageAsset)';
}


}

/// @nodoc
abstract mixin class _$HomeProductVOCopyWith<$Res> implements $HomeProductVOCopyWith<$Res> {
  factory _$HomeProductVOCopyWith(_HomeProductVO value, $Res Function(_HomeProductVO) _then) = __$HomeProductVOCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String imageUrl, int? discountPercent, String? imageAsset
});




}
/// @nodoc
class __$HomeProductVOCopyWithImpl<$Res>
    implements _$HomeProductVOCopyWith<$Res> {
  __$HomeProductVOCopyWithImpl(this._self, this._then);

  final _HomeProductVO _self;
  final $Res Function(_HomeProductVO) _then;

/// Create a copy of HomeProductVO
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? imageUrl = null,Object? discountPercent = freezed,Object? imageAsset = freezed,}) {
  return _then(_HomeProductVO(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,discountPercent: freezed == discountPercent ? _self.discountPercent : discountPercent // ignore: cast_nullable_to_non_nullable
as int?,imageAsset: freezed == imageAsset ? _self.imageAsset : imageAsset // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
