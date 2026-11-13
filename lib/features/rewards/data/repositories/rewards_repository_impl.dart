import 'package:donuts/core/database/daos/catalog_dao.dart';
import 'package:donuts/core/database/daos/member_dao.dart';
import 'package:donuts/core/result/guard.dart';
import 'package:donuts/core/result/result.dart';
import 'package:donuts/features/rewards/data/mapper/rewards_db_mapper.dart';
import 'package:donuts/features/rewards/domain/repositories/rewards_repository.dart';
import 'package:donuts/features/rewards/domain/vo/challenge_vo.dart';
import 'package:donuts/features/rewards/domain/vo/gift_vo.dart';

class RewardsRepositoryImpl implements RewardsRepository {
  const new(this._dao, this._catalog);

  final MemberDao _dao;

  /// Gifts come with the public catalog.
  final CatalogDao _catalog;

  @override
  Stream<List<ChallengeVO>> watchChallenges() => _dao.watchChallenges().map(
    (rows) => [for (final row in rows) ?row.toVO()],
  );

  @override
  Stream<List<GiftVO>> watchGifts() =>
      _catalog.watchGifts().map((rows) => [for (final row in rows) row.toVO()]);

  @override
  Future<Result<void>> claimChallenge(String challengeId) =>
      guard(() => _dao.claimChallenge(challengeId));
}
