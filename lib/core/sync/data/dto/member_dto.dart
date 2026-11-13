// Freezed's redirecting factory must keep the class name.
// ignore_for_file: unnecessary_type_name_in_constructor
import 'package:freezed_annotation/freezed_annotation.dart';

part 'member_dto.freezed.dart';
part 'member_dto.g.dart';

/// The member's private data. It is seeded once and never refreshed from
/// the public catalog.
@freezed
abstract class MemberSeedDto with _$MemberSeedDto {
  const factory MemberSeedDto({
    required MemberProfileDto profile,
    required List<TierDto> tiers,
    required List<ChallengeDto> challenges,
    required List<GiftDto> gifts,
  }) = _MemberSeedDto;

  factory fromJson(Map<String, dynamic> json) => _$MemberSeedDtoFromJson(json);
}

@freezed
abstract class MemberProfileDto with _$MemberProfileDto {
  const factory MemberProfileDto({
    required int totalPoints,
    required String avatarUrl,
    required int notificationCount,
    required int rewardsCount,
    String? avatarAsset,
  }) = _MemberProfileDto;

  factory fromJson(Map<String, dynamic> json) =>
      _$MemberProfileDtoFromJson(json);
}

@freezed
abstract class TierDto with _$TierDto {
  const factory TierDto({
    required String id,
    required String name,
    required int minPoints,
    required int sortOrder,
    String? imageUrl,
    String? imageAsset,
  }) = _TierDto;

  factory fromJson(Map<String, dynamic> json) => _$TierDtoFromJson(json);
}

/// How a challenge card draws its progress.
enum ChallengeKindDto { donutQuarters, coffeeArc }

@freezed
abstract class ChallengeDto with _$ChallengeDto {
  const factory ChallengeDto({
    required String id,
    required String title,
    required ChallengeKindDto kind,
    required int progress,
    required int target,
    required int rewardPoints,
    required int sortOrder,
    String? imageUrl,
    String? imageAsset,
  }) = _ChallengeDto;

  factory fromJson(Map<String, dynamic> json) => _$ChallengeDtoFromJson(json);
}

@freezed
abstract class GiftDto with _$GiftDto {
  const factory GiftDto({
    required String id,
    required String title,
    required int costPoints,
    required int sortOrder,
    String? imageUrl,
    String? imageAsset,
  }) = _GiftDto;

  factory fromJson(Map<String, dynamic> json) => _$GiftDtoFromJson(json);
}
