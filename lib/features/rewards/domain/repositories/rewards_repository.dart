import 'package:donuts/features/rewards/domain/vo/challenge_vo.dart';
import 'package:donuts/features/rewards/domain/vo/gift_vo.dart';

abstract interface class RewardsRepository {
  /// The member's challenges in display order. Challenges of a kind this
  /// app can't draw are left out.
  Stream<List<ChallengeVO>> watchChallenges();

  /// The gifts in display order.
  Stream<List<GiftVO>> watchGifts();
}
