// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MemberSeedDto _$MemberSeedDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_MemberSeedDto', json, ($checkedConvert) {
      final val = _MemberSeedDto(
        profile: $checkedConvert(
          'profile',
          (v) => MemberProfileDto.fromJson(v as Map<String, dynamic>),
        ),
        tiers: $checkedConvert(
          'tiers',
          (v) => (v as List<dynamic>)
              .map((e) => TierDto.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
        challenges: $checkedConvert(
          'challenges',
          (v) => (v as List<dynamic>)
              .map((e) => ChallengeDto.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
      );
      return val;
    });

Map<String, dynamic> _$MemberSeedDtoToJson(_MemberSeedDto instance) =>
    <String, dynamic>{
      'profile': instance.profile.toJson(),
      'tiers': instance.tiers.map((e) => e.toJson()).toList(),
      'challenges': instance.challenges.map((e) => e.toJson()).toList(),
    };

_MemberProfileDto _$MemberProfileDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_MemberProfileDto', json, ($checkedConvert) {
      final val = _MemberProfileDto(
        totalPoints: $checkedConvert('totalPoints', (v) => (v as num).toInt()),
        avatarUrl: $checkedConvert('avatarUrl', (v) => v as String),
        notificationCount: $checkedConvert(
          'notificationCount',
          (v) => (v as num).toInt(),
        ),
        rewardsCount: $checkedConvert(
          'rewardsCount',
          (v) => (v as num).toInt(),
        ),
        avatarAsset: $checkedConvert('avatarAsset', (v) => v as String?),
      );
      return val;
    });

Map<String, dynamic> _$MemberProfileDtoToJson(_MemberProfileDto instance) =>
    <String, dynamic>{
      'totalPoints': instance.totalPoints,
      'avatarUrl': instance.avatarUrl,
      'notificationCount': instance.notificationCount,
      'rewardsCount': instance.rewardsCount,
      'avatarAsset': instance.avatarAsset,
    };

_TierDto _$TierDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_TierDto', json, ($checkedConvert) {
      final val = _TierDto(
        id: $checkedConvert('id', (v) => v as String),
        name: $checkedConvert('name', (v) => v as String),
        minPoints: $checkedConvert('minPoints', (v) => (v as num).toInt()),
        sortOrder: $checkedConvert('sortOrder', (v) => (v as num).toInt()),
        imageUrl: $checkedConvert('imageUrl', (v) => v as String?),
        imageAsset: $checkedConvert('imageAsset', (v) => v as String?),
      );
      return val;
    });

Map<String, dynamic> _$TierDtoToJson(_TierDto instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'minPoints': instance.minPoints,
  'sortOrder': instance.sortOrder,
  'imageUrl': instance.imageUrl,
  'imageAsset': instance.imageAsset,
};

_ChallengeDto _$ChallengeDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_ChallengeDto', json, ($checkedConvert) {
      final val = _ChallengeDto(
        id: $checkedConvert('id', (v) => v as String),
        title: $checkedConvert('title', (v) => v as String),
        kind: $checkedConvert(
          'kind',
          (v) => $enumDecode(_$ChallengeKindDtoEnumMap, v),
        ),
        progress: $checkedConvert('progress', (v) => (v as num).toInt()),
        target: $checkedConvert('target', (v) => (v as num).toInt()),
        rewardPoints: $checkedConvert(
          'rewardPoints',
          (v) => (v as num).toInt(),
        ),
        sortOrder: $checkedConvert('sortOrder', (v) => (v as num).toInt()),
        imageUrl: $checkedConvert('imageUrl', (v) => v as String?),
        imageAsset: $checkedConvert('imageAsset', (v) => v as String?),
      );
      return val;
    });

Map<String, dynamic> _$ChallengeDtoToJson(_ChallengeDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'kind': _$ChallengeKindDtoEnumMap[instance.kind]!,
      'progress': instance.progress,
      'target': instance.target,
      'rewardPoints': instance.rewardPoints,
      'sortOrder': instance.sortOrder,
      'imageUrl': instance.imageUrl,
      'imageAsset': instance.imageAsset,
    };

const _$ChallengeKindDtoEnumMap = {
  ChallengeKindDto.donutQuarters: 'donutQuarters',
  ChallengeKindDto.coffeeArc: 'coffeeArc',
};
