import 'package:donuts/core/database/app_database.dart';
import 'package:donuts/core/database/tables/challenges_table.dart';
import 'package:donuts/core/database/tables/member_profile_table.dart';
import 'package:donuts/core/database/tables/tiers_table.dart';
import 'package:drift/drift.dart';

part 'member_dao.g.dart';

/// Every row of the member's data, ready to write.
typedef MemberRows = ({
  MemberProfileTableCompanion profile,
  List<TiersTableCompanion> tiers,
  List<ChallengesTableCompanion> challenges,
});

/// The member's profile, tiers and challenges.
@DriftAccessor(tables: [MemberProfileTable, TiersTable, ChallengesTable])
class MemberDao extends DatabaseAccessor<AppDatabase> with _$MemberDaoMixin {
  new(super.attachedDatabase);

  /// The profile table holds one row, always with this id.
  static const int profileId = 1;

  Stream<MemberProfileTableData?> watchProfile() => (select(
    memberProfileTable,
  )..where((p) => p.id.equals(profileId))).watchSingleOrNull();

  Stream<List<TiersTableData>> watchTiers() => (select(
    tiersTable,
  )..orderBy([(t) => OrderingTerm.asc(t.minPoints)])).watch();

  Stream<List<ChallengesTableData>> watchChallenges() => (select(
    challengesTable,
  )..orderBy([(c) => OrderingTerm.asc(c.sortOrder)])).watch();

  /// Replaces the member's data whole.
  Future<void> replaceMember(MemberRows rows) => transaction(() async {
    await delete(tiersTable).go();
    await delete(challengesTable).go();
    await batch((b) {
      b
        ..insertAllOnConflictUpdate(memberProfileTable, [rows.profile])
        ..insertAll(tiersTable, rows.tiers)
        ..insertAll(challengesTable, rows.challenges);
    });
  });
}
