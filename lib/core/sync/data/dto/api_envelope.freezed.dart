// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'api_envelope.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ApiEnvelope<T> {

 ApiMetaDto get meta; T? get data; ApiErrorDto? get error;
/// Create a copy of ApiEnvelope
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ApiEnvelopeCopyWith<T, ApiEnvelope<T>> get copyWith => _$ApiEnvelopeCopyWithImpl<T, ApiEnvelope<T>>(this as ApiEnvelope<T>, _$identity);

  /// Serializes this ApiEnvelope to a JSON map.
  Map<String, dynamic> toJson(Object? Function(T) toJsonT);


@override
bool operator ==(Object other) {
  final _this = this as ApiEnvelope<T>;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ApiEnvelope<T>&&(identical(other.meta, _this.meta) || other.meta == _this.meta)&&const DeepCollectionEquality().equals(other.data, _this.data)&&(identical(other.error, _this.error) || other.error == _this.error));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ApiEnvelope<T>;
  return Object.hash(runtimeType,_this.meta,const DeepCollectionEquality().hash(_this.data),_this.error);
}

@override
String toString() {
  final _this = this as ApiEnvelope<T>;
  return 'ApiEnvelope<$T>(meta: ${_this.meta}, data: ${_this.data}, error: ${_this.error})';
}


}

/// @nodoc
abstract mixin class $ApiEnvelopeCopyWith<T,$Res>  {
  factory $ApiEnvelopeCopyWith(ApiEnvelope<T> value, $Res Function(ApiEnvelope<T>) _then) = _$ApiEnvelopeCopyWithImpl;
@useResult
$Res call({
 ApiMetaDto meta, T? data, ApiErrorDto? error
});


$ApiMetaDtoCopyWith<$Res> get meta;$ApiErrorDtoCopyWith<$Res>? get error;

}
/// @nodoc
class _$ApiEnvelopeCopyWithImpl<T,$Res>
    implements $ApiEnvelopeCopyWith<T, $Res> {
  _$ApiEnvelopeCopyWithImpl(this._self, this._then);

  final ApiEnvelope<T> _self;
  final $Res Function(ApiEnvelope<T>) _then;

/// Create a copy of ApiEnvelope
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? meta = null,Object? data = freezed,Object? error = freezed,}) {
  return _then(ApiEnvelope(
meta: null == meta ? _self.meta : meta // ignore: cast_nullable_to_non_nullable
as ApiMetaDto,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as T?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as ApiErrorDto?,
  ));
}
/// Create a copy of ApiEnvelope
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ApiMetaDtoCopyWith<$Res> get meta {
  
  return $ApiMetaDtoCopyWith<$Res>(_self.meta, (value) {
    return _then(_self.copyWith(meta: value));
  });
}/// Create a copy of ApiEnvelope
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ApiErrorDtoCopyWith<$Res>? get error {
    if (_self.error == null) {
    return null;
  }

  return $ApiErrorDtoCopyWith<$Res>(_self.error!, (value) {
    return _then(_self.copyWith(error: value));
  });
}
}


/// Adds pattern-matching-related methods to [ApiEnvelope].
extension ApiEnvelopePatterns<T> on ApiEnvelope<T> {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ApiEnvelope<T> value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ApiEnvelope() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ApiEnvelope<T> value)  $default,){
final _that = this;
switch (_that) {
case _ApiEnvelope():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ApiEnvelope<T> value)?  $default,){
final _that = this;
switch (_that) {
case _ApiEnvelope() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ApiMetaDto meta,  T? data,  ApiErrorDto? error)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ApiEnvelope() when $default != null:
return $default(_that.meta,_that.data,_that.error);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ApiMetaDto meta,  T? data,  ApiErrorDto? error)  $default,) {final _that = this;
switch (_that) {
case _ApiEnvelope():
return $default(_that.meta,_that.data,_that.error);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ApiMetaDto meta,  T? data,  ApiErrorDto? error)?  $default,) {final _that = this;
switch (_that) {
case _ApiEnvelope() when $default != null:
return $default(_that.meta,_that.data,_that.error);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable(genericArgumentFactories: true)

class _ApiEnvelope<T> implements ApiEnvelope<T> {
  const _ApiEnvelope({required this.meta, this.data, this.error});
  factory _ApiEnvelope.fromJson(Map<String, dynamic> json,T Function(Object?) fromJsonT) => _$ApiEnvelopeFromJson(json,fromJsonT);

@override final  ApiMetaDto meta;
@override final  T? data;
@override final  ApiErrorDto? error;

/// Create a copy of ApiEnvelope
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ApiEnvelopeCopyWith<T, _ApiEnvelope<T>> get copyWith => __$ApiEnvelopeCopyWithImpl<T, _ApiEnvelope<T>>(this, _$identity);

@override
Map<String, dynamic> toJson(Object? Function(T) toJsonT) {
  return _$ApiEnvelopeToJson<T>(this, toJsonT);
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ApiEnvelope<T>&&(identical(other.meta, meta) || other.meta == meta)&&const DeepCollectionEquality().equals(other.data, data)&&(identical(other.error, error) || other.error == error));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,meta,const DeepCollectionEquality().hash(data),error);
}

@override
String toString() {
    return 'ApiEnvelope<$T>(meta: $meta, data: $data, error: $error)';
}


}

/// @nodoc
abstract mixin class _$ApiEnvelopeCopyWith<T,$Res> implements $ApiEnvelopeCopyWith<T, $Res> {
  factory _$ApiEnvelopeCopyWith(_ApiEnvelope<T> value, $Res Function(_ApiEnvelope<T>) _then) = __$ApiEnvelopeCopyWithImpl;
@override @useResult
$Res call({
 ApiMetaDto meta, T? data, ApiErrorDto? error
});


@override $ApiMetaDtoCopyWith<$Res> get meta;@override $ApiErrorDtoCopyWith<$Res>? get error;

}
/// @nodoc
class __$ApiEnvelopeCopyWithImpl<T,$Res>
    implements _$ApiEnvelopeCopyWith<T, $Res> {
  __$ApiEnvelopeCopyWithImpl(this._self, this._then);

  final _ApiEnvelope<T> _self;
  final $Res Function(_ApiEnvelope<T>) _then;

/// Create a copy of ApiEnvelope
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? meta = null,Object? data = freezed,Object? error = freezed,}) {
  return _then(_ApiEnvelope<T>(
meta: null == meta ? _self.meta : meta // ignore: cast_nullable_to_non_nullable
as ApiMetaDto,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as T?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as ApiErrorDto?,
  ));
}

/// Create a copy of ApiEnvelope
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ApiMetaDtoCopyWith<$Res> get meta {
  
  return $ApiMetaDtoCopyWith<$Res>(_self.meta, (value) {
    return _then(_self.copyWith(meta: value));
  });
}/// Create a copy of ApiEnvelope
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ApiErrorDtoCopyWith<$Res>? get error {
    if (_self.error == null) {
    return null;
  }

  return $ApiErrorDtoCopyWith<$Res>(_self.error!, (value) {
    return _then(_self.copyWith(error: value));
  });
}
}


/// @nodoc
mixin _$ApiMetaDto {

 int get version; DateTime get generatedAt;
/// Create a copy of ApiMetaDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ApiMetaDtoCopyWith<ApiMetaDto> get copyWith => _$ApiMetaDtoCopyWithImpl<ApiMetaDto>(this as ApiMetaDto, _$identity);

  /// Serializes this ApiMetaDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ApiMetaDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ApiMetaDto&&(identical(other.version, _this.version) || other.version == _this.version)&&(identical(other.generatedAt, _this.generatedAt) || other.generatedAt == _this.generatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ApiMetaDto;
  return Object.hash(runtimeType,_this.version,_this.generatedAt);
}

@override
String toString() {
  final _this = this as ApiMetaDto;
  return 'ApiMetaDto(version: ${_this.version}, generatedAt: ${_this.generatedAt})';
}


}

/// @nodoc
abstract mixin class $ApiMetaDtoCopyWith<$Res>  {
  factory $ApiMetaDtoCopyWith(ApiMetaDto value, $Res Function(ApiMetaDto) _then) = _$ApiMetaDtoCopyWithImpl;
@useResult
$Res call({
 int version, DateTime generatedAt
});




}
/// @nodoc
class _$ApiMetaDtoCopyWithImpl<$Res>
    implements $ApiMetaDtoCopyWith<$Res> {
  _$ApiMetaDtoCopyWithImpl(this._self, this._then);

  final ApiMetaDto _self;
  final $Res Function(ApiMetaDto) _then;

/// Create a copy of ApiMetaDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? version = null,Object? generatedAt = null,}) {
  return _then(ApiMetaDto(
version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int,generatedAt: null == generatedAt ? _self.generatedAt : generatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [ApiMetaDto].
extension ApiMetaDtoPatterns on ApiMetaDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ApiMetaDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ApiMetaDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ApiMetaDto value)  $default,){
final _that = this;
switch (_that) {
case _ApiMetaDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ApiMetaDto value)?  $default,){
final _that = this;
switch (_that) {
case _ApiMetaDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int version,  DateTime generatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ApiMetaDto() when $default != null:
return $default(_that.version,_that.generatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int version,  DateTime generatedAt)  $default,) {final _that = this;
switch (_that) {
case _ApiMetaDto():
return $default(_that.version,_that.generatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int version,  DateTime generatedAt)?  $default,) {final _that = this;
switch (_that) {
case _ApiMetaDto() when $default != null:
return $default(_that.version,_that.generatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ApiMetaDto implements ApiMetaDto {
  const _ApiMetaDto({required this.version, required this.generatedAt});
  factory _ApiMetaDto.fromJson(Map<String, dynamic> json) => _$ApiMetaDtoFromJson(json);

@override final  int version;
@override final  DateTime generatedAt;

/// Create a copy of ApiMetaDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ApiMetaDtoCopyWith<_ApiMetaDto> get copyWith => __$ApiMetaDtoCopyWithImpl<_ApiMetaDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ApiMetaDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ApiMetaDto&&(identical(other.version, version) || other.version == version)&&(identical(other.generatedAt, generatedAt) || other.generatedAt == generatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,version,generatedAt);
}

@override
String toString() {
    return 'ApiMetaDto(version: $version, generatedAt: $generatedAt)';
}


}

/// @nodoc
abstract mixin class _$ApiMetaDtoCopyWith<$Res> implements $ApiMetaDtoCopyWith<$Res> {
  factory _$ApiMetaDtoCopyWith(_ApiMetaDto value, $Res Function(_ApiMetaDto) _then) = __$ApiMetaDtoCopyWithImpl;
@override @useResult
$Res call({
 int version, DateTime generatedAt
});




}
/// @nodoc
class __$ApiMetaDtoCopyWithImpl<$Res>
    implements _$ApiMetaDtoCopyWith<$Res> {
  __$ApiMetaDtoCopyWithImpl(this._self, this._then);

  final _ApiMetaDto _self;
  final $Res Function(_ApiMetaDto) _then;

/// Create a copy of ApiMetaDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? version = null,Object? generatedAt = null,}) {
  return _then(_ApiMetaDto(
version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int,generatedAt: null == generatedAt ? _self.generatedAt : generatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}


/// @nodoc
mixin _$ApiErrorDto {

 String get code; String get message;
/// Create a copy of ApiErrorDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ApiErrorDtoCopyWith<ApiErrorDto> get copyWith => _$ApiErrorDtoCopyWithImpl<ApiErrorDto>(this as ApiErrorDto, _$identity);

  /// Serializes this ApiErrorDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ApiErrorDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ApiErrorDto&&(identical(other.code, _this.code) || other.code == _this.code)&&(identical(other.message, _this.message) || other.message == _this.message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ApiErrorDto;
  return Object.hash(runtimeType,_this.code,_this.message);
}

@override
String toString() {
  final _this = this as ApiErrorDto;
  return 'ApiErrorDto(code: ${_this.code}, message: ${_this.message})';
}


}

/// @nodoc
abstract mixin class $ApiErrorDtoCopyWith<$Res>  {
  factory $ApiErrorDtoCopyWith(ApiErrorDto value, $Res Function(ApiErrorDto) _then) = _$ApiErrorDtoCopyWithImpl;
@useResult
$Res call({
 String code, String message
});




}
/// @nodoc
class _$ApiErrorDtoCopyWithImpl<$Res>
    implements $ApiErrorDtoCopyWith<$Res> {
  _$ApiErrorDtoCopyWithImpl(this._self, this._then);

  final ApiErrorDto _self;
  final $Res Function(ApiErrorDto) _then;

/// Create a copy of ApiErrorDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,Object? message = null,}) {
  return _then(ApiErrorDto(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ApiErrorDto].
extension ApiErrorDtoPatterns on ApiErrorDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ApiErrorDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ApiErrorDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ApiErrorDto value)  $default,){
final _that = this;
switch (_that) {
case _ApiErrorDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ApiErrorDto value)?  $default,){
final _that = this;
switch (_that) {
case _ApiErrorDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String code,  String message)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ApiErrorDto() when $default != null:
return $default(_that.code,_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String code,  String message)  $default,) {final _that = this;
switch (_that) {
case _ApiErrorDto():
return $default(_that.code,_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String code,  String message)?  $default,) {final _that = this;
switch (_that) {
case _ApiErrorDto() when $default != null:
return $default(_that.code,_that.message);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ApiErrorDto implements ApiErrorDto {
  const _ApiErrorDto({required this.code, required this.message});
  factory _ApiErrorDto.fromJson(Map<String, dynamic> json) => _$ApiErrorDtoFromJson(json);

@override final  String code;
@override final  String message;

/// Create a copy of ApiErrorDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ApiErrorDtoCopyWith<_ApiErrorDto> get copyWith => __$ApiErrorDtoCopyWithImpl<_ApiErrorDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ApiErrorDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ApiErrorDto&&(identical(other.code, code) || other.code == code)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,code,message);
}

@override
String toString() {
    return 'ApiErrorDto(code: $code, message: $message)';
}


}

/// @nodoc
abstract mixin class _$ApiErrorDtoCopyWith<$Res> implements $ApiErrorDtoCopyWith<$Res> {
  factory _$ApiErrorDtoCopyWith(_ApiErrorDto value, $Res Function(_ApiErrorDto) _then) = __$ApiErrorDtoCopyWithImpl;
@override @useResult
$Res call({
 String code, String message
});




}
/// @nodoc
class __$ApiErrorDtoCopyWithImpl<$Res>
    implements _$ApiErrorDtoCopyWith<$Res> {
  __$ApiErrorDtoCopyWithImpl(this._self, this._then);

  final _ApiErrorDto _self;
  final $Res Function(_ApiErrorDto) _then;

/// Create a copy of ApiErrorDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? message = null,}) {
  return _then(_ApiErrorDto(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
