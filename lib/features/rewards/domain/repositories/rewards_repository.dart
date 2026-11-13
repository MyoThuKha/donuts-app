import 'package:donuts/core/result/result.dart';
import 'package:donuts/features/rewards/domain/vo/challenge_vo.dart';
import 'package:donuts/features/rewards/domain/vo/gift_vo.dart';

abstract interface class RewardsRepository {
  /// The member's challenges in display order. Challenges of a kind this
  /// app can't draw are left out.
  Stream<List<ChallengeVO>> watchChallenges();

  /// The gifts in display order.
  Stream<List<GiftVO>> watchGifts();

  /// Adds a completed challenge's points to the member's total and marks
  /// it claimed, for this run of the app only. A challenge that isn't
  /// complete, is already claimed or doesn't exist is left alone.
  Future<Result<void>> claimChallenge(String challengeId);

  /// Forgets every claim, so the points and challenges read as stored.
  void clearClaims();
}
