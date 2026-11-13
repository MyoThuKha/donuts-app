import 'package:donuts/core/database/app_database.dart';
import 'package:donuts/features/rewards/domain/tier_progress.dart';
import 'package:donuts/features/rewards/domain/vo/member_summary.dart';
import 'package:donuts/features/rewards/domain/vo/tier_vo.dart';

extension TiersTableDataMapper on TiersTableData {
  TierVO toVO() => TierVO(
    id: id,
    name: name,
    minPoints: minPoints,
    sortOrder: sortOrder,
    imageUrl: imageUrl,
    imageAsset: imageAsset,
  );
}

extension MemberProfileTableDataMapper on MemberProfileTableData {
  /// [bonusPoints] are points earned in this run of the app on top of the
  /// stored total, and they count towards the tier.
  MemberSummary toSummary(List<TierVO> tiers, {int bonusPoints = 0}) {
    final points = totalPoints + bonusPoints;
    final sorted = [...tiers]
      ..sort((a, b) => a.minPoints.compareTo(b.minPoints));
    return MemberSummary(
      totalPoints: points,
      avatarUrl: avatarUrl,
      avatarAsset: avatarAsset,
      notificationCount: notificationCount,
      rewardsCount: rewardsCount,
      tiers: sorted,
      tierProgress: resolveTierProgress(points, sorted),
    );
  }
}
