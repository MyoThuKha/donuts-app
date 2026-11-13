// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_section_vo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$HomeSectionVO {

 String get id;/// The catalog's title key. Shown as is when [kind] is `other`.
 String get titleKey; HomeSectionKind get kind;
/// Create a copy of HomeSectionVO
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HomeSectionVOCopyWith<HomeSectionVO> get copyWith => _$HomeSectionVOCopyWithImpl<HomeSectionVO>(this as HomeSectionVO, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as HomeSectionVO;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeSectionVO&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.titleKey, _this.titleKey) || other.titleKey == _this.titleKey)&&(identical(other.kind, _this.kind) || other.kind == _this.kind));
}


@override
int get hashCode {
  final _this = this as HomeSectionVO;
  return Object.hash(runtimeType,_this.id,_this.titleKey,_this.kind);
}

@override
String toString() {
  final _this = this as HomeSectionVO;
  return 'HomeSectionVO(id: ${_this.id}, titleKey: ${_this.titleKey}, kind: ${_this.kind})';
}


}

/// @nodoc
abstract mixin class $HomeSectionVOCopyWith<$Res>  {
  factory $HomeSectionVOCopyWith(HomeSectionVO value, $Res Function(HomeSectionVO) _then) = _$HomeSectionVOCopyWithImpl;
@useResult
$Res call({
 String id, String titleKey, HomeSectionKind kind
});




}
/// @nodoc
class _$HomeSectionVOCopyWithImpl<$Res>
    implements $HomeSectionVOCopyWith<$Res> {
  _$HomeSectionVOCopyWithImpl(this._self, this._then);

  final HomeSectionVO _self;
  final $Res Function(HomeSectionVO) _then;

/// Create a copy of HomeSectionVO
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? titleKey = null,Object? kind = null,}) {
  return _then(HomeSectionVO(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,titleKey: null == titleKey ? _self.titleKey : titleKey // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as HomeSectionKind,
  ));
}

}


/// Adds pattern-matching-related methods to [HomeSectionVO].
extension HomeSectionVOPatterns on HomeSectionVO {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HomeSectionVO value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HomeSectionVO() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HomeSectionVO value)  $default,){
final _that = this;
switch (_that) {
case _HomeSectionVO():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HomeSectionVO value)?  $default,){
final _that = this;
switch (_that) {
case _HomeSectionVO() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String titleKey,  HomeSectionKind kind)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HomeSectionVO() when $default != null:
return $default(_that.id,_that.titleKey,_that.kind);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String titleKey,  HomeSectionKind kind)  $default,) {final _that = this;
switch (_that) {
case _HomeSectionVO():
return $default(_that.id,_that.titleKey,_that.kind);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String titleKey,  HomeSectionKind kind)?  $default,) {final _that = this;
switch (_that) {
case _HomeSectionVO() when $default != null:
return $default(_that.id,_that.titleKey,_that.kind);case _:
  return null;

}
}

}

/// @nodoc


class _HomeSectionVO implements HomeSectionVO {
  const _HomeSectionVO({required this.id, required this.titleKey, required this.kind});
  

@override final  String id;
/// The catalog's title key. Shown as is when [kind] is `other`.
@override final  String titleKey;
@override final  HomeSectionKind kind;

/// Create a copy of HomeSectionVO
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HomeSectionVOCopyWith<_HomeSectionVO> get copyWith => __$HomeSectionVOCopyWithImpl<_HomeSectionVO>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _HomeSectionVO&&(identical(other.id, id) || other.id == id)&&(identical(other.titleKey, titleKey) || other.titleKey == titleKey)&&(identical(other.kind, kind) || other.kind == kind));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,titleKey,kind);
}

@override
String toString() {
    return 'HomeSectionVO(id: $id, titleKey: $titleKey, kind: $kind)';
}


}

/// @nodoc
abstract mixin class _$HomeSectionVOCopyWith<$Res> implements $HomeSectionVOCopyWith<$Res> {
  factory _$HomeSectionVOCopyWith(_HomeSectionVO value, $Res Function(_HomeSectionVO) _then) = __$HomeSectionVOCopyWithImpl;
@override @useResult
$Res call({
 String id, String titleKey, HomeSectionKind kind
});




}
/// @nodoc
class __$HomeSectionVOCopyWithImpl<$Res>
    implements _$HomeSectionVOCopyWith<$Res> {
  __$HomeSectionVOCopyWithImpl(this._self, this._then);

  final _HomeSectionVO _self;
  final $Res Function(_HomeSectionVO) _then;

/// Create a copy of HomeSectionVO
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? titleKey = null,Object? kind = null,}) {
  return _then(_HomeSectionVO(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,titleKey: null == titleKey ? _self.titleKey : titleKey // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as HomeSectionKind,
  ));
}


}

// dart format on
