import 'package:donuts/core/database/daos/member_dao.dart';
import 'package:donuts/core/streams/combine_latest.dart';
import 'package:donuts/features/rewards/data/mapper/member_db_mapper.dart';
import 'package:donuts/features/rewards/data/sources/reward_claims_memory_source.dart';
import 'package:donuts/features/rewards/domain/repositories/member_repository.dart';
import 'package:donuts/features/rewards/domain/vo/member_summary.dart';

class MemberRepositoryImpl implements MemberRepository {
  const new(this._dao, this._claims);

  final MemberDao _dao;
  final RewardClaimsMemorySource _claims;

  /// Follows the profile row and the claims made with Earn, which add
  /// their points to the stored total. Tiers change only when the member
  /// data is imported, which rewrites the profile row too, so reading them
  /// once per profile emission is enough.
  @override
  Stream<MemberSummary?> watchSummary() => combineLatest2(
    _dao.watchProfile().asyncMap((profile) async {
      if (profile == null) return null;
      final tiers = await _dao.watchTiers().first;
      return (profile: profile, tiers: [for (final t in tiers) t.toVO()]);
    }),
    _claims.watch(),
    (member, claims) => member?.profile.toSummary(
      member.tiers,
      bonusPoints: claims.values.fold(0, (sum, points) => sum + points),
    ),
  );
}
