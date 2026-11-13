import 'package:donuts/core/database/app_database.dart';
import 'package:donuts/core/database/daos/member_dao.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

MemberRows _member({int totalPoints = 680000}) => (
  profile: MemberProfileTableCompanion.insert(
    id: const Value(MemberDao.profileId),
    totalPoints: totalPoints,
    avatarUrl: 'https://example.com/avatar.webp',
    notificationCount: 2,
    rewardsCount: 3,
  ),
  tiers: [
    TiersTableCompanion.insert(
      id: 'gold',
      name: 'Gold',
      minPoints: 680500,
      sortOrder: 1,
    ),
    TiersTableCompanion.insert(
      id: 'silver',
      name: 'Silver',
      minPoints: 678500,
      sortOrder: 0,
    ),
  ],
  challenges: [
    ChallengesTableCompanion.insert(
      id: 'c1',
      title: 'Eat 4 Coco donuts',
      kind: 'donutQuarters',
      progress: 4,
      target: 4,
      rewardPoints: 100,
      sortOrder: 0,
    ),
  ],
);

void main() {
  late AppDatabase db;

  setUp(() => db = AppDatabase.forTesting(NativeDatabase.memory()));
  tearDown(() => db.close());

  test('replaceMember keeps a single profile row', () async {
    await db.memberDao.replaceMember(_member(totalPoints: 1));
    await db.memberDao.replaceMember(_member());

    final profiles = await db.select(db.memberProfileTable).get();

    expect(profiles, hasLength(1));
    expect(profiles.single.totalPoints, 680000);
  });

  test('watchTiers orders tiers by the points they start at', () async {
    await db.memberDao.replaceMember(_member());

    final tiers = await db.memberDao.watchTiers().first;

    expect(tiers.map((t) => t.id), ['silver', 'gold']);
  });

  test('watchProfile and watchChallenges read the stored rows', () async {
    await db.memberDao.replaceMember(_member());

    expect((await db.memberDao.watchProfile().first)?.rewardsCount, 3);
    expect((await db.memberDao.watchChallenges().first).single.id, 'c1');
  });
}
