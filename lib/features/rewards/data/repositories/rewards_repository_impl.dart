import 'package:donuts/core/database/daos/member_dao.dart';
import 'package:donuts/core/result/guard.dart';
import 'package:donuts/core/result/result.dart';
import 'package:donuts/core/streams/combine_latest.dart';
import 'package:donuts/features/rewards/data/mapper/rewards_db_mapper.dart';
import 'package:donuts/features/rewards/data/sources/reward_claims_memory_source.dart';
import 'package:donuts/features/rewards/domain/repositories/rewards_repository.dart';
import 'package:donuts/features/rewards/domain/vo/challenge_vo.dart';
import 'package:donuts/features/rewards/domain/vo/gift_vo.dart';

class RewardsRepositoryImpl implements RewardsRepository {
  const new(this._dao, this._claims);

  final MemberDao _dao;
  final RewardClaimsMemorySource _claims;

  @override
  Stream<List<ChallengeVO>> watchChallenges() => combineLatest2(
    _dao.watchChallenges(),
    _claims.watch(),
    (rows, claims) => [
      for (final row in rows)
        if (row.toVO() case final challenge?)
          challenge.copyWith(claimed: claims.containsKey(row.id)),
    ],
  );

  @override
  Stream<List<GiftVO>> watchGifts() =>
      _dao.watchGifts().map((rows) => [for (final row in rows) row.toVO()]);

  @override
  Future<Result<void>> claimChallenge(String challengeId) => guard(() async {
    if (_claims.isClaimed(challengeId)) return;
    final rows = await _dao.watchChallenges().first;
    final challenge = [
      for (final row in rows)
        if (row.id == challengeId) ?row.toVO(),
    ].firstOrNull;
    if (challenge == null || !challenge.isComplete) return;
    _claims.claim(challengeId, challenge.rewardPoints);
  });

  @override
  void clearClaims() => _claims.clear();
}
