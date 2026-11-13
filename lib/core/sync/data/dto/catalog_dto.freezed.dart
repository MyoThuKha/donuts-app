// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'catalog_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CatalogDto {

 List<ProductDto> get products; List<HomeSectionDto> get sections; List<BannerDto> get banners; List<ShopDto> get shops;/// The Rewards gifts. An older catalog without them reads as none.
 List<GiftDto> get gifts;
/// Create a copy of CatalogDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CatalogDtoCopyWith<CatalogDto> get copyWith => _$CatalogDtoCopyWithImpl<CatalogDto>(this as CatalogDto, _$identity);

  /// Serializes this CatalogDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as CatalogDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CatalogDto&&const DeepCollectionEquality().equals(other.products, _this.products)&&const DeepCollectionEquality().equals(other.sections, _this.sections)&&const DeepCollectionEquality().equals(other.banners, _this.banners)&&const DeepCollectionEquality().equals(other.shops, _this.shops)&&const DeepCollectionEquality().equals(other.gifts, _this.gifts));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as CatalogDto;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.products),const DeepCollectionEquality().hash(_this.sections),const DeepCollectionEquality().hash(_this.banners),const DeepCollectionEquality().hash(_this.shops),const DeepCollectionEquality().hash(_this.gifts));
}

@override
String toString() {
  final _this = this as CatalogDto;
  return 'CatalogDto(products: ${_this.products}, sections: ${_this.sections}, banners: ${_this.banners}, shops: ${_this.shops}, gifts: ${_this.gifts})';
}


}

/// @nodoc
abstract mixin class $CatalogDtoCopyWith<$Res>  {
  factory $CatalogDtoCopyWith(CatalogDto value, $Res Function(CatalogDto) _then) = _$CatalogDtoCopyWithImpl;
@useResult
$Res call({
 List<ProductDto> products, List<HomeSectionDto> sections, List<BannerDto> banners, List<ShopDto> shops, List<GiftDto> gifts
});




}
/// @nodoc
class _$CatalogDtoCopyWithImpl<$Res>
    implements $CatalogDtoCopyWith<$Res> {
  _$CatalogDtoCopyWithImpl(this._self, this._then);

  final CatalogDto _self;
  final $Res Function(CatalogDto) _then;

/// Create a copy of CatalogDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? products = null,Object? sections = null,Object? banners = null,Object? shops = null,Object? gifts = null,}) {
  return _then(CatalogDto(
products: null == products ? _self.products : products // ignore: cast_nullable_to_non_nullable
as List<ProductDto>,sections: null == sections ? _self.sections : sections // ignore: cast_nullable_to_non_nullable
as List<HomeSectionDto>,banners: null == banners ? _self.banners : banners // ignore: cast_nullable_to_non_nullable
as List<BannerDto>,shops: null == shops ? _self.shops : shops // ignore: cast_nullable_to_non_nullable
as List<ShopDto>,gifts: null == gifts ? _self.gifts : gifts // ignore: cast_nullable_to_non_nullable
as List<GiftDto>,
  ));
}

}


/// Adds pattern-matching-related methods to [CatalogDto].
extension CatalogDtoPatterns on CatalogDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CatalogDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CatalogDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CatalogDto value)  $default,){
final _that = this;
switch (_that) {
case _CatalogDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CatalogDto value)?  $default,){
final _that = this;
switch (_that) {
case _CatalogDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<ProductDto> products,  List<HomeSectionDto> sections,  List<BannerDto> banners,  List<ShopDto> shops,  List<GiftDto> gifts)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CatalogDto() when $default != null:
return $default(_that.products,_that.sections,_that.banners,_that.shops,_that.gifts);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<ProductDto> products,  List<HomeSectionDto> sections,  List<BannerDto> banners,  List<ShopDto> shops,  List<GiftDto> gifts)  $default,) {final _that = this;
switch (_that) {
case _CatalogDto():
return $default(_that.products,_that.sections,_that.banners,_that.shops,_that.gifts);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<ProductDto> products,  List<HomeSectionDto> sections,  List<BannerDto> banners,  List<ShopDto> shops,  List<GiftDto> gifts)?  $default,) {final _that = this;
switch (_that) {
case _CatalogDto() when $default != null:
return $default(_that.products,_that.sections,_that.banners,_that.shops,_that.gifts);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CatalogDto implements CatalogDto {
  const _CatalogDto({required  List<ProductDto> products, required  List<HomeSectionDto> sections, required  List<BannerDto> banners, required  List<ShopDto> shops,  List<GiftDto> gifts = const <GiftDto>[]}): _products = products,_sections = sections,_banners = banners,_shops = shops,_gifts = gifts;
  factory _CatalogDto.fromJson(Map<String, dynamic> json) => _$CatalogDtoFromJson(json);

 final  List<ProductDto> _products;
@override List<ProductDto> get products {
  if (_products is EqualUnmodifiableListView) return _products;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_products);
}

 final  List<HomeSectionDto> _sections;
@override List<HomeSectionDto> get sections {
  if (_sections is EqualUnmodifiableListView) return _sections;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_sections);
}

 final  List<BannerDto> _banners;
@override List<BannerDto> get banners {
  if (_banners is EqualUnmodifiableListView) return _banners;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_banners);
}

 final  List<ShopDto> _shops;
@override List<ShopDto> get shops {
  if (_shops is EqualUnmodifiableListView) return _shops;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_shops);
}

/// The Rewards gifts. An older catalog without them reads as none.
 final  List<GiftDto> _gifts;
/// The Rewards gifts. An older catalog without them reads as none.
@override@JsonKey() List<GiftDto> get gifts {
  if (_gifts is EqualUnmodifiableListView) return _gifts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_gifts);
}


/// Create a copy of CatalogDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CatalogDtoCopyWith<_CatalogDto> get copyWith => __$CatalogDtoCopyWithImpl<_CatalogDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CatalogDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CatalogDto&&const DeepCollectionEquality().equals(other.products, _products)&&const DeepCollectionEquality().equals(other.sections, _sections)&&const DeepCollectionEquality().equals(other.banners, _banners)&&const DeepCollectionEquality().equals(other.shops, _shops)&&const DeepCollectionEquality().equals(other.gifts, _gifts));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_products),const DeepCollectionEquality().hash(_sections),const DeepCollectionEquality().hash(_banners),const DeepCollectionEquality().hash(_shops),const DeepCollectionEquality().hash(_gifts));
}

@override
String toString() {
    return 'CatalogDto(products: $products, sections: $sections, banners: $banners, shops: $shops, gifts: $gifts)';
}


}

/// @nodoc
abstract mixin class _$CatalogDtoCopyWith<$Res> implements $CatalogDtoCopyWith<$Res> {
  factory _$CatalogDtoCopyWith(_CatalogDto value, $Res Function(_CatalogDto) _then) = __$CatalogDtoCopyWithImpl;
@override @useResult
$Res call({
 List<ProductDto> products, List<HomeSectionDto> sections, List<BannerDto> banners, List<ShopDto> shops, List<GiftDto> gifts
});




}
/// @nodoc
class __$CatalogDtoCopyWithImpl<$Res>
    implements _$CatalogDtoCopyWith<$Res> {
  __$CatalogDtoCopyWithImpl(this._self, this._then);

  final _CatalogDto _self;
  final $Res Function(_CatalogDto) _then;

/// Create a copy of CatalogDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? products = null,Object? sections = null,Object? banners = null,Object? shops = null,Object? gifts = null,}) {
  return _then(_CatalogDto(
products: null == products ? _self._products : products // ignore: cast_nullable_to_non_nullable
as List<ProductDto>,sections: null == sections ? _self._sections : sections // ignore: cast_nullable_to_non_nullable
as List<HomeSectionDto>,banners: null == banners ? _self._banners : banners // ignore: cast_nullable_to_non_nullable
as List<BannerDto>,shops: null == shops ? _self._shops : shops // ignore: cast_nullable_to_non_nullable
as List<ShopDto>,gifts: null == gifts ? _self._gifts : gifts // ignore: cast_nullable_to_non_nullable
as List<GiftDto>,
  ));
}


}


/// @nodoc
mixin _$ProductDto {

 String get id; String get code; String get name; int get priceMmk; bool get isNew; String get description; String get imageUrl; DateTime get updatedAt; int? get discountPercent; String? get imageAsset;
/// Create a copy of ProductDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProductDtoCopyWith<ProductDto> get copyWith => _$ProductDtoCopyWithImpl<ProductDto>(this as ProductDto, _$identity);

  /// Serializes this ProductDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ProductDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductDto&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.code, _this.code) || other.code == _this.code)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.priceMmk, _this.priceMmk) || other.priceMmk == _this.priceMmk)&&(identical(other.isNew, _this.isNew) || other.isNew == _this.isNew)&&(identical(other.description, _this.description) || other.description == _this.description)&&(identical(other.imageUrl, _this.imageUrl) || other.imageUrl == _this.imageUrl)&&(identical(other.updatedAt, _this.updatedAt) || other.updatedAt == _this.updatedAt)&&(identical(other.discountPercent, _this.discountPercent) || other.discountPercent == _this.discountPercent)&&(identical(other.imageAsset, _this.imageAsset) || other.imageAsset == _this.imageAsset));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ProductDto;
  return Object.hash(runtimeType,_this.id,_this.code,_this.name,_this.priceMmk,_this.isNew,_this.description,_this.imageUrl,_this.updatedAt,_this.discountPercent,_this.imageAsset);
}

@override
String toString() {
  final _this = this as ProductDto;
  return 'ProductDto(id: ${_this.id}, code: ${_this.code}, name: ${_this.name}, priceMmk: ${_this.priceMmk}, isNew: ${_this.isNew}, description: ${_this.description}, imageUrl: ${_this.imageUrl}, updatedAt: ${_this.updatedAt}, discountPercent: ${_this.discountPercent}, imageAsset: ${_this.imageAsset})';
}


}

/// @nodoc
abstract mixin class $ProductDtoCopyWith<$Res>  {
  factory $ProductDtoCopyWith(ProductDto value, $Res Function(ProductDto) _then) = _$ProductDtoCopyWithImpl;
@useResult
$Res call({
 String id, String code, String name, int priceMmk, bool isNew, String description, String imageUrl, DateTime updatedAt, int? discountPercent, String? imageAsset
});




}
/// @nodoc
class _$ProductDtoCopyWithImpl<$Res>
    implements $ProductDtoCopyWith<$Res> {
  _$ProductDtoCopyWithImpl(this._self, this._then);

  final ProductDto _self;
  final $Res Function(ProductDto) _then;

/// Create a copy of ProductDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? code = null,Object? name = null,Object? priceMmk = null,Object? isNew = null,Object? description = null,Object? imageUrl = null,Object? updatedAt = null,Object? discountPercent = freezed,Object? imageAsset = freezed,}) {
  return _then(ProductDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,priceMmk: null == priceMmk ? _self.priceMmk : priceMmk // ignore: cast_nullable_to_non_nullable
as int,isNew: null == isNew ? _self.isNew : isNew // ignore: cast_nullable_to_non_nullable
as bool,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,discountPercent: freezed == discountPercent ? _self.discountPercent : discountPercent // ignore: cast_nullable_to_non_nullable
as int?,imageAsset: freezed == imageAsset ? _self.imageAsset : imageAsset // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ProductDto].
extension ProductDtoPatterns on ProductDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProductDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProductDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProductDto value)  $default,){
final _that = this;
switch (_that) {
case _ProductDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProductDto value)?  $default,){
final _that = this;
switch (_that) {
case _ProductDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String code,  String name,  int priceMmk,  bool isNew,  String description,  String imageUrl,  DateTime updatedAt,  int? discountPercent,  String? imageAsset)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProductDto() when $default != null:
return $default(_that.id,_that.code,_that.name,_that.priceMmk,_that.isNew,_that.description,_that.imageUrl,_that.updatedAt,_that.discountPercent,_that.imageAsset);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String code,  String name,  int priceMmk,  bool isNew,  String description,  String imageUrl,  DateTime updatedAt,  int? discountPercent,  String? imageAsset)  $default,) {final _that = this;
switch (_that) {
case _ProductDto():
return $default(_that.id,_that.code,_that.name,_that.priceMmk,_that.isNew,_that.description,_that.imageUrl,_that.updatedAt,_that.discountPercent,_that.imageAsset);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String code,  String name,  int priceMmk,  bool isNew,  String description,  String imageUrl,  DateTime updatedAt,  int? discountPercent,  String? imageAsset)?  $default,) {final _that = this;
switch (_that) {
case _ProductDto() when $default != null:
return $default(_that.id,_that.code,_that.name,_that.priceMmk,_that.isNew,_that.description,_that.imageUrl,_that.updatedAt,_that.discountPercent,_that.imageAsset);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProductDto implements ProductDto {
  const _ProductDto({required this.id, required this.code, required this.name, required this.priceMmk, required this.isNew, required this.description, required this.imageUrl, required this.updatedAt, this.discountPercent, this.imageAsset});
  factory _ProductDto.fromJson(Map<String, dynamic> json) => _$ProductDtoFromJson(json);

@override final  String id;
@override final  String code;
@override final  String name;
@override final  int priceMmk;
@override final  bool isNew;
@override final  String description;
@override final  String imageUrl;
@override final  DateTime updatedAt;
@override final  int? discountPercent;
@override final  String? imageAsset;

/// Create a copy of ProductDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProductDtoCopyWith<_ProductDto> get copyWith => __$ProductDtoCopyWithImpl<_ProductDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProductDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProductDto&&(identical(other.id, id) || other.id == id)&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.priceMmk, priceMmk) || other.priceMmk == priceMmk)&&(identical(other.isNew, isNew) || other.isNew == isNew)&&(identical(other.description, description) || other.description == description)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.discountPercent, discountPercent) || other.discountPercent == discountPercent)&&(identical(other.imageAsset, imageAsset) || other.imageAsset == imageAsset));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,code,name,priceMmk,isNew,description,imageUrl,updatedAt,discountPercent,imageAsset);
}

@override
String toString() {
    return 'ProductDto(id: $id, code: $code, name: $name, priceMmk: $priceMmk, isNew: $isNew, description: $description, imageUrl: $imageUrl, updatedAt: $updatedAt, discountPercent: $discountPercent, imageAsset: $imageAsset)';
}


}

/// @nodoc
abstract mixin class _$ProductDtoCopyWith<$Res> implements $ProductDtoCopyWith<$Res> {
  factory _$ProductDtoCopyWith(_ProductDto value, $Res Function(_ProductDto) _then) = __$ProductDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String code, String name, int priceMmk, bool isNew, String description, String imageUrl, DateTime updatedAt, int? discountPercent, String? imageAsset
});




}
/// @nodoc
class __$ProductDtoCopyWithImpl<$Res>
    implements _$ProductDtoCopyWith<$Res> {
  __$ProductDtoCopyWithImpl(this._self, this._then);

  final _ProductDto _self;
  final $Res Function(_ProductDto) _then;

/// Create a copy of ProductDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? code = null,Object? name = null,Object? priceMmk = null,Object? isNew = null,Object? description = null,Object? imageUrl = null,Object? updatedAt = null,Object? discountPercent = freezed,Object? imageAsset = freezed,}) {
  return _then(_ProductDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,priceMmk: null == priceMmk ? _self.priceMmk : priceMmk // ignore: cast_nullable_to_non_nullable
as int,isNew: null == isNew ? _self.isNew : isNew // ignore: cast_nullable_to_non_nullable
as bool,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,discountPercent: freezed == discountPercent ? _self.discountPercent : discountPercent // ignore: cast_nullable_to_non_nullable
as int?,imageAsset: freezed == imageAsset ? _self.imageAsset : imageAsset // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$HomeSectionDto {

 String get id; String get titleKey; int get sortOrder; List<String> get productIds;
/// Create a copy of HomeSectionDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HomeSectionDtoCopyWith<HomeSectionDto> get copyWith => _$HomeSectionDtoCopyWithImpl<HomeSectionDto>(this as HomeSectionDto, _$identity);

  /// Serializes this HomeSectionDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as HomeSectionDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeSectionDto&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.titleKey, _this.titleKey) || other.titleKey == _this.titleKey)&&(identical(other.sortOrder, _this.sortOrder) || other.sortOrder == _this.sortOrder)&&const DeepCollectionEquality().equals(other.productIds, _this.productIds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as HomeSectionDto;
  return Object.hash(runtimeType,_this.id,_this.titleKey,_this.sortOrder,const DeepCollectionEquality().hash(_this.productIds));
}

@override
String toString() {
  final _this = this as HomeSectionDto;
  return 'HomeSectionDto(id: ${_this.id}, titleKey: ${_this.titleKey}, sortOrder: ${_this.sortOrder}, productIds: ${_this.productIds})';
}


}

/// @nodoc
abstract mixin class $HomeSectionDtoCopyWith<$Res>  {
  factory $HomeSectionDtoCopyWith(HomeSectionDto value, $Res Function(HomeSectionDto) _then) = _$HomeSectionDtoCopyWithImpl;
@useResult
$Res call({
 String id, String titleKey, int sortOrder, List<String> productIds
});




}
/// @nodoc
class _$HomeSectionDtoCopyWithImpl<$Res>
    implements $HomeSectionDtoCopyWith<$Res> {
  _$HomeSectionDtoCopyWithImpl(this._self, this._then);

  final HomeSectionDto _self;
  final $Res Function(HomeSectionDto) _then;

/// Create a copy of HomeSectionDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? titleKey = null,Object? sortOrder = null,Object? productIds = null,}) {
  return _then(HomeSectionDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,titleKey: null == titleKey ? _self.titleKey : titleKey // ignore: cast_nullable_to_non_nullable
as String,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,productIds: null == productIds ? _self.productIds : productIds // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [HomeSectionDto].
extension HomeSectionDtoPatterns on HomeSectionDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HomeSectionDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HomeSectionDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HomeSectionDto value)  $default,){
final _that = this;
switch (_that) {
case _HomeSectionDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HomeSectionDto value)?  $default,){
final _that = this;
switch (_that) {
case _HomeSectionDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String titleKey,  int sortOrder,  List<String> productIds)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HomeSectionDto() when $default != null:
return $default(_that.id,_that.titleKey,_that.sortOrder,_that.productIds);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String titleKey,  int sortOrder,  List<String> productIds)  $default,) {final _that = this;
switch (_that) {
case _HomeSectionDto():
return $default(_that.id,_that.titleKey,_that.sortOrder,_that.productIds);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String titleKey,  int sortOrder,  List<String> productIds)?  $default,) {final _that = this;
switch (_that) {
case _HomeSectionDto() when $default != null:
return $default(_that.id,_that.titleKey,_that.sortOrder,_that.productIds);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _HomeSectionDto implements HomeSectionDto {
  const _HomeSectionDto({required this.id, required this.titleKey, required this.sortOrder, required  List<String> productIds}): _productIds = productIds;
  factory _HomeSectionDto.fromJson(Map<String, dynamic> json) => _$HomeSectionDtoFromJson(json);

@override final  String id;
@override final  String titleKey;
@override final  int sortOrder;
 final  List<String> _productIds;
@override List<String> get productIds {
  if (_productIds is EqualUnmodifiableListView) return _productIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_productIds);
}


/// Create a copy of HomeSectionDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HomeSectionDtoCopyWith<_HomeSectionDto> get copyWith => __$HomeSectionDtoCopyWithImpl<_HomeSectionDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HomeSectionDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _HomeSectionDto&&(identical(other.id, id) || other.id == id)&&(identical(other.titleKey, titleKey) || other.titleKey == titleKey)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder)&&const DeepCollectionEquality().equals(other.productIds, _productIds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,titleKey,sortOrder,const DeepCollectionEquality().hash(_productIds));
}

@override
String toString() {
    return 'HomeSectionDto(id: $id, titleKey: $titleKey, sortOrder: $sortOrder, productIds: $productIds)';
}


}

/// @nodoc
abstract mixin class _$HomeSectionDtoCopyWith<$Res> implements $HomeSectionDtoCopyWith<$Res> {
  factory _$HomeSectionDtoCopyWith(_HomeSectionDto value, $Res Function(_HomeSectionDto) _then) = __$HomeSectionDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String titleKey, int sortOrder, List<String> productIds
});




}
/// @nodoc
class __$HomeSectionDtoCopyWithImpl<$Res>
    implements _$HomeSectionDtoCopyWith<$Res> {
  __$HomeSectionDtoCopyWithImpl(this._self, this._then);

  final _HomeSectionDto _self;
  final $Res Function(_HomeSectionDto) _then;

/// Create a copy of HomeSectionDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? titleKey = null,Object? sortOrder = null,Object? productIds = null,}) {
  return _then(_HomeSectionDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,titleKey: null == titleKey ? _self.titleKey : titleKey // ignore: cast_nullable_to_non_nullable
as String,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,productIds: null == productIds ? _self._productIds : productIds // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}


/// @nodoc
mixin _$BannerDto {

 String get id; String get tag; String get title; BannerStyleDto get style; String get imageUrl; int get sortOrder; String? get imageAsset;
/// Create a copy of BannerDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BannerDtoCopyWith<BannerDto> get copyWith => _$BannerDtoCopyWithImpl<BannerDto>(this as BannerDto, _$identity);

  /// Serializes this BannerDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as BannerDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BannerDto&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.tag, _this.tag) || other.tag == _this.tag)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.style, _this.style) || other.style == _this.style)&&(identical(other.imageUrl, _this.imageUrl) || other.imageUrl == _this.imageUrl)&&(identical(other.sortOrder, _this.sortOrder) || other.sortOrder == _this.sortOrder)&&(identical(other.imageAsset, _this.imageAsset) || other.imageAsset == _this.imageAsset));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as BannerDto;
  return Object.hash(runtimeType,_this.id,_this.tag,_this.title,_this.style,_this.imageUrl,_this.sortOrder,_this.imageAsset);
}

@override
String toString() {
  final _this = this as BannerDto;
  return 'BannerDto(id: ${_this.id}, tag: ${_this.tag}, title: ${_this.title}, style: ${_this.style}, imageUrl: ${_this.imageUrl}, sortOrder: ${_this.sortOrder}, imageAsset: ${_this.imageAsset})';
}


}

/// @nodoc
abstract mixin class $BannerDtoCopyWith<$Res>  {
  factory $BannerDtoCopyWith(BannerDto value, $Res Function(BannerDto) _then) = _$BannerDtoCopyWithImpl;
@useResult
$Res call({
 String id, String tag, String title, BannerStyleDto style, String imageUrl, int sortOrder, String? imageAsset
});




}
/// @nodoc
class _$BannerDtoCopyWithImpl<$Res>
    implements $BannerDtoCopyWith<$Res> {
  _$BannerDtoCopyWithImpl(this._self, this._then);

  final BannerDto _self;
  final $Res Function(BannerDto) _then;

/// Create a copy of BannerDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? tag = null,Object? title = null,Object? style = null,Object? imageUrl = null,Object? sortOrder = null,Object? imageAsset = freezed,}) {
  return _then(BannerDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,tag: null == tag ? _self.tag : tag // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,style: null == style ? _self.style : style // ignore: cast_nullable_to_non_nullable
as BannerStyleDto,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,imageAsset: freezed == imageAsset ? _self.imageAsset : imageAsset // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [BannerDto].
extension BannerDtoPatterns on BannerDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BannerDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BannerDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BannerDto value)  $default,){
final _that = this;
switch (_that) {
case _BannerDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BannerDto value)?  $default,){
final _that = this;
switch (_that) {
case _BannerDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String tag,  String title,  BannerStyleDto style,  String imageUrl,  int sortOrder,  String? imageAsset)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BannerDto() when $default != null:
return $default(_that.id,_that.tag,_that.title,_that.style,_that.imageUrl,_that.sortOrder,_that.imageAsset);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String tag,  String title,  BannerStyleDto style,  String imageUrl,  int sortOrder,  String? imageAsset)  $default,) {final _that = this;
switch (_that) {
case _BannerDto():
return $default(_that.id,_that.tag,_that.title,_that.style,_that.imageUrl,_that.sortOrder,_that.imageAsset);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String tag,  String title,  BannerStyleDto style,  String imageUrl,  int sortOrder,  String? imageAsset)?  $default,) {final _that = this;
switch (_that) {
case _BannerDto() when $default != null:
return $default(_that.id,_that.tag,_that.title,_that.style,_that.imageUrl,_that.sortOrder,_that.imageAsset);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BannerDto implements BannerDto {
  const _BannerDto({required this.id, required this.tag, required this.title, required this.style, required this.imageUrl, required this.sortOrder, this.imageAsset});
  factory _BannerDto.fromJson(Map<String, dynamic> json) => _$BannerDtoFromJson(json);

@override final  String id;
@override final  String tag;
@override final  String title;
@override final  BannerStyleDto style;
@override final  String imageUrl;
@override final  int sortOrder;
@override final  String? imageAsset;

/// Create a copy of BannerDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BannerDtoCopyWith<_BannerDto> get copyWith => __$BannerDtoCopyWithImpl<_BannerDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BannerDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _BannerDto&&(identical(other.id, id) || other.id == id)&&(identical(other.tag, tag) || other.tag == tag)&&(identical(other.title, title) || other.title == title)&&(identical(other.style, style) || other.style == style)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder)&&(identical(other.imageAsset, imageAsset) || other.imageAsset == imageAsset));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,tag,title,style,imageUrl,sortOrder,imageAsset);
}

@override
String toString() {
    return 'BannerDto(id: $id, tag: $tag, title: $title, style: $style, imageUrl: $imageUrl, sortOrder: $sortOrder, imageAsset: $imageAsset)';
}


}

/// @nodoc
abstract mixin class _$BannerDtoCopyWith<$Res> implements $BannerDtoCopyWith<$Res> {
  factory _$BannerDtoCopyWith(_BannerDto value, $Res Function(_BannerDto) _then) = __$BannerDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String tag, String title, BannerStyleDto style, String imageUrl, int sortOrder, String? imageAsset
});




}
/// @nodoc
class __$BannerDtoCopyWithImpl<$Res>
    implements _$BannerDtoCopyWith<$Res> {
  __$BannerDtoCopyWithImpl(this._self, this._then);

  final _BannerDto _self;
  final $Res Function(_BannerDto) _then;

/// Create a copy of BannerDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? tag = null,Object? title = null,Object? style = null,Object? imageUrl = null,Object? sortOrder = null,Object? imageAsset = freezed,}) {
  return _then(_BannerDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,tag: null == tag ? _self.tag : tag // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,style: null == style ? _self.style : style // ignore: cast_nullable_to_non_nullable
as BannerStyleDto,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,imageAsset: freezed == imageAsset ? _self.imageAsset : imageAsset // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$ShopDto {

 String get id; String get name; String get address; String get imageUrl; int get sortOrder; String? get imageAsset;
/// Create a copy of ShopDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ShopDtoCopyWith<ShopDto> get copyWith => _$ShopDtoCopyWithImpl<ShopDto>(this as ShopDto, _$identity);

  /// Serializes this ShopDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ShopDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShopDto&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.address, _this.address) || other.address == _this.address)&&(identical(other.imageUrl, _this.imageUrl) || other.imageUrl == _this.imageUrl)&&(identical(other.sortOrder, _this.sortOrder) || other.sortOrder == _this.sortOrder)&&(identical(other.imageAsset, _this.imageAsset) || other.imageAsset == _this.imageAsset));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ShopDto;
  return Object.hash(runtimeType,_this.id,_this.name,_this.address,_this.imageUrl,_this.sortOrder,_this.imageAsset);
}

@override
String toString() {
  final _this = this as ShopDto;
  return 'ShopDto(id: ${_this.id}, name: ${_this.name}, address: ${_this.address}, imageUrl: ${_this.imageUrl}, sortOrder: ${_this.sortOrder}, imageAsset: ${_this.imageAsset})';
}


}

/// @nodoc
abstract mixin class $ShopDtoCopyWith<$Res>  {
  factory $ShopDtoCopyWith(ShopDto value, $Res Function(ShopDto) _then) = _$ShopDtoCopyWithImpl;
@useResult
$Res call({
 String id, String name, String address, String imageUrl, int sortOrder, String? imageAsset
});




}
/// @nodoc
class _$ShopDtoCopyWithImpl<$Res>
    implements $ShopDtoCopyWith<$Res> {
  _$ShopDtoCopyWithImpl(this._self, this._then);

  final ShopDto _self;
  final $Res Function(ShopDto) _then;

/// Create a copy of ShopDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? address = null,Object? imageUrl = null,Object? sortOrder = null,Object? imageAsset = freezed,}) {
  return _then(ShopDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,imageAsset: freezed == imageAsset ? _self.imageAsset : imageAsset // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ShopDto].
extension ShopDtoPatterns on ShopDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ShopDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ShopDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ShopDto value)  $default,){
final _that = this;
switch (_that) {
case _ShopDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ShopDto value)?  $default,){
final _that = this;
switch (_that) {
case _ShopDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String address,  String imageUrl,  int sortOrder,  String? imageAsset)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ShopDto() when $default != null:
return $default(_that.id,_that.name,_that.address,_that.imageUrl,_that.sortOrder,_that.imageAsset);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String address,  String imageUrl,  int sortOrder,  String? imageAsset)  $default,) {final _that = this;
switch (_that) {
case _ShopDto():
return $default(_that.id,_that.name,_that.address,_that.imageUrl,_that.sortOrder,_that.imageAsset);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String address,  String imageUrl,  int sortOrder,  String? imageAsset)?  $default,) {final _that = this;
switch (_that) {
case _ShopDto() when $default != null:
return $default(_that.id,_that.name,_that.address,_that.imageUrl,_that.sortOrder,_that.imageAsset);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ShopDto implements ShopDto {
  const _ShopDto({required this.id, required this.name, required this.address, required this.imageUrl, required this.sortOrder, this.imageAsset});
  factory _ShopDto.fromJson(Map<String, dynamic> json) => _$ShopDtoFromJson(json);

@override final  String id;
@override final  String name;
@override final  String address;
@override final  String imageUrl;
@override final  int sortOrder;
@override final  String? imageAsset;

/// Create a copy of ShopDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ShopDtoCopyWith<_ShopDto> get copyWith => __$ShopDtoCopyWithImpl<_ShopDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ShopDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ShopDto&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.address, address) || other.address == address)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder)&&(identical(other.imageAsset, imageAsset) || other.imageAsset == imageAsset));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,name,address,imageUrl,sortOrder,imageAsset);
}

@override
String toString() {
    return 'ShopDto(id: $id, name: $name, address: $address, imageUrl: $imageUrl, sortOrder: $sortOrder, imageAsset: $imageAsset)';
}


}

/// @nodoc
abstract mixin class _$ShopDtoCopyWith<$Res> implements $ShopDtoCopyWith<$Res> {
  factory _$ShopDtoCopyWith(_ShopDto value, $Res Function(_ShopDto) _then) = __$ShopDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String address, String imageUrl, int sortOrder, String? imageAsset
});




}
/// @nodoc
class __$ShopDtoCopyWithImpl<$Res>
    implements _$ShopDtoCopyWith<$Res> {
  __$ShopDtoCopyWithImpl(this._self, this._then);

  final _ShopDto _self;
  final $Res Function(_ShopDto) _then;

/// Create a copy of ShopDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? address = null,Object? imageUrl = null,Object? sortOrder = null,Object? imageAsset = freezed,}) {
  return _then(_ShopDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,imageAsset: freezed == imageAsset ? _self.imageAsset : imageAsset // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$GiftDto {

 String get id; String get title; int get costPoints; int get sortOrder; String? get imageUrl; String? get imageAsset;
/// Create a copy of GiftDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GiftDtoCopyWith<GiftDto> get copyWith => _$GiftDtoCopyWithImpl<GiftDto>(this as GiftDto, _$identity);

  /// Serializes this GiftDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as GiftDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GiftDto&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.costPoints, _this.costPoints) || other.costPoints == _this.costPoints)&&(identical(other.sortOrder, _this.sortOrder) || other.sortOrder == _this.sortOrder)&&(identical(other.imageUrl, _this.imageUrl) || other.imageUrl == _this.imageUrl)&&(identical(other.imageAsset, _this.imageAsset) || other.imageAsset == _this.imageAsset));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as GiftDto;
  return Object.hash(runtimeType,_this.id,_this.title,_this.costPoints,_this.sortOrder,_this.imageUrl,_this.imageAsset);
}

@override
String toString() {
  final _this = this as GiftDto;
  return 'GiftDto(id: ${_this.id}, title: ${_this.title}, costPoints: ${_this.costPoints}, sortOrder: ${_this.sortOrder}, imageUrl: ${_this.imageUrl}, imageAsset: ${_this.imageAsset})';
}


}

/// @nodoc
abstract mixin class $GiftDtoCopyWith<$Res>  {
  factory $GiftDtoCopyWith(GiftDto value, $Res Function(GiftDto) _then) = _$GiftDtoCopyWithImpl;
@useResult
$Res call({
 String id, String title, int costPoints, int sortOrder, String? imageUrl, String? imageAsset
});




}
/// @nodoc
class _$GiftDtoCopyWithImpl<$Res>
    implements $GiftDtoCopyWith<$Res> {
  _$GiftDtoCopyWithImpl(this._self, this._then);

  final GiftDto _self;
  final $Res Function(GiftDto) _then;

/// Create a copy of GiftDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? costPoints = null,Object? sortOrder = null,Object? imageUrl = freezed,Object? imageAsset = freezed,}) {
  return _then(GiftDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,costPoints: null == costPoints ? _self.costPoints : costPoints // ignore: cast_nullable_to_non_nullable
as int,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,imageAsset: freezed == imageAsset ? _self.imageAsset : imageAsset // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [GiftDto].
extension GiftDtoPatterns on GiftDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GiftDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GiftDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GiftDto value)  $default,){
final _that = this;
switch (_that) {
case _GiftDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GiftDto value)?  $default,){
final _that = this;
switch (_that) {
case _GiftDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  int costPoints,  int sortOrder,  String? imageUrl,  String? imageAsset)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GiftDto() when $default != null:
return $default(_that.id,_that.title,_that.costPoints,_that.sortOrder,_that.imageUrl,_that.imageAsset);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  int costPoints,  int sortOrder,  String? imageUrl,  String? imageAsset)  $default,) {final _that = this;
switch (_that) {
case _GiftDto():
return $default(_that.id,_that.title,_that.costPoints,_that.sortOrder,_that.imageUrl,_that.imageAsset);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  int costPoints,  int sortOrder,  String? imageUrl,  String? imageAsset)?  $default,) {final _that = this;
switch (_that) {
case _GiftDto() when $default != null:
return $default(_that.id,_that.title,_that.costPoints,_that.sortOrder,_that.imageUrl,_that.imageAsset);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GiftDto implements GiftDto {
  const _GiftDto({required this.id, required this.title, required this.costPoints, required this.sortOrder, this.imageUrl, this.imageAsset});
  factory _GiftDto.fromJson(Map<String, dynamic> json) => _$GiftDtoFromJson(json);

@override final  String id;
@override final  String title;
@override final  int costPoints;
@override final  int sortOrder;
@override final  String? imageUrl;
@override final  String? imageAsset;

/// Create a copy of GiftDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GiftDtoCopyWith<_GiftDto> get copyWith => __$GiftDtoCopyWithImpl<_GiftDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GiftDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _GiftDto&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.costPoints, costPoints) || other.costPoints == costPoints)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.imageAsset, imageAsset) || other.imageAsset == imageAsset));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,title,costPoints,sortOrder,imageUrl,imageAsset);
}

@override
String toString() {
    return 'GiftDto(id: $id, title: $title, costPoints: $costPoints, sortOrder: $sortOrder, imageUrl: $imageUrl, imageAsset: $imageAsset)';
}


}

/// @nodoc
abstract mixin class _$GiftDtoCopyWith<$Res> implements $GiftDtoCopyWith<$Res> {
  factory _$GiftDtoCopyWith(_GiftDto value, $Res Function(_GiftDto) _then) = __$GiftDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, int costPoints, int sortOrder, String? imageUrl, String? imageAsset
});




}
/// @nodoc
class __$GiftDtoCopyWithImpl<$Res>
    implements _$GiftDtoCopyWith<$Res> {
  __$GiftDtoCopyWithImpl(this._self, this._then);

  final _GiftDto _self;
  final $Res Function(_GiftDto) _then;

/// Create a copy of GiftDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? costPoints = null,Object? sortOrder = null,Object? imageUrl = freezed,Object? imageAsset = freezed,}) {
  return _then(_GiftDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,costPoints: null == costPoints ? _self.costPoints : costPoints // ignore: cast_nullable_to_non_nullable
as int,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,imageAsset: freezed == imageAsset ? _self.imageAsset : imageAsset // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
