import 'package:donuts/core/database/daos/member_dao.dart';
import 'package:donuts/features/rewards/data/mapper/member_db_mapper.dart';
import 'package:donuts/features/rewards/domain/repositories/member_repository.dart';
import 'package:donuts/features/rewards/domain/vo/member_summary.dart';

class MemberRepositoryImpl implements MemberRepository {
  const new(this._dao);

  final MemberDao _dao;

  /// Follows the profile row, whose total already holds the points from
  /// Earn. Tiers change only when the member data is imported, which
  /// rewrites the profile row too, so reading them once per profile
  /// emission is enough.
  @override
  Stream<MemberSummary?> watchSummary() =>
      _dao.watchProfile().asyncMap((profile) async {
        if (profile == null) return null;
        final tiers = await _dao.watchTiers().first;
        return profile.toSummary([for (final t in tiers) t.toVO()]);
      });
}
