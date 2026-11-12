// Freezed's redirecting factory must keep the class name.
// ignore_for_file: unnecessary_type_name_in_constructor
import 'package:donuts/features/rewards/domain/tier_progress.dart';
import 'package:donuts/features/rewards/domain/vo/tier_vo.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'member_summary.freezed.dart';

/// The member's points and tier standing. Home's header and the Rewards
/// screen both read it.
@freezed
abstract class MemberSummary with _$MemberSummary {
  const factory MemberSummary({
    required int totalPoints,
    required String avatarUrl,
    required int notificationCount,
    required int rewardsCount,

    /// Sorted by `minPoints`.
    required List<TierVO> tiers,
    required TierProgress tierProgress,
    String? avatarAsset,
  }) = _MemberSummary;
}
