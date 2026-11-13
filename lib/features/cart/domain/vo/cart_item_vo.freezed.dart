// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cart_item_vo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CartItemVO {

 String get productId; String get name;/// The price of one item after any discount.
 int get unitPriceMmk; int get quantity; String get imageUrl; String? get imageAsset;
/// Create a copy of CartItemVO
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CartItemVOCopyWith<CartItemVO> get copyWith => _$CartItemVOCopyWithImpl<CartItemVO>(this as CartItemVO, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as CartItemVO;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CartItemVO&&(identical(other.productId, _this.productId) || other.productId == _this.productId)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.unitPriceMmk, _this.unitPriceMmk) || other.unitPriceMmk == _this.unitPriceMmk)&&(identical(other.quantity, _this.quantity) || other.quantity == _this.quantity)&&(identical(other.imageUrl, _this.imageUrl) || other.imageUrl == _this.imageUrl)&&(identical(other.imageAsset, _this.imageAsset) || other.imageAsset == _this.imageAsset));
}


@override
int get hashCode {
  final _this = this as CartItemVO;
  return Object.hash(runtimeType,_this.productId,_this.name,_this.unitPriceMmk,_this.quantity,_this.imageUrl,_this.imageAsset);
}

@override
String toString() {
  final _this = this as CartItemVO;
  return 'CartItemVO(productId: ${_this.productId}, name: ${_this.name}, unitPriceMmk: ${_this.unitPriceMmk}, quantity: ${_this.quantity}, imageUrl: ${_this.imageUrl}, imageAsset: ${_this.imageAsset})';
}


}

/// @nodoc
abstract mixin class $CartItemVOCopyWith<$Res>  {
  factory $CartItemVOCopyWith(CartItemVO value, $Res Function(CartItemVO) _then) = _$CartItemVOCopyWithImpl;
@useResult
$Res call({
 String productId, String name, int unitPriceMmk, int quantity, String imageUrl, String? imageAsset
});




}
/// @nodoc
class _$CartItemVOCopyWithImpl<$Res>
    implements $CartItemVOCopyWith<$Res> {
  _$CartItemVOCopyWithImpl(this._self, this._then);

  final CartItemVO _self;
  final $Res Function(CartItemVO) _then;

/// Create a copy of CartItemVO
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? productId = null,Object? name = null,Object? unitPriceMmk = null,Object? quantity = null,Object? imageUrl = null,Object? imageAsset = freezed,}) {
  return _then(CartItemVO(
productId: null == productId ? _self.productId : productId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,unitPriceMmk: null == unitPriceMmk ? _self.unitPriceMmk : unitPriceMmk // ignore: cast_nullable_to_non_nullable
as int,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,imageAsset: freezed == imageAsset ? _self.imageAsset : imageAsset // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CartItemVO].
extension CartItemVOPatterns on CartItemVO {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CartItemVO value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CartItemVO() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CartItemVO value)  $default,){
final _that = this;
switch (_that) {
case _CartItemVO():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CartItemVO value)?  $default,){
final _that = this;
switch (_that) {
case _CartItemVO() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String productId,  String name,  int unitPriceMmk,  int quantity,  String imageUrl,  String? imageAsset)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CartItemVO() when $default != null:
return $default(_that.productId,_that.name,_that.unitPriceMmk,_that.quantity,_that.imageUrl,_that.imageAsset);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String productId,  String name,  int unitPriceMmk,  int quantity,  String imageUrl,  String? imageAsset)  $default,) {final _that = this;
switch (_that) {
case _CartItemVO():
return $default(_that.productId,_that.name,_that.unitPriceMmk,_that.quantity,_that.imageUrl,_that.imageAsset);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String productId,  String name,  int unitPriceMmk,  int quantity,  String imageUrl,  String? imageAsset)?  $default,) {final _that = this;
switch (_that) {
case _CartItemVO() when $default != null:
return $default(_that.productId,_that.name,_that.unitPriceMmk,_that.quantity,_that.imageUrl,_that.imageAsset);case _:
  return null;

}
}

}

/// @nodoc


class _CartItemVO extends CartItemVO {
  const _CartItemVO({required this.productId, required this.name, required this.unitPriceMmk, required this.quantity, required this.imageUrl, this.imageAsset}): super._();
  

@override final  String productId;
@override final  String name;
/// The price of one item after any discount.
@override final  int unitPriceMmk;
@override final  int quantity;
@override final  String imageUrl;
@override final  String? imageAsset;

/// Create a copy of CartItemVO
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CartItemVOCopyWith<_CartItemVO> get copyWith => __$CartItemVOCopyWithImpl<_CartItemVO>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CartItemVO&&(identical(other.productId, productId) || other.productId == productId)&&(identical(other.name, name) || other.name == name)&&(identical(other.unitPriceMmk, unitPriceMmk) || other.unitPriceMmk == unitPriceMmk)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.imageAsset, imageAsset) || other.imageAsset == imageAsset));
}


@override
int get hashCode {
    return Object.hash(runtimeType,productId,name,unitPriceMmk,quantity,imageUrl,imageAsset);
}

@override
String toString() {
    return 'CartItemVO(productId: $productId, name: $name, unitPriceMmk: $unitPriceMmk, quantity: $quantity, imageUrl: $imageUrl, imageAsset: $imageAsset)';
}


}

/// @nodoc
abstract mixin class _$CartItemVOCopyWith<$Res> implements $CartItemVOCopyWith<$Res> {
  factory _$CartItemVOCopyWith(_CartItemVO value, $Res Function(_CartItemVO) _then) = __$CartItemVOCopyWithImpl;
@override @useResult
$Res call({
 String productId, String name, int unitPriceMmk, int quantity, String imageUrl, String? imageAsset
});




}
/// @nodoc
class __$CartItemVOCopyWithImpl<$Res>
    implements _$CartItemVOCopyWith<$Res> {
  __$CartItemVOCopyWithImpl(this._self, this._then);

  final _CartItemVO _self;
  final $Res Function(_CartItemVO) _then;

/// Create a copy of CartItemVO
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? productId = null,Object? name = null,Object? unitPriceMmk = null,Object? quantity = null,Object? imageUrl = null,Object? imageAsset = freezed,}) {
  return _then(_CartItemVO(
productId: null == productId ? _self.productId : productId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,unitPriceMmk: null == unitPriceMmk ? _self.unitPriceMmk : unitPriceMmk // ignore: cast_nullable_to_non_nullable
as int,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,imageAsset: freezed == imageAsset ? _self.imageAsset : imageAsset // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
