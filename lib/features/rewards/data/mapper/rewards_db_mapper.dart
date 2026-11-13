import 'package:donuts/core/database/app_database.dart';
import 'package:donuts/features/rewards/domain/types/challenge_kind.dart';
import 'package:donuts/features/rewards/domain/vo/challenge_vo.dart';
import 'package:donuts/features/rewards/domain/vo/gift_vo.dart';

extension ChallengesTableDataMapper on ChallengesTableData {
  /// Null when the stored `kind` isn't one this app can draw.
  ChallengeVO? toVO() {
    final kind = ChallengeKind.tryParse(this.kind);
    if (kind == null) return null;
    return ChallengeVO(
      id: id,
      title: title,
      kind: kind,
      progress: progress,
      target: target,
      rewardPoints: rewardPoints,
      imageUrl: imageUrl,
      imageAsset: imageAsset,
      claimed: claimed,
    );
  }
}

extension GiftsTableDataMapper on GiftsTableData {
  GiftVO toVO() => GiftVO(
    id: id,
    title: title,
    costPoints: costPoints,
    imageUrl: imageUrl,
    imageAsset: imageAsset,
  );
}
