// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'member_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MemberSeedDto {

 MemberProfileDto get profile; List<TierDto> get tiers; List<ChallengeDto> get challenges; List<GiftDto> get gifts;
/// Create a copy of MemberSeedDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MemberSeedDtoCopyWith<MemberSeedDto> get copyWith => _$MemberSeedDtoCopyWithImpl<MemberSeedDto>(this as MemberSeedDto, _$identity);

  /// Serializes this MemberSeedDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as MemberSeedDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MemberSeedDto&&(identical(other.profile, _this.profile) || other.profile == _this.profile)&&const DeepCollectionEquality().equals(other.tiers, _this.tiers)&&const DeepCollectionEquality().equals(other.challenges, _this.challenges)&&const DeepCollectionEquality().equals(other.gifts, _this.gifts));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as MemberSeedDto;
  return Object.hash(runtimeType,_this.profile,const DeepCollectionEquality().hash(_this.tiers),const DeepCollectionEquality().hash(_this.challenges),const DeepCollectionEquality().hash(_this.gifts));
}

@override
String toString() {
  final _this = this as MemberSeedDto;
  return 'MemberSeedDto(profile: ${_this.profile}, tiers: ${_this.tiers}, challenges: ${_this.challenges}, gifts: ${_this.gifts})';
}


}

/// @nodoc
abstract mixin class $MemberSeedDtoCopyWith<$Res>  {
  factory $MemberSeedDtoCopyWith(MemberSeedDto value, $Res Function(MemberSeedDto) _then) = _$MemberSeedDtoCopyWithImpl;
@useResult
$Res call({
 MemberProfileDto profile, List<TierDto> tiers, List<ChallengeDto> challenges, List<GiftDto> gifts
});


$MemberProfileDtoCopyWith<$Res> get profile;

}
/// @nodoc
class _$MemberSeedDtoCopyWithImpl<$Res>
    implements $MemberSeedDtoCopyWith<$Res> {
  _$MemberSeedDtoCopyWithImpl(this._self, this._then);

  final MemberSeedDto _self;
  final $Res Function(MemberSeedDto) _then;

/// Create a copy of MemberSeedDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? profile = null,Object? tiers = null,Object? challenges = null,Object? gifts = null,}) {
  return _then(MemberSeedDto(
profile: null == profile ? _self.profile : profile // ignore: cast_nullable_to_non_nullable
as MemberProfileDto,tiers: null == tiers ? _self.tiers : tiers // ignore: cast_nullable_to_non_nullable
as List<TierDto>,challenges: null == challenges ? _self.challenges : challenges // ignore: cast_nullable_to_non_nullable
as List<ChallengeDto>,gifts: null == gifts ? _self.gifts : gifts // ignore: cast_nullable_to_non_nullable
as List<GiftDto>,
  ));
}
/// Create a copy of MemberSeedDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MemberProfileDtoCopyWith<$Res> get profile {
  
  return $MemberProfileDtoCopyWith<$Res>(_self.profile, (value) {
    return _then(_self.copyWith(profile: value));
  });
}
}


/// Adds pattern-matching-related methods to [MemberSeedDto].
extension MemberSeedDtoPatterns on MemberSeedDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MemberSeedDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MemberSeedDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MemberSeedDto value)  $default,){
final _that = this;
switch (_that) {
case _MemberSeedDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MemberSeedDto value)?  $default,){
final _that = this;
switch (_that) {
case _MemberSeedDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( MemberProfileDto profile,  List<TierDto> tiers,  List<ChallengeDto> challenges,  List<GiftDto> gifts)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MemberSeedDto() when $default != null:
return $default(_that.profile,_that.tiers,_that.challenges,_that.gifts);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( MemberProfileDto profile,  List<TierDto> tiers,  List<ChallengeDto> challenges,  List<GiftDto> gifts)  $default,) {final _that = this;
switch (_that) {
case _MemberSeedDto():
return $default(_that.profile,_that.tiers,_that.challenges,_that.gifts);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( MemberProfileDto profile,  List<TierDto> tiers,  List<ChallengeDto> challenges,  List<GiftDto> gifts)?  $default,) {final _that = this;
switch (_that) {
case _MemberSeedDto() when $default != null:
return $default(_that.profile,_that.tiers,_that.challenges,_that.gifts);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MemberSeedDto implements MemberSeedDto {
  const _MemberSeedDto({required this.profile, required  List<TierDto> tiers, required  List<ChallengeDto> challenges, required  List<GiftDto> gifts}): _tiers = tiers,_challenges = challenges,_gifts = gifts;
  factory _MemberSeedDto.fromJson(Map<String, dynamic> json) => _$MemberSeedDtoFromJson(json);

@override final  MemberProfileDto profile;
 final  List<TierDto> _tiers;
@override List<TierDto> get tiers {
  if (_tiers is EqualUnmodifiableListView) return _tiers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tiers);
}

 final  List<ChallengeDto> _challenges;
@override List<ChallengeDto> get challenges {
  if (_challenges is EqualUnmodifiableListView) return _challenges;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_challenges);
}

 final  List<GiftDto> _gifts;
@override List<GiftDto> get gifts {
  if (_gifts is EqualUnmodifiableListView) return _gifts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_gifts);
}


/// Create a copy of MemberSeedDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MemberSeedDtoCopyWith<_MemberSeedDto> get copyWith => __$MemberSeedDtoCopyWithImpl<_MemberSeedDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MemberSeedDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _MemberSeedDto&&(identical(other.profile, profile) || other.profile == profile)&&const DeepCollectionEquality().equals(other.tiers, _tiers)&&const DeepCollectionEquality().equals(other.challenges, _challenges)&&const DeepCollectionEquality().equals(other.gifts, _gifts));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,profile,const DeepCollectionEquality().hash(_tiers),const DeepCollectionEquality().hash(_challenges),const DeepCollectionEquality().hash(_gifts));
}

@override
String toString() {
    return 'MemberSeedDto(profile: $profile, tiers: $tiers, challenges: $challenges, gifts: $gifts)';
}


}

/// @nodoc
abstract mixin class _$MemberSeedDtoCopyWith<$Res> implements $MemberSeedDtoCopyWith<$Res> {
  factory _$MemberSeedDtoCopyWith(_MemberSeedDto value, $Res Function(_MemberSeedDto) _then) = __$MemberSeedDtoCopyWithImpl;
@override @useResult
$Res call({
 MemberProfileDto profile, List<TierDto> tiers, List<ChallengeDto> challenges, List<GiftDto> gifts
});


@override $MemberProfileDtoCopyWith<$Res> get profile;

}
/// @nodoc
class __$MemberSeedDtoCopyWithImpl<$Res>
    implements _$MemberSeedDtoCopyWith<$Res> {
  __$MemberSeedDtoCopyWithImpl(this._self, this._then);

  final _MemberSeedDto _self;
  final $Res Function(_MemberSeedDto) _then;

/// Create a copy of MemberSeedDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? profile = null,Object? tiers = null,Object? challenges = null,Object? gifts = null,}) {
  return _then(_MemberSeedDto(
profile: null == profile ? _self.profile : profile // ignore: cast_nullable_to_non_nullable
as MemberProfileDto,tiers: null == tiers ? _self._tiers : tiers // ignore: cast_nullable_to_non_nullable
as List<TierDto>,challenges: null == challenges ? _self._challenges : challenges // ignore: cast_nullable_to_non_nullable
as List<ChallengeDto>,gifts: null == gifts ? _self._gifts : gifts // ignore: cast_nullable_to_non_nullable
as List<GiftDto>,
  ));
}

/// Create a copy of MemberSeedDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MemberProfileDtoCopyWith<$Res> get profile {
  
  return $MemberProfileDtoCopyWith<$Res>(_self.profile, (value) {
    return _then(_self.copyWith(profile: value));
  });
}
}


/// @nodoc
mixin _$MemberProfileDto {

 int get totalPoints; String get avatarUrl; int get notificationCount; int get rewardsCount; String? get avatarAsset;
/// Create a copy of MemberProfileDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MemberProfileDtoCopyWith<MemberProfileDto> get copyWith => _$MemberProfileDtoCopyWithImpl<MemberProfileDto>(this as MemberProfileDto, _$identity);

  /// Serializes this MemberProfileDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as MemberProfileDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MemberProfileDto&&(identical(other.totalPoints, _this.totalPoints) || other.totalPoints == _this.totalPoints)&&(identical(other.avatarUrl, _this.avatarUrl) || other.avatarUrl == _this.avatarUrl)&&(identical(other.notificationCount, _this.notificationCount) || other.notificationCount == _this.notificationCount)&&(identical(other.rewardsCount, _this.rewardsCount) || other.rewardsCount == _this.rewardsCount)&&(identical(other.avatarAsset, _this.avatarAsset) || other.avatarAsset == _this.avatarAsset));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as MemberProfileDto;
  return Object.hash(runtimeType,_this.totalPoints,_this.avatarUrl,_this.notificationCount,_this.rewardsCount,_this.avatarAsset);
}

@override
String toString() {
  final _this = this as MemberProfileDto;
  return 'MemberProfileDto(totalPoints: ${_this.totalPoints}, avatarUrl: ${_this.avatarUrl}, notificationCount: ${_this.notificationCount}, rewardsCount: ${_this.rewardsCount}, avatarAsset: ${_this.avatarAsset})';
}


}

/// @nodoc
abstract mixin class $MemberProfileDtoCopyWith<$Res>  {
  factory $MemberProfileDtoCopyWith(MemberProfileDto value, $Res Function(MemberProfileDto) _then) = _$MemberProfileDtoCopyWithImpl;
@useResult
$Res call({
 int totalPoints, String avatarUrl, int notificationCount, int rewardsCount, String? avatarAsset
});




}
/// @nodoc
class _$MemberProfileDtoCopyWithImpl<$Res>
    implements $MemberProfileDtoCopyWith<$Res> {
  _$MemberProfileDtoCopyWithImpl(this._self, this._then);

  final MemberProfileDto _self;
  final $Res Function(MemberProfileDto) _then;

/// Create a copy of MemberProfileDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? totalPoints = null,Object? avatarUrl = null,Object? notificationCount = null,Object? rewardsCount = null,Object? avatarAsset = freezed,}) {
  return _then(MemberProfileDto(
totalPoints: null == totalPoints ? _self.totalPoints : totalPoints // ignore: cast_nullable_to_non_nullable
as int,avatarUrl: null == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String,notificationCount: null == notificationCount ? _self.notificationCount : notificationCount // ignore: cast_nullable_to_non_nullable
as int,rewardsCount: null == rewardsCount ? _self.rewardsCount : rewardsCount // ignore: cast_nullable_to_non_nullable
as int,avatarAsset: freezed == avatarAsset ? _self.avatarAsset : avatarAsset // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [MemberProfileDto].
extension MemberProfileDtoPatterns on MemberProfileDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MemberProfileDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MemberProfileDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MemberProfileDto value)  $default,){
final _that = this;
switch (_that) {
case _MemberProfileDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MemberProfileDto value)?  $default,){
final _that = this;
switch (_that) {
case _MemberProfileDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int totalPoints,  String avatarUrl,  int notificationCount,  int rewardsCount,  String? avatarAsset)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MemberProfileDto() when $default != null:
return $default(_that.totalPoints,_that.avatarUrl,_that.notificationCount,_that.rewardsCount,_that.avatarAsset);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int totalPoints,  String avatarUrl,  int notificationCount,  int rewardsCount,  String? avatarAsset)  $default,) {final _that = this;
switch (_that) {
case _MemberProfileDto():
return $default(_that.totalPoints,_that.avatarUrl,_that.notificationCount,_that.rewardsCount,_that.avatarAsset);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int totalPoints,  String avatarUrl,  int notificationCount,  int rewardsCount,  String? avatarAsset)?  $default,) {final _that = this;
switch (_that) {
case _MemberProfileDto() when $default != null:
return $default(_that.totalPoints,_that.avatarUrl,_that.notificationCount,_that.rewardsCount,_that.avatarAsset);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MemberProfileDto implements MemberProfileDto {
  const _MemberProfileDto({required this.totalPoints, required this.avatarUrl, required this.notificationCount, required this.rewardsCount, this.avatarAsset});
  factory _MemberProfileDto.fromJson(Map<String, dynamic> json) => _$MemberProfileDtoFromJson(json);

@override final  int totalPoints;
@override final  String avatarUrl;
@override final  int notificationCount;
@override final  int rewardsCount;
@override final  String? avatarAsset;

/// Create a copy of MemberProfileDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MemberProfileDtoCopyWith<_MemberProfileDto> get copyWith => __$MemberProfileDtoCopyWithImpl<_MemberProfileDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MemberProfileDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _MemberProfileDto&&(identical(other.totalPoints, totalPoints) || other.totalPoints == totalPoints)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.notificationCount, notificationCount) || other.notificationCount == notificationCount)&&(identical(other.rewardsCount, rewardsCount) || other.rewardsCount == rewardsCount)&&(identical(other.avatarAsset, avatarAsset) || other.avatarAsset == avatarAsset));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,totalPoints,avatarUrl,notificationCount,rewardsCount,avatarAsset);
}

@override
String toString() {
    return 'MemberProfileDto(totalPoints: $totalPoints, avatarUrl: $avatarUrl, notificationCount: $notificationCount, rewardsCount: $rewardsCount, avatarAsset: $avatarAsset)';
}


}

/// @nodoc
abstract mixin class _$MemberProfileDtoCopyWith<$Res> implements $MemberProfileDtoCopyWith<$Res> {
  factory _$MemberProfileDtoCopyWith(_MemberProfileDto value, $Res Function(_MemberProfileDto) _then) = __$MemberProfileDtoCopyWithImpl;
@override @useResult
$Res call({
 int totalPoints, String avatarUrl, int notificationCount, int rewardsCount, String? avatarAsset
});




}
/// @nodoc
class __$MemberProfileDtoCopyWithImpl<$Res>
    implements _$MemberProfileDtoCopyWith<$Res> {
  __$MemberProfileDtoCopyWithImpl(this._self, this._then);

  final _MemberProfileDto _self;
  final $Res Function(_MemberProfileDto) _then;

/// Create a copy of MemberProfileDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? totalPoints = null,Object? avatarUrl = null,Object? notificationCount = null,Object? rewardsCount = null,Object? avatarAsset = freezed,}) {
  return _then(_MemberProfileDto(
totalPoints: null == totalPoints ? _self.totalPoints : totalPoints // ignore: cast_nullable_to_non_nullable
as int,avatarUrl: null == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String,notificationCount: null == notificationCount ? _self.notificationCount : notificationCount // ignore: cast_nullable_to_non_nullable
as int,rewardsCount: null == rewardsCount ? _self.rewardsCount : rewardsCount // ignore: cast_nullable_to_non_nullable
as int,avatarAsset: freezed == avatarAsset ? _self.avatarAsset : avatarAsset // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$TierDto {

 String get id; String get name; int get minPoints; int get sortOrder;
/// Create a copy of TierDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TierDtoCopyWith<TierDto> get copyWith => _$TierDtoCopyWithImpl<TierDto>(this as TierDto, _$identity);

  /// Serializes this TierDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TierDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TierDto&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.minPoints, _this.minPoints) || other.minPoints == _this.minPoints)&&(identical(other.sortOrder, _this.sortOrder) || other.sortOrder == _this.sortOrder));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TierDto;
  return Object.hash(runtimeType,_this.id,_this.name,_this.minPoints,_this.sortOrder);
}

@override
String toString() {
  final _this = this as TierDto;
  return 'TierDto(id: ${_this.id}, name: ${_this.name}, minPoints: ${_this.minPoints}, sortOrder: ${_this.sortOrder})';
}


}

/// @nodoc
abstract mixin class $TierDtoCopyWith<$Res>  {
  factory $TierDtoCopyWith(TierDto value, $Res Function(TierDto) _then) = _$TierDtoCopyWithImpl;
@useResult
$Res call({
 String id, String name, int minPoints, int sortOrder
});




}
/// @nodoc
class _$TierDtoCopyWithImpl<$Res>
    implements $TierDtoCopyWith<$Res> {
  _$TierDtoCopyWithImpl(this._self, this._then);

  final TierDto _self;
  final $Res Function(TierDto) _then;

/// Create a copy of TierDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? minPoints = null,Object? sortOrder = null,}) {
  return _then(TierDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,minPoints: null == minPoints ? _self.minPoints : minPoints // ignore: cast_nullable_to_non_nullable
as int,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [TierDto].
extension TierDtoPatterns on TierDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TierDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TierDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TierDto value)  $default,){
final _that = this;
switch (_that) {
case _TierDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TierDto value)?  $default,){
final _that = this;
switch (_that) {
case _TierDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  int minPoints,  int sortOrder)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TierDto() when $default != null:
return $default(_that.id,_that.name,_that.minPoints,_that.sortOrder);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  int minPoints,  int sortOrder)  $default,) {final _that = this;
switch (_that) {
case _TierDto():
return $default(_that.id,_that.name,_that.minPoints,_that.sortOrder);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  int minPoints,  int sortOrder)?  $default,) {final _that = this;
switch (_that) {
case _TierDto() when $default != null:
return $default(_that.id,_that.name,_that.minPoints,_that.sortOrder);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TierDto implements TierDto {
  const _TierDto({required this.id, required this.name, required this.minPoints, required this.sortOrder});
  factory _TierDto.fromJson(Map<String, dynamic> json) => _$TierDtoFromJson(json);

@override final  String id;
@override final  String name;
@override final  int minPoints;
@override final  int sortOrder;

/// Create a copy of TierDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TierDtoCopyWith<_TierDto> get copyWith => __$TierDtoCopyWithImpl<_TierDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TierDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TierDto&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.minPoints, minPoints) || other.minPoints == minPoints)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,name,minPoints,sortOrder);
}

@override
String toString() {
    return 'TierDto(id: $id, name: $name, minPoints: $minPoints, sortOrder: $sortOrder)';
}


}

/// @nodoc
abstract mixin class _$TierDtoCopyWith<$Res> implements $TierDtoCopyWith<$Res> {
  factory _$TierDtoCopyWith(_TierDto value, $Res Function(_TierDto) _then) = __$TierDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, int minPoints, int sortOrder
});




}
/// @nodoc
class __$TierDtoCopyWithImpl<$Res>
    implements _$TierDtoCopyWith<$Res> {
  __$TierDtoCopyWithImpl(this._self, this._then);

  final _TierDto _self;
  final $Res Function(_TierDto) _then;

/// Create a copy of TierDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? minPoints = null,Object? sortOrder = null,}) {
  return _then(_TierDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,minPoints: null == minPoints ? _self.minPoints : minPoints // ignore: cast_nullable_to_non_nullable
as int,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$ChallengeDto {

 String get id; String get title; ChallengeKindDto get kind; int get progress; int get target; int get rewardPoints; int get sortOrder; String? get imageAsset;
/// Create a copy of ChallengeDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChallengeDtoCopyWith<ChallengeDto> get copyWith => _$ChallengeDtoCopyWithImpl<ChallengeDto>(this as ChallengeDto, _$identity);

  /// Serializes this ChallengeDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ChallengeDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChallengeDto&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.kind, _this.kind) || other.kind == _this.kind)&&(identical(other.progress, _this.progress) || other.progress == _this.progress)&&(identical(other.target, _this.target) || other.target == _this.target)&&(identical(other.rewardPoints, _this.rewardPoints) || other.rewardPoints == _this.rewardPoints)&&(identical(other.sortOrder, _this.sortOrder) || other.sortOrder == _this.sortOrder)&&(identical(other.imageAsset, _this.imageAsset) || other.imageAsset == _this.imageAsset));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ChallengeDto;
  return Object.hash(runtimeType,_this.id,_this.title,_this.kind,_this.progress,_this.target,_this.rewardPoints,_this.sortOrder,_this.imageAsset);
}

@override
String toString() {
  final _this = this as ChallengeDto;
  return 'ChallengeDto(id: ${_this.id}, title: ${_this.title}, kind: ${_this.kind}, progress: ${_this.progress}, target: ${_this.target}, rewardPoints: ${_this.rewardPoints}, sortOrder: ${_this.sortOrder}, imageAsset: ${_this.imageAsset})';
}


}

/// @nodoc
abstract mixin class $ChallengeDtoCopyWith<$Res>  {
  factory $ChallengeDtoCopyWith(ChallengeDto value, $Res Function(ChallengeDto) _then) = _$ChallengeDtoCopyWithImpl;
@useResult
$Res call({
 String id, String title, ChallengeKindDto kind, int progress, int target, int rewardPoints, int sortOrder, String? imageAsset
});




}
/// @nodoc
class _$ChallengeDtoCopyWithImpl<$Res>
    implements $ChallengeDtoCopyWith<$Res> {
  _$ChallengeDtoCopyWithImpl(this._self, this._then);

  final ChallengeDto _self;
  final $Res Function(ChallengeDto) _then;

/// Create a copy of ChallengeDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? kind = null,Object? progress = null,Object? target = null,Object? rewardPoints = null,Object? sortOrder = null,Object? imageAsset = freezed,}) {
  return _then(ChallengeDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as ChallengeKindDto,progress: null == progress ? _self.progress : progress // ignore: cast_nullable_to_non_nullable
as int,target: null == target ? _self.target : target // ignore: cast_nullable_to_non_nullable
as int,rewardPoints: null == rewardPoints ? _self.rewardPoints : rewardPoints // ignore: cast_nullable_to_non_nullable
as int,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,imageAsset: freezed == imageAsset ? _self.imageAsset : imageAsset // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ChallengeDto].
extension ChallengeDtoPatterns on ChallengeDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChallengeDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChallengeDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChallengeDto value)  $default,){
final _that = this;
switch (_that) {
case _ChallengeDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChallengeDto value)?  $default,){
final _that = this;
switch (_that) {
case _ChallengeDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  ChallengeKindDto kind,  int progress,  int target,  int rewardPoints,  int sortOrder,  String? imageAsset)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChallengeDto() when $default != null:
return $default(_that.id,_that.title,_that.kind,_that.progress,_that.target,_that.rewardPoints,_that.sortOrder,_that.imageAsset);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  ChallengeKindDto kind,  int progress,  int target,  int rewardPoints,  int sortOrder,  String? imageAsset)  $default,) {final _that = this;
switch (_that) {
case _ChallengeDto():
return $default(_that.id,_that.title,_that.kind,_that.progress,_that.target,_that.rewardPoints,_that.sortOrder,_that.imageAsset);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  ChallengeKindDto kind,  int progress,  int target,  int rewardPoints,  int sortOrder,  String? imageAsset)?  $default,) {final _that = this;
switch (_that) {
case _ChallengeDto() when $default != null:
return $default(_that.id,_that.title,_that.kind,_that.progress,_that.target,_that.rewardPoints,_that.sortOrder,_that.imageAsset);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ChallengeDto implements ChallengeDto {
  const _ChallengeDto({required this.id, required this.title, required this.kind, required this.progress, required this.target, required this.rewardPoints, required this.sortOrder, this.imageAsset});
  factory _ChallengeDto.fromJson(Map<String, dynamic> json) => _$ChallengeDtoFromJson(json);

@override final  String id;
@override final  String title;
@override final  ChallengeKindDto kind;
@override final  int progress;
@override final  int target;
@override final  int rewardPoints;
@override final  int sortOrder;
@override final  String? imageAsset;

/// Create a copy of ChallengeDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChallengeDtoCopyWith<_ChallengeDto> get copyWith => __$ChallengeDtoCopyWithImpl<_ChallengeDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChallengeDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChallengeDto&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.progress, progress) || other.progress == progress)&&(identical(other.target, target) || other.target == target)&&(identical(other.rewardPoints, rewardPoints) || other.rewardPoints == rewardPoints)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder)&&(identical(other.imageAsset, imageAsset) || other.imageAsset == imageAsset));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,title,kind,progress,target,rewardPoints,sortOrder,imageAsset);
}

@override
String toString() {
    return 'ChallengeDto(id: $id, title: $title, kind: $kind, progress: $progress, target: $target, rewardPoints: $rewardPoints, sortOrder: $sortOrder, imageAsset: $imageAsset)';
}


}

/// @nodoc
abstract mixin class _$ChallengeDtoCopyWith<$Res> implements $ChallengeDtoCopyWith<$Res> {
  factory _$ChallengeDtoCopyWith(_ChallengeDto value, $Res Function(_ChallengeDto) _then) = __$ChallengeDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, ChallengeKindDto kind, int progress, int target, int rewardPoints, int sortOrder, String? imageAsset
});




}
/// @nodoc
class __$ChallengeDtoCopyWithImpl<$Res>
    implements _$ChallengeDtoCopyWith<$Res> {
  __$ChallengeDtoCopyWithImpl(this._self, this._then);

  final _ChallengeDto _self;
  final $Res Function(_ChallengeDto) _then;

/// Create a copy of ChallengeDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? kind = null,Object? progress = null,Object? target = null,Object? rewardPoints = null,Object? sortOrder = null,Object? imageAsset = freezed,}) {
  return _then(_ChallengeDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as ChallengeKindDto,progress: null == progress ? _self.progress : progress // ignore: cast_nullable_to_non_nullable
as int,target: null == target ? _self.target : target // ignore: cast_nullable_to_non_nullable
as int,rewardPoints: null == rewardPoints ? _self.rewardPoints : rewardPoints // ignore: cast_nullable_to_non_nullable
as int,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,imageAsset: freezed == imageAsset ? _self.imageAsset : imageAsset // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$GiftDto {

 String get id; String get title; int get costPoints; int get sortOrder; String? get imageAsset;
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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GiftDto&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.costPoints, _this.costPoints) || other.costPoints == _this.costPoints)&&(identical(other.sortOrder, _this.sortOrder) || other.sortOrder == _this.sortOrder)&&(identical(other.imageAsset, _this.imageAsset) || other.imageAsset == _this.imageAsset));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as GiftDto;
  return Object.hash(runtimeType,_this.id,_this.title,_this.costPoints,_this.sortOrder,_this.imageAsset);
}

@override
String toString() {
  final _this = this as GiftDto;
  return 'GiftDto(id: ${_this.id}, title: ${_this.title}, costPoints: ${_this.costPoints}, sortOrder: ${_this.sortOrder}, imageAsset: ${_this.imageAsset})';
}


}

/// @nodoc
abstract mixin class $GiftDtoCopyWith<$Res>  {
  factory $GiftDtoCopyWith(GiftDto value, $Res Function(GiftDto) _then) = _$GiftDtoCopyWithImpl;
@useResult
$Res call({
 String id, String title, int costPoints, int sortOrder, String? imageAsset
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
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? costPoints = null,Object? sortOrder = null,Object? imageAsset = freezed,}) {
  return _then(GiftDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,costPoints: null == costPoints ? _self.costPoints : costPoints // ignore: cast_nullable_to_non_nullable
as int,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,imageAsset: freezed == imageAsset ? _self.imageAsset : imageAsset // ignore: cast_nullable_to_non_nullable
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  int costPoints,  int sortOrder,  String? imageAsset)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GiftDto() when $default != null:
return $default(_that.id,_that.title,_that.costPoints,_that.sortOrder,_that.imageAsset);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  int costPoints,  int sortOrder,  String? imageAsset)  $default,) {final _that = this;
switch (_that) {
case _GiftDto():
return $default(_that.id,_that.title,_that.costPoints,_that.sortOrder,_that.imageAsset);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  int costPoints,  int sortOrder,  String? imageAsset)?  $default,) {final _that = this;
switch (_that) {
case _GiftDto() when $default != null:
return $default(_that.id,_that.title,_that.costPoints,_that.sortOrder,_that.imageAsset);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GiftDto implements GiftDto {
  const _GiftDto({required this.id, required this.title, required this.costPoints, required this.sortOrder, this.imageAsset});
  factory _GiftDto.fromJson(Map<String, dynamic> json) => _$GiftDtoFromJson(json);

@override final  String id;
@override final  String title;
@override final  int costPoints;
@override final  int sortOrder;
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
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _GiftDto&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.costPoints, costPoints) || other.costPoints == costPoints)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder)&&(identical(other.imageAsset, imageAsset) || other.imageAsset == imageAsset));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,title,costPoints,sortOrder,imageAsset);
}

@override
String toString() {
    return 'GiftDto(id: $id, title: $title, costPoints: $costPoints, sortOrder: $sortOrder, imageAsset: $imageAsset)';
}


}

/// @nodoc
abstract mixin class _$GiftDtoCopyWith<$Res> implements $GiftDtoCopyWith<$Res> {
  factory _$GiftDtoCopyWith(_GiftDto value, $Res Function(_GiftDto) _then) = __$GiftDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, int costPoints, int sortOrder, String? imageAsset
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
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? costPoints = null,Object? sortOrder = null,Object? imageAsset = freezed,}) {
  return _then(_GiftDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,costPoints: null == costPoints ? _self.costPoints : costPoints // ignore: cast_nullable_to_non_nullable
as int,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,imageAsset: freezed == imageAsset ? _self.imageAsset : imageAsset // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
