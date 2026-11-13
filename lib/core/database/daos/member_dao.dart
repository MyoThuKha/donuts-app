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

  /// Earn: marks challenge [id] claimed and adds its points to the
  /// profile's total, both in one transaction. Returns false and writes
  /// nothing when the challenge doesn't exist, isn't complete or is
  /// already claimed. Throws [MissingMemberProfileException] when there is
  /// no profile row.
  Future<bool> claimChallenge(String id) => transaction(() async {
    final challenge = await (select(
      challengesTable,
    )..where((c) => c.id.equals(id))).getSingleOrNull();
    if (challenge == null ||
        challenge.claimed ||
        challenge.progress < challenge.target) {
      return false;
    }
    await (update(challengesTable)..where((c) => c.id.equals(id))).write(
      const ChallengesTableCompanion(claimed: Value(true)),
    );
    final updated =
        await (update(
          memberProfileTable,
        )..where((p) => p.id.equals(profileId))).write(
          MemberProfileTableCompanion.custom(
            totalPoints:
                memberProfileTable.totalPoints +
                Constant(challenge.rewardPoints),
          ),
        );
    // Throwing rolls the claim back, so a challenge never reads claimed
    // without its points.
    if (updated == 0) throw const MissingMemberProfileException();
    return true;
  });

  /// Replaces the member's data whole. Claims start over with the new
  /// challenge rows.
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

/// Earn found no member profile row to add the points to.
class MissingMemberProfileException implements Exception {
  const new();

  @override
  String toString() => 'MissingMemberProfileException: no member profile';
}
