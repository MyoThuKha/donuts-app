// Freezed's redirecting factory must keep the class name.
// ignore_for_file: unnecessary_type_name_in_constructor
import 'package:donuts/features/rewards/domain/types/challenge_kind.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'challenge_vo.freezed.dart';

/// A challenge on the "Eat more earn more" tab, such as eating four donuts.
@freezed
abstract class ChallengeVO with _$ChallengeVO {
  const factory ChallengeVO({
    required String id,
    required String title,
    required ChallengeKind kind,
    required int progress,
    required int target,
    required int rewardPoints,
    String? imageUrl,
    String? imageAsset,

    /// True once the member has pressed Earn on the completed challenge.
    @Default(false) bool claimed,
  }) = _ChallengeVO;

  const ChallengeVO._();

  /// Share of the target reached, 0 to 1. A target of zero or less is
  /// already met.
  double get fraction =>
      target <= 0 ? 1 : (progress / target).clamp(0, 1).toDouble();

  bool get isComplete => progress >= target;
}
