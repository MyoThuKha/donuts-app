// Freezed's redirecting factory must keep the class name.
// ignore_for_file: unnecessary_type_name_in_constructor
import 'package:donuts/features/rewards/domain/vo/tier_vo.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'tier_progress.freezed.dart';

/// Where a member stands between two tiers.
@freezed
abstract class TierProgress with _$TierProgress {
  const factory TierProgress({
    /// Share of the way from [current] (or zero points) to [next], 0 to 1.
    /// It is 1 when there is no next tier.
    required double progress,

    /// Null below the lowest tier.
    TierVO? current,

    /// Null at the top tier.
    TierVO? next,

    /// Null at the top tier.
    int? pointsToNext,
  }) = _TierProgress;
}

/// Places [points] on the ladder of [tiers], in any order. A member holds
/// a tier from its `minPoints` on.
TierProgress resolveTierProgress(int points, List<TierVO> tiers) {
  final sorted = [...tiers]..sort((a, b) => a.minPoints.compareTo(b.minPoints));
  final reached = sorted.where((t) => points >= t.minPoints);
  final current = reached.isEmpty ? null : reached.last;
  final nextIndex = current == null ? 0 : sorted.indexOf(current) + 1;
  final next = nextIndex < sorted.length ? sorted[nextIndex] : null;
  if (next == null) return TierProgress(current: current, progress: 1);

  final floor = current?.minPoints ?? 0;
  final share = (points - floor) / (next.minPoints - floor);
  return TierProgress(
    current: current,
    next: next,
    pointsToNext: next.minPoints - points,
    progress: share.clamp(0, 1).toDouble(),
  );
}
