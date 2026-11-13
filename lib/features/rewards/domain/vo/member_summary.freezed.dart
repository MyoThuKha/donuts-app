// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'member_summary.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MemberSummary {

 int get totalPoints; String get avatarUrl; int get notificationCount; int get rewardsCount;/// Sorted by `minPoints`.
 List<TierVO> get tiers; TierProgress get tierProgress; String? get avatarAsset;
/// Create a copy of MemberSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MemberSummaryCopyWith<MemberSummary> get copyWith => _$MemberSummaryCopyWithImpl<MemberSummary>(this as MemberSummary, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as MemberSummary;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MemberSummary&&(identical(other.totalPoints, _this.totalPoints) || other.totalPoints == _this.totalPoints)&&(identical(other.avatarUrl, _this.avatarUrl) || other.avatarUrl == _this.avatarUrl)&&(identical(other.notificationCount, _this.notificationCount) || other.notificationCount == _this.notificationCount)&&(identical(other.rewardsCount, _this.rewardsCount) || other.rewardsCount == _this.rewardsCount)&&const DeepCollectionEquality().equals(other.tiers, _this.tiers)&&(identical(other.tierProgress, _this.tierProgress) || other.tierProgress == _this.tierProgress)&&(identical(other.avatarAsset, _this.avatarAsset) || other.avatarAsset == _this.avatarAsset));
}


@override
int get hashCode {
  final _this = this as MemberSummary;
  return Object.hash(runtimeType,_this.totalPoints,_this.avatarUrl,_this.notificationCount,_this.rewardsCount,const DeepCollectionEquality().hash(_this.tiers),_this.tierProgress,_this.avatarAsset);
}

@override
String toString() {
  final _this = this as MemberSummary;
  return 'MemberSummary(totalPoints: ${_this.totalPoints}, avatarUrl: ${_this.avatarUrl}, notificationCount: ${_this.notificationCount}, rewardsCount: ${_this.rewardsCount}, tiers: ${_this.tiers}, tierProgress: ${_this.tierProgress}, avatarAsset: ${_this.avatarAsset})';
}


}

/// @nodoc
abstract mixin class $MemberSummaryCopyWith<$Res>  {
  factory $MemberSummaryCopyWith(MemberSummary value, $Res Function(MemberSummary) _then) = _$MemberSummaryCopyWithImpl;
@useResult
$Res call({
 int totalPoints, String avatarUrl, int notificationCount, int rewardsCount, List<TierVO> tiers, TierProgress tierProgress, String? avatarAsset
});


$TierProgressCopyWith<$Res> get tierProgress;

}
/// @nodoc
class _$MemberSummaryCopyWithImpl<$Res>
    implements $MemberSummaryCopyWith<$Res> {
  _$MemberSummaryCopyWithImpl(this._self, this._then);

  final MemberSummary _self;
  final $Res Function(MemberSummary) _then;

/// Create a copy of MemberSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? totalPoints = null,Object? avatarUrl = null,Object? notificationCount = null,Object? rewardsCount = null,Object? tiers = null,Object? tierProgress = null,Object? avatarAsset = freezed,}) {
  return _then(MemberSummary(
totalPoints: null == totalPoints ? _self.totalPoints : totalPoints // ignore: cast_nullable_to_non_nullable
as int,avatarUrl: null == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String,notificationCount: null == notificationCount ? _self.notificationCount : notificationCount // ignore: cast_nullable_to_non_nullable
as int,rewardsCount: null == rewardsCount ? _self.rewardsCount : rewardsCount // ignore: cast_nullable_to_non_nullable
as int,tiers: null == tiers ? _self.tiers : tiers // ignore: cast_nullable_to_non_nullable
as List<TierVO>,tierProgress: null == tierProgress ? _self.tierProgress : tierProgress // ignore: cast_nullable_to_non_nullable
as TierProgress,avatarAsset: freezed == avatarAsset ? _self.avatarAsset : avatarAsset // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of MemberSummary
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TierProgressCopyWith<$Res> get tierProgress {
  
  return $TierProgressCopyWith<$Res>(_self.tierProgress, (value) {
    return _then(_self.copyWith(tierProgress: value));
  });
}
}


/// Adds pattern-matching-related methods to [MemberSummary].
extension MemberSummaryPatterns on MemberSummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MemberSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MemberSummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MemberSummary value)  $default,){
final _that = this;
switch (_that) {
case _MemberSummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MemberSummary value)?  $default,){
final _that = this;
switch (_that) {
case _MemberSummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int totalPoints,  String avatarUrl,  int notificationCount,  int rewardsCount,  List<TierVO> tiers,  TierProgress tierProgress,  String? avatarAsset)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MemberSummary() when $default != null:
return $default(_that.totalPoints,_that.avatarUrl,_that.notificationCount,_that.rewardsCount,_that.tiers,_that.tierProgress,_that.avatarAsset);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int totalPoints,  String avatarUrl,  int notificationCount,  int rewardsCount,  List<TierVO> tiers,  TierProgress tierProgress,  String? avatarAsset)  $default,) {final _that = this;
switch (_that) {
case _MemberSummary():
return $default(_that.totalPoints,_that.avatarUrl,_that.notificationCount,_that.rewardsCount,_that.tiers,_that.tierProgress,_that.avatarAsset);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int totalPoints,  String avatarUrl,  int notificationCount,  int rewardsCount,  List<TierVO> tiers,  TierProgress tierProgress,  String? avatarAsset)?  $default,) {final _that = this;
switch (_that) {
case _MemberSummary() when $default != null:
return $default(_that.totalPoints,_that.avatarUrl,_that.notificationCount,_that.rewardsCount,_that.tiers,_that.tierProgress,_that.avatarAsset);case _:
  return null;

}
}

}

/// @nodoc


class _MemberSummary implements MemberSummary {
  const _MemberSummary({required this.totalPoints, required this.avatarUrl, required this.notificationCount, required this.rewardsCount, required  List<TierVO> tiers, required this.tierProgress, this.avatarAsset}): _tiers = tiers;
  

@override final  int totalPoints;
@override final  String avatarUrl;
@override final  int notificationCount;
@override final  int rewardsCount;
/// Sorted by `minPoints`.
 final  List<TierVO> _tiers;
/// Sorted by `minPoints`.
@override List<TierVO> get tiers {
  if (_tiers is EqualUnmodifiableListView) return _tiers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tiers);
}

@override final  TierProgress tierProgress;
@override final  String? avatarAsset;

/// Create a copy of MemberSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MemberSummaryCopyWith<_MemberSummary> get copyWith => __$MemberSummaryCopyWithImpl<_MemberSummary>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _MemberSummary&&(identical(other.totalPoints, totalPoints) || other.totalPoints == totalPoints)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.notificationCount, notificationCount) || other.notificationCount == notificationCount)&&(identical(other.rewardsCount, rewardsCount) || other.rewardsCount == rewardsCount)&&const DeepCollectionEquality().equals(other.tiers, _tiers)&&(identical(other.tierProgress, tierProgress) || other.tierProgress == tierProgress)&&(identical(other.avatarAsset, avatarAsset) || other.avatarAsset == avatarAsset));
}


@override
int get hashCode {
    return Object.hash(runtimeType,totalPoints,avatarUrl,notificationCount,rewardsCount,const DeepCollectionEquality().hash(_tiers),tierProgress,avatarAsset);
}

@override
String toString() {
    return 'MemberSummary(totalPoints: $totalPoints, avatarUrl: $avatarUrl, notificationCount: $notificationCount, rewardsCount: $rewardsCount, tiers: $tiers, tierProgress: $tierProgress, avatarAsset: $avatarAsset)';
}


}

/// @nodoc
abstract mixin class _$MemberSummaryCopyWith<$Res> implements $MemberSummaryCopyWith<$Res> {
  factory _$MemberSummaryCopyWith(_MemberSummary value, $Res Function(_MemberSummary) _then) = __$MemberSummaryCopyWithImpl;
@override @useResult
$Res call({
 int totalPoints, String avatarUrl, int notificationCount, int rewardsCount, List<TierVO> tiers, TierProgress tierProgress, String? avatarAsset
});


@override $TierProgressCopyWith<$Res> get tierProgress;

}
/// @nodoc
class __$MemberSummaryCopyWithImpl<$Res>
    implements _$MemberSummaryCopyWith<$Res> {
  __$MemberSummaryCopyWithImpl(this._self, this._then);

  final _MemberSummary _self;
  final $Res Function(_MemberSummary) _then;

/// Create a copy of MemberSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? totalPoints = null,Object? avatarUrl = null,Object? notificationCount = null,Object? rewardsCount = null,Object? tiers = null,Object? tierProgress = null,Object? avatarAsset = freezed,}) {
  return _then(_MemberSummary(
totalPoints: null == totalPoints ? _self.totalPoints : totalPoints // ignore: cast_nullable_to_non_nullable
as int,avatarUrl: null == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String,notificationCount: null == notificationCount ? _self.notificationCount : notificationCount // ignore: cast_nullable_to_non_nullable
as int,rewardsCount: null == rewardsCount ? _self.rewardsCount : rewardsCount // ignore: cast_nullable_to_non_nullable
as int,tiers: null == tiers ? _self._tiers : tiers // ignore: cast_nullable_to_non_nullable
as List<TierVO>,tierProgress: null == tierProgress ? _self.tierProgress : tierProgress // ignore: cast_nullable_to_non_nullable
as TierProgress,avatarAsset: freezed == avatarAsset ? _self.avatarAsset : avatarAsset // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of MemberSummary
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TierProgressCopyWith<$Res> get tierProgress {
  
  return $TierProgressCopyWith<$Res>(_self.tierProgress, (value) {
    return _then(_self.copyWith(tierProgress: value));
  });
}
}

// dart format on
