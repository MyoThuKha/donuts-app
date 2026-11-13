// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'set_cart_quantity_params.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SetCartQuantityParams {

 String get productId; int get quantity;
/// Create a copy of SetCartQuantityParams
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SetCartQuantityParamsCopyWith<SetCartQuantityParams> get copyWith => _$SetCartQuantityParamsCopyWithImpl<SetCartQuantityParams>(this as SetCartQuantityParams, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as SetCartQuantityParams;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SetCartQuantityParams&&(identical(other.productId, _this.productId) || other.productId == _this.productId)&&(identical(other.quantity, _this.quantity) || other.quantity == _this.quantity));
}


@override
int get hashCode {
  final _this = this as SetCartQuantityParams;
  return Object.hash(runtimeType,_this.productId,_this.quantity);
}

@override
String toString() {
  final _this = this as SetCartQuantityParams;
  return 'SetCartQuantityParams(productId: ${_this.productId}, quantity: ${_this.quantity})';
}


}

/// @nodoc
abstract mixin class $SetCartQuantityParamsCopyWith<$Res>  {
  factory $SetCartQuantityParamsCopyWith(SetCartQuantityParams value, $Res Function(SetCartQuantityParams) _then) = _$SetCartQuantityParamsCopyWithImpl;
@useResult
$Res call({
 String productId, int quantity
});




}
/// @nodoc
class _$SetCartQuantityParamsCopyWithImpl<$Res>
    implements $SetCartQuantityParamsCopyWith<$Res> {
  _$SetCartQuantityParamsCopyWithImpl(this._self, this._then);

  final SetCartQuantityParams _self;
  final $Res Function(SetCartQuantityParams) _then;

/// Create a copy of SetCartQuantityParams
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? productId = null,Object? quantity = null,}) {
  return _then(SetCartQuantityParams(
productId: null == productId ? _self.productId : productId // ignore: cast_nullable_to_non_nullable
as String,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [SetCartQuantityParams].
extension SetCartQuantityParamsPatterns on SetCartQuantityParams {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SetCartQuantityParams value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SetCartQuantityParams() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SetCartQuantityParams value)  $default,){
final _that = this;
switch (_that) {
case _SetCartQuantityParams():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SetCartQuantityParams value)?  $default,){
final _that = this;
switch (_that) {
case _SetCartQuantityParams() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String productId,  int quantity)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SetCartQuantityParams() when $default != null:
return $default(_that.productId,_that.quantity);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String productId,  int quantity)  $default,) {final _that = this;
switch (_that) {
case _SetCartQuantityParams():
return $default(_that.productId,_that.quantity);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String productId,  int quantity)?  $default,) {final _that = this;
switch (_that) {
case _SetCartQuantityParams() when $default != null:
return $default(_that.productId,_that.quantity);case _:
  return null;

}
}

}

/// @nodoc


class _SetCartQuantityParams implements SetCartQuantityParams {
  const _SetCartQuantityParams({required this.productId, required this.quantity});
  

@override final  String productId;
@override final  int quantity;

/// Create a copy of SetCartQuantityParams
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SetCartQuantityParamsCopyWith<_SetCartQuantityParams> get copyWith => __$SetCartQuantityParamsCopyWithImpl<_SetCartQuantityParams>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SetCartQuantityParams&&(identical(other.productId, productId) || other.productId == productId)&&(identical(other.quantity, quantity) || other.quantity == quantity));
}


@override
int get hashCode {
    return Object.hash(runtimeType,productId,quantity);
}

@override
String toString() {
    return 'SetCartQuantityParams(productId: $productId, quantity: $quantity)';
}


}

/// @nodoc
abstract mixin class _$SetCartQuantityParamsCopyWith<$Res> implements $SetCartQuantityParamsCopyWith<$Res> {
  factory _$SetCartQuantityParamsCopyWith(_SetCartQuantityParams value, $Res Function(_SetCartQuantityParams) _then) = __$SetCartQuantityParamsCopyWithImpl;
@override @useResult
$Res call({
 String productId, int quantity
});




}
/// @nodoc
class __$SetCartQuantityParamsCopyWithImpl<$Res>
    implements _$SetCartQuantityParamsCopyWith<$Res> {
  __$SetCartQuantityParamsCopyWithImpl(this._self, this._then);

  final _SetCartQuantityParams _self;
  final $Res Function(_SetCartQuantityParams) _then;

/// Create a copy of SetCartQuantityParams
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? productId = null,Object? quantity = null,}) {
  return _then(_SetCartQuantityParams(
productId: null == productId ? _self.productId : productId // ignore: cast_nullable_to_non_nullable
as String,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
