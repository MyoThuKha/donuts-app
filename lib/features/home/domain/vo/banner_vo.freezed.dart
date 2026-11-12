// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'banner_vo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BannerVO {

 String get id; String get tag; String get title; BannerStyle get style; String get imageUrl; String? get imageAsset;
/// Create a copy of BannerVO
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BannerVOCopyWith<BannerVO> get copyWith => _$BannerVOCopyWithImpl<BannerVO>(this as BannerVO, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as BannerVO;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BannerVO&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.tag, _this.tag) || other.tag == _this.tag)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.style, _this.style) || other.style == _this.style)&&(identical(other.imageUrl, _this.imageUrl) || other.imageUrl == _this.imageUrl)&&(identical(other.imageAsset, _this.imageAsset) || other.imageAsset == _this.imageAsset));
}


@override
int get hashCode {
  final _this = this as BannerVO;
  return Object.hash(runtimeType,_this.id,_this.tag,_this.title,_this.style,_this.imageUrl,_this.imageAsset);
}

@override
String toString() {
  final _this = this as BannerVO;
  return 'BannerVO(id: ${_this.id}, tag: ${_this.tag}, title: ${_this.title}, style: ${_this.style}, imageUrl: ${_this.imageUrl}, imageAsset: ${_this.imageAsset})';
}


}

/// @nodoc
abstract mixin class $BannerVOCopyWith<$Res>  {
  factory $BannerVOCopyWith(BannerVO value, $Res Function(BannerVO) _then) = _$BannerVOCopyWithImpl;
@useResult
$Res call({
 String id, String tag, String title, BannerStyle style, String imageUrl, String? imageAsset
});




}
/// @nodoc
class _$BannerVOCopyWithImpl<$Res>
    implements $BannerVOCopyWith<$Res> {
  _$BannerVOCopyWithImpl(this._self, this._then);

  final BannerVO _self;
  final $Res Function(BannerVO) _then;

/// Create a copy of BannerVO
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? tag = null,Object? title = null,Object? style = null,Object? imageUrl = null,Object? imageAsset = freezed,}) {
  return _then(BannerVO(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,tag: null == tag ? _self.tag : tag // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,style: null == style ? _self.style : style // ignore: cast_nullable_to_non_nullable
as BannerStyle,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,imageAsset: freezed == imageAsset ? _self.imageAsset : imageAsset // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [BannerVO].
extension BannerVOPatterns on BannerVO {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BannerVO value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BannerVO() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BannerVO value)  $default,){
final _that = this;
switch (_that) {
case _BannerVO():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BannerVO value)?  $default,){
final _that = this;
switch (_that) {
case _BannerVO() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String tag,  String title,  BannerStyle style,  String imageUrl,  String? imageAsset)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BannerVO() when $default != null:
return $default(_that.id,_that.tag,_that.title,_that.style,_that.imageUrl,_that.imageAsset);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String tag,  String title,  BannerStyle style,  String imageUrl,  String? imageAsset)  $default,) {final _that = this;
switch (_that) {
case _BannerVO():
return $default(_that.id,_that.tag,_that.title,_that.style,_that.imageUrl,_that.imageAsset);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String tag,  String title,  BannerStyle style,  String imageUrl,  String? imageAsset)?  $default,) {final _that = this;
switch (_that) {
case _BannerVO() when $default != null:
return $default(_that.id,_that.tag,_that.title,_that.style,_that.imageUrl,_that.imageAsset);case _:
  return null;

}
}

}

/// @nodoc


class _BannerVO implements BannerVO {
  const _BannerVO({required this.id, required this.tag, required this.title, required this.style, required this.imageUrl, this.imageAsset});
  

@override final  String id;
@override final  String tag;
@override final  String title;
@override final  BannerStyle style;
@override final  String imageUrl;
@override final  String? imageAsset;

/// Create a copy of BannerVO
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BannerVOCopyWith<_BannerVO> get copyWith => __$BannerVOCopyWithImpl<_BannerVO>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _BannerVO&&(identical(other.id, id) || other.id == id)&&(identical(other.tag, tag) || other.tag == tag)&&(identical(other.title, title) || other.title == title)&&(identical(other.style, style) || other.style == style)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.imageAsset, imageAsset) || other.imageAsset == imageAsset));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,tag,title,style,imageUrl,imageAsset);
}

@override
String toString() {
    return 'BannerVO(id: $id, tag: $tag, title: $title, style: $style, imageUrl: $imageUrl, imageAsset: $imageAsset)';
}


}

/// @nodoc
abstract mixin class _$BannerVOCopyWith<$Res> implements $BannerVOCopyWith<$Res> {
  factory _$BannerVOCopyWith(_BannerVO value, $Res Function(_BannerVO) _then) = __$BannerVOCopyWithImpl;
@override @useResult
$Res call({
 String id, String tag, String title, BannerStyle style, String imageUrl, String? imageAsset
});




}
/// @nodoc
class __$BannerVOCopyWithImpl<$Res>
    implements _$BannerVOCopyWith<$Res> {
  __$BannerVOCopyWithImpl(this._self, this._then);

  final _BannerVO _self;
  final $Res Function(_BannerVO) _then;

/// Create a copy of BannerVO
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? tag = null,Object? title = null,Object? style = null,Object? imageUrl = null,Object? imageAsset = freezed,}) {
  return _then(_BannerVO(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,tag: null == tag ? _self.tag : tag // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,style: null == style ? _self.style : style // ignore: cast_nullable_to_non_nullable
as BannerStyle,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,imageAsset: freezed == imageAsset ? _self.imageAsset : imageAsset // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
