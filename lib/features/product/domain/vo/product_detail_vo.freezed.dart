// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_detail_vo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ProductDetailVO {

 String get id; String get code; String get name;/// The list price, before any discount.
 int get priceMmk; bool get isNew; String get description; String get imageUrl; int? get discountPercent; String? get imageAsset;
/// Create a copy of ProductDetailVO
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProductDetailVOCopyWith<ProductDetailVO> get copyWith => _$ProductDetailVOCopyWithImpl<ProductDetailVO>(this as ProductDetailVO, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ProductDetailVO;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductDetailVO&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.code, _this.code) || other.code == _this.code)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.priceMmk, _this.priceMmk) || other.priceMmk == _this.priceMmk)&&(identical(other.isNew, _this.isNew) || other.isNew == _this.isNew)&&(identical(other.description, _this.description) || other.description == _this.description)&&(identical(other.imageUrl, _this.imageUrl) || other.imageUrl == _this.imageUrl)&&(identical(other.discountPercent, _this.discountPercent) || other.discountPercent == _this.discountPercent)&&(identical(other.imageAsset, _this.imageAsset) || other.imageAsset == _this.imageAsset));
}


@override
int get hashCode {
  final _this = this as ProductDetailVO;
  return Object.hash(runtimeType,_this.id,_this.code,_this.name,_this.priceMmk,_this.isNew,_this.description,_this.imageUrl,_this.discountPercent,_this.imageAsset);
}

@override
String toString() {
  final _this = this as ProductDetailVO;
  return 'ProductDetailVO(id: ${_this.id}, code: ${_this.code}, name: ${_this.name}, priceMmk: ${_this.priceMmk}, isNew: ${_this.isNew}, description: ${_this.description}, imageUrl: ${_this.imageUrl}, discountPercent: ${_this.discountPercent}, imageAsset: ${_this.imageAsset})';
}


}

/// @nodoc
abstract mixin class $ProductDetailVOCopyWith<$Res>  {
  factory $ProductDetailVOCopyWith(ProductDetailVO value, $Res Function(ProductDetailVO) _then) = _$ProductDetailVOCopyWithImpl;
@useResult
$Res call({
 String id, String code, String name, int priceMmk, bool isNew, String description, String imageUrl, int? discountPercent, String? imageAsset
});




}
/// @nodoc
class _$ProductDetailVOCopyWithImpl<$Res>
    implements $ProductDetailVOCopyWith<$Res> {
  _$ProductDetailVOCopyWithImpl(this._self, this._then);

  final ProductDetailVO _self;
  final $Res Function(ProductDetailVO) _then;

/// Create a copy of ProductDetailVO
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? code = null,Object? name = null,Object? priceMmk = null,Object? isNew = null,Object? description = null,Object? imageUrl = null,Object? discountPercent = freezed,Object? imageAsset = freezed,}) {
  return _then(ProductDetailVO(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,priceMmk: null == priceMmk ? _self.priceMmk : priceMmk // ignore: cast_nullable_to_non_nullable
as int,isNew: null == isNew ? _self.isNew : isNew // ignore: cast_nullable_to_non_nullable
as bool,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,discountPercent: freezed == discountPercent ? _self.discountPercent : discountPercent // ignore: cast_nullable_to_non_nullable
as int?,imageAsset: freezed == imageAsset ? _self.imageAsset : imageAsset // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ProductDetailVO].
extension ProductDetailVOPatterns on ProductDetailVO {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProductDetailVO value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProductDetailVO() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProductDetailVO value)  $default,){
final _that = this;
switch (_that) {
case _ProductDetailVO():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProductDetailVO value)?  $default,){
final _that = this;
switch (_that) {
case _ProductDetailVO() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String code,  String name,  int priceMmk,  bool isNew,  String description,  String imageUrl,  int? discountPercent,  String? imageAsset)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProductDetailVO() when $default != null:
return $default(_that.id,_that.code,_that.name,_that.priceMmk,_that.isNew,_that.description,_that.imageUrl,_that.discountPercent,_that.imageAsset);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String code,  String name,  int priceMmk,  bool isNew,  String description,  String imageUrl,  int? discountPercent,  String? imageAsset)  $default,) {final _that = this;
switch (_that) {
case _ProductDetailVO():
return $default(_that.id,_that.code,_that.name,_that.priceMmk,_that.isNew,_that.description,_that.imageUrl,_that.discountPercent,_that.imageAsset);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String code,  String name,  int priceMmk,  bool isNew,  String description,  String imageUrl,  int? discountPercent,  String? imageAsset)?  $default,) {final _that = this;
switch (_that) {
case _ProductDetailVO() when $default != null:
return $default(_that.id,_that.code,_that.name,_that.priceMmk,_that.isNew,_that.description,_that.imageUrl,_that.discountPercent,_that.imageAsset);case _:
  return null;

}
}

}

/// @nodoc


class _ProductDetailVO extends ProductDetailVO {
  const _ProductDetailVO({required this.id, required this.code, required this.name, required this.priceMmk, required this.isNew, required this.description, required this.imageUrl, this.discountPercent, this.imageAsset}): super._();
  

@override final  String id;
@override final  String code;
@override final  String name;
/// The list price, before any discount.
@override final  int priceMmk;
@override final  bool isNew;
@override final  String description;
@override final  String imageUrl;
@override final  int? discountPercent;
@override final  String? imageAsset;

/// Create a copy of ProductDetailVO
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProductDetailVOCopyWith<_ProductDetailVO> get copyWith => __$ProductDetailVOCopyWithImpl<_ProductDetailVO>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProductDetailVO&&(identical(other.id, id) || other.id == id)&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.priceMmk, priceMmk) || other.priceMmk == priceMmk)&&(identical(other.isNew, isNew) || other.isNew == isNew)&&(identical(other.description, description) || other.description == description)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.discountPercent, discountPercent) || other.discountPercent == discountPercent)&&(identical(other.imageAsset, imageAsset) || other.imageAsset == imageAsset));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,code,name,priceMmk,isNew,description,imageUrl,discountPercent,imageAsset);
}

@override
String toString() {
    return 'ProductDetailVO(id: $id, code: $code, name: $name, priceMmk: $priceMmk, isNew: $isNew, description: $description, imageUrl: $imageUrl, discountPercent: $discountPercent, imageAsset: $imageAsset)';
}


}

/// @nodoc
abstract mixin class _$ProductDetailVOCopyWith<$Res> implements $ProductDetailVOCopyWith<$Res> {
  factory _$ProductDetailVOCopyWith(_ProductDetailVO value, $Res Function(_ProductDetailVO) _then) = __$ProductDetailVOCopyWithImpl;
@override @useResult
$Res call({
 String id, String code, String name, int priceMmk, bool isNew, String description, String imageUrl, int? discountPercent, String? imageAsset
});




}
/// @nodoc
class __$ProductDetailVOCopyWithImpl<$Res>
    implements _$ProductDetailVOCopyWith<$Res> {
  __$ProductDetailVOCopyWithImpl(this._self, this._then);

  final _ProductDetailVO _self;
  final $Res Function(_ProductDetailVO) _then;

/// Create a copy of ProductDetailVO
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? code = null,Object? name = null,Object? priceMmk = null,Object? isNew = null,Object? description = null,Object? imageUrl = null,Object? discountPercent = freezed,Object? imageAsset = freezed,}) {
  return _then(_ProductDetailVO(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,priceMmk: null == priceMmk ? _self.priceMmk : priceMmk // ignore: cast_nullable_to_non_nullable
as int,isNew: null == isNew ? _self.isNew : isNew // ignore: cast_nullable_to_non_nullable
as bool,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,discountPercent: freezed == discountPercent ? _self.discountPercent : discountPercent // ignore: cast_nullable_to_non_nullable
as int?,imageAsset: freezed == imageAsset ? _self.imageAsset : imageAsset // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
