// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'shop_vo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ShopVO {

 String get id; String get name; String get address; String get imageUrl; String? get imageAsset;
/// Create a copy of ShopVO
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ShopVOCopyWith<ShopVO> get copyWith => _$ShopVOCopyWithImpl<ShopVO>(this as ShopVO, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ShopVO;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShopVO&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.address, _this.address) || other.address == _this.address)&&(identical(other.imageUrl, _this.imageUrl) || other.imageUrl == _this.imageUrl)&&(identical(other.imageAsset, _this.imageAsset) || other.imageAsset == _this.imageAsset));
}


@override
int get hashCode {
  final _this = this as ShopVO;
  return Object.hash(runtimeType,_this.id,_this.name,_this.address,_this.imageUrl,_this.imageAsset);
}

@override
String toString() {
  final _this = this as ShopVO;
  return 'ShopVO(id: ${_this.id}, name: ${_this.name}, address: ${_this.address}, imageUrl: ${_this.imageUrl}, imageAsset: ${_this.imageAsset})';
}


}

/// @nodoc
abstract mixin class $ShopVOCopyWith<$Res>  {
  factory $ShopVOCopyWith(ShopVO value, $Res Function(ShopVO) _then) = _$ShopVOCopyWithImpl;
@useResult
$Res call({
 String id, String name, String address, String imageUrl, String? imageAsset
});




}
/// @nodoc
class _$ShopVOCopyWithImpl<$Res>
    implements $ShopVOCopyWith<$Res> {
  _$ShopVOCopyWithImpl(this._self, this._then);

  final ShopVO _self;
  final $Res Function(ShopVO) _then;

/// Create a copy of ShopVO
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? address = null,Object? imageUrl = null,Object? imageAsset = freezed,}) {
  return _then(ShopVO(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,imageAsset: freezed == imageAsset ? _self.imageAsset : imageAsset // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ShopVO].
extension ShopVOPatterns on ShopVO {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ShopVO value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ShopVO() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ShopVO value)  $default,){
final _that = this;
switch (_that) {
case _ShopVO():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ShopVO value)?  $default,){
final _that = this;
switch (_that) {
case _ShopVO() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String address,  String imageUrl,  String? imageAsset)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ShopVO() when $default != null:
return $default(_that.id,_that.name,_that.address,_that.imageUrl,_that.imageAsset);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String address,  String imageUrl,  String? imageAsset)  $default,) {final _that = this;
switch (_that) {
case _ShopVO():
return $default(_that.id,_that.name,_that.address,_that.imageUrl,_that.imageAsset);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String address,  String imageUrl,  String? imageAsset)?  $default,) {final _that = this;
switch (_that) {
case _ShopVO() when $default != null:
return $default(_that.id,_that.name,_that.address,_that.imageUrl,_that.imageAsset);case _:
  return null;

}
}

}

/// @nodoc


class _ShopVO implements ShopVO {
  const _ShopVO({required this.id, required this.name, required this.address, required this.imageUrl, this.imageAsset});
  

@override final  String id;
@override final  String name;
@override final  String address;
@override final  String imageUrl;
@override final  String? imageAsset;

/// Create a copy of ShopVO
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ShopVOCopyWith<_ShopVO> get copyWith => __$ShopVOCopyWithImpl<_ShopVO>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ShopVO&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.address, address) || other.address == address)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.imageAsset, imageAsset) || other.imageAsset == imageAsset));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,name,address,imageUrl,imageAsset);
}

@override
String toString() {
    return 'ShopVO(id: $id, name: $name, address: $address, imageUrl: $imageUrl, imageAsset: $imageAsset)';
}


}

/// @nodoc
abstract mixin class _$ShopVOCopyWith<$Res> implements $ShopVOCopyWith<$Res> {
  factory _$ShopVOCopyWith(_ShopVO value, $Res Function(_ShopVO) _then) = __$ShopVOCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String address, String imageUrl, String? imageAsset
});




}
/// @nodoc
class __$ShopVOCopyWithImpl<$Res>
    implements _$ShopVOCopyWith<$Res> {
  __$ShopVOCopyWithImpl(this._self, this._then);

  final _ShopVO _self;
  final $Res Function(_ShopVO) _then;

/// Create a copy of ShopVO
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? address = null,Object? imageUrl = null,Object? imageAsset = freezed,}) {
  return _then(_ShopVO(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,imageAsset: freezed == imageAsset ? _self.imageAsset : imageAsset // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
