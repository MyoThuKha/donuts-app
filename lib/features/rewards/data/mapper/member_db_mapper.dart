import 'package:donuts/core/database/app_database.dart';
import 'package:donuts/features/rewards/domain/tier_progress.dart';
import 'package:donuts/features/rewards/domain/vo/member_summary.dart';
import 'package:donuts/features/rewards/domain/vo/tier_vo.dart';

extension TiersTableDataMapper on TiersTableData {
  TierVO toVO() => TierVO(id: id, name: name, minPoints: minPoints);
}

extension MemberProfileTableDataMapper on MemberProfileTableData {
  MemberSummary toSummary(List<TierVO> tiers) {
    final sorted = [...tiers]
      ..sort((a, b) => a.minPoints.compareTo(b.minPoints));
    return MemberSummary(
      totalPoints: totalPoints,
      avatarUrl: avatarUrl,
      avatarAsset: avatarAsset,
      notificationCount: notificationCount,
      rewardsCount: rewardsCount,
      tiers: sorted,
      tierProgress: resolveTierProgress(totalPoints, sorted),
    );
  }
}
