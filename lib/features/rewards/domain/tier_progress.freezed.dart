// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tier_progress.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TierProgress {

/// Share of the way from [current] (or zero points) to [next], 0 to 1.
/// It is 1 when there is no next tier.
 double get progress;/// Null below the lowest tier.
 TierVO? get current;/// Null at the top tier.
 TierVO? get next;/// Null at the top tier.
 int? get pointsToNext;
/// Create a copy of TierProgress
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TierProgressCopyWith<TierProgress> get copyWith => _$TierProgressCopyWithImpl<TierProgress>(this as TierProgress, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as TierProgress;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TierProgress&&(identical(other.progress, _this.progress) || other.progress == _this.progress)&&(identical(other.current, _this.current) || other.current == _this.current)&&(identical(other.next, _this.next) || other.next == _this.next)&&(identical(other.pointsToNext, _this.pointsToNext) || other.pointsToNext == _this.pointsToNext));
}


@override
int get hashCode {
  final _this = this as TierProgress;
  return Object.hash(runtimeType,_this.progress,_this.current,_this.next,_this.pointsToNext);
}

@override
String toString() {
  final _this = this as TierProgress;
  return 'TierProgress(progress: ${_this.progress}, current: ${_this.current}, next: ${_this.next}, pointsToNext: ${_this.pointsToNext})';
}


}

/// @nodoc
abstract mixin class $TierProgressCopyWith<$Res>  {
  factory $TierProgressCopyWith(TierProgress value, $Res Function(TierProgress) _then) = _$TierProgressCopyWithImpl;
@useResult
$Res call({
 double progress, TierVO? current, TierVO? next, int? pointsToNext
});


$TierVOCopyWith<$Res>? get current;$TierVOCopyWith<$Res>? get next;

}
/// @nodoc
class _$TierProgressCopyWithImpl<$Res>
    implements $TierProgressCopyWith<$Res> {
  _$TierProgressCopyWithImpl(this._self, this._then);

  final TierProgress _self;
  final $Res Function(TierProgress) _then;

/// Create a copy of TierProgress
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? progress = null,Object? current = freezed,Object? next = freezed,Object? pointsToNext = freezed,}) {
  return _then(TierProgress(
progress: null == progress ? _self.progress : progress // ignore: cast_nullable_to_non_nullable
as double,current: freezed == current ? _self.current : current // ignore: cast_nullable_to_non_nullable
as TierVO?,next: freezed == next ? _self.next : next // ignore: cast_nullable_to_non_nullable
as TierVO?,pointsToNext: freezed == pointsToNext ? _self.pointsToNext : pointsToNext // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}
/// Create a copy of TierProgress
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TierVOCopyWith<$Res>? get current {
    if (_self.current == null) {
    return null;
  }

  return $TierVOCopyWith<$Res>(_self.current!, (value) {
    return _then(_self.copyWith(current: value));
  });
}/// Create a copy of TierProgress
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TierVOCopyWith<$Res>? get next {
    if (_self.next == null) {
    return null;
  }

  return $TierVOCopyWith<$Res>(_self.next!, (value) {
    return _then(_self.copyWith(next: value));
  });
}
}


/// Adds pattern-matching-related methods to [TierProgress].
extension TierProgressPatterns on TierProgress {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TierProgress value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TierProgress() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TierProgress value)  $default,){
final _that = this;
switch (_that) {
case _TierProgress():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TierProgress value)?  $default,){
final _that = this;
switch (_that) {
case _TierProgress() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double progress,  TierVO? current,  TierVO? next,  int? pointsToNext)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TierProgress() when $default != null:
return $default(_that.progress,_that.current,_that.next,_that.pointsToNext);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double progress,  TierVO? current,  TierVO? next,  int? pointsToNext)  $default,) {final _that = this;
switch (_that) {
case _TierProgress():
return $default(_that.progress,_that.current,_that.next,_that.pointsToNext);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double progress,  TierVO? current,  TierVO? next,  int? pointsToNext)?  $default,) {final _that = this;
switch (_that) {
case _TierProgress() when $default != null:
return $default(_that.progress,_that.current,_that.next,_that.pointsToNext);case _:
  return null;

}
}

}

/// @nodoc


class _TierProgress implements TierProgress {
  const _TierProgress({required this.progress, this.current, this.next, this.pointsToNext});
  

/// Share of the way from [current] (or zero points) to [next], 0 to 1.
/// It is 1 when there is no next tier.
@override final  double progress;
/// Null below the lowest tier.
@override final  TierVO? current;
/// Null at the top tier.
@override final  TierVO? next;
/// Null at the top tier.
@override final  int? pointsToNext;

/// Create a copy of TierProgress
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TierProgressCopyWith<_TierProgress> get copyWith => __$TierProgressCopyWithImpl<_TierProgress>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TierProgress&&(identical(other.progress, progress) || other.progress == progress)&&(identical(other.current, current) || other.current == current)&&(identical(other.next, next) || other.next == next)&&(identical(other.pointsToNext, pointsToNext) || other.pointsToNext == pointsToNext));
}


@override
int get hashCode {
    return Object.hash(runtimeType,progress,current,next,pointsToNext);
}

@override
String toString() {
    return 'TierProgress(progress: $progress, current: $current, next: $next, pointsToNext: $pointsToNext)';
}


}

/// @nodoc
abstract mixin class _$TierProgressCopyWith<$Res> implements $TierProgressCopyWith<$Res> {
  factory _$TierProgressCopyWith(_TierProgress value, $Res Function(_TierProgress) _then) = __$TierProgressCopyWithImpl;
@override @useResult
$Res call({
 double progress, TierVO? current, TierVO? next, int? pointsToNext
});


@override $TierVOCopyWith<$Res>? get current;@override $TierVOCopyWith<$Res>? get next;

}
/// @nodoc
class __$TierProgressCopyWithImpl<$Res>
    implements _$TierProgressCopyWith<$Res> {
  __$TierProgressCopyWithImpl(this._self, this._then);

  final _TierProgress _self;
  final $Res Function(_TierProgress) _then;

/// Create a copy of TierProgress
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? progress = null,Object? current = freezed,Object? next = freezed,Object? pointsToNext = freezed,}) {
  return _then(_TierProgress(
progress: null == progress ? _self.progress : progress // ignore: cast_nullable_to_non_nullable
as double,current: freezed == current ? _self.current : current // ignore: cast_nullable_to_non_nullable
as TierVO?,next: freezed == next ? _self.next : next // ignore: cast_nullable_to_non_nullable
as TierVO?,pointsToNext: freezed == pointsToNext ? _self.pointsToNext : pointsToNext // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

/// Create a copy of TierProgress
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TierVOCopyWith<$Res>? get current {
    if (_self.current == null) {
    return null;
  }

  return $TierVOCopyWith<$Res>(_self.current!, (value) {
    return _then(_self.copyWith(current: value));
  });
}/// Create a copy of TierProgress
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TierVOCopyWith<$Res>? get next {
    if (_self.next == null) {
    return null;
  }

  return $TierVOCopyWith<$Res>(_self.next!, (value) {
    return _then(_self.copyWith(next: value));
  });
}
}

// dart format on
