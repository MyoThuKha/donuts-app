import 'package:donuts/core/database/daos/member_dao.dart';
import 'package:donuts/features/rewards/data/mapper/rewards_db_mapper.dart';
import 'package:donuts/features/rewards/domain/repositories/rewards_repository.dart';
import 'package:donuts/features/rewards/domain/vo/challenge_vo.dart';
import 'package:donuts/features/rewards/domain/vo/gift_vo.dart';

class RewardsRepositoryImpl implements RewardsRepository {
  const new(this._dao);

  final MemberDao _dao;

  @override
  Stream<List<ChallengeVO>> watchChallenges() => _dao.watchChallenges().map(
    (rows) => [for (final row in rows) ?row.toVO()],
  );

  @override
  Stream<List<GiftVO>> watchGifts() =>
      _dao.watchGifts().map((rows) => [for (final row in rows) row.toVO()]);
}
