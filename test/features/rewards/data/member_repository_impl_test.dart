import 'package:donuts/core/database/app_database.dart';
import 'package:donuts/core/sync/data/catalog_importer.dart';
import 'package:donuts/features/rewards/data/repositories/member_repository_impl.dart';
import 'package:donuts/features/rewards/data/sources/reward_claims_memory_source.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/seed_files.dart';

void main() {
  late AppDatabase db;

  setUp(() => db = AppDatabase.forTesting(NativeDatabase.memory()));
  tearDown(() => db.close());

  test('watchSummary emits null before the member seed', () async {
    final summary = await MemberRepositoryImpl(
      db.memberDao,
      RewardClaimsMemorySource(),
    ).watchSummary().first;

    expect(summary, isNull);
  });

  test('watchSummary emits the seeded member with Silver current', () async {
    final member = readMemberFile(seedMemberPath).data!;
    await CatalogImporter(
      db,
      now: () => DateTime.utc(2026, 11, 12),
    ).importMember(member, version: 1);

    final summary = await MemberRepositoryImpl(
      db.memberDao,
      RewardClaimsMemorySource(),
    ).watchSummary().first;

    expect(summary?.totalPoints, 680300);
    expect(summary?.rewardsCount, 3);
    expect(summary?.tiers.map((t) => t.id), ['silver', 'gold', 'platinum']);
    expect(summary?.tiers.map((t) => t.sortOrder), [0, 1, 2]);
    expect(summary?.tierProgress.current?.name, 'Silver');
    expect(summary?.tierProgress.pointsToNext, 200);
  });

  test(
    'watchSummary adds claimed points and moves the tier with them',
    () async {
      final member = readMemberFile(seedMemberPath).data!;
      await CatalogImporter(
        db,
        now: () => DateTime.utc(2026, 11, 12),
      ).importMember(member, version: 1);
      final claims = RewardClaimsMemorySource();
      final seen = <(int, String?)>[];
      final sub = MemberRepositoryImpl(db.memberDao, claims)
          .watchSummary()
          .listen(
            (s) => seen.add((s!.totalPoints, s.tierProgress.current?.name)),
          );
      addTearDown(sub.cancel);
      await pumpEventQueue();

      claims.claim('c_small', 100);
      await pumpEventQueue();
      claims.claim('c_coco_donuts', 200);
      await pumpEventQueue();
      claims.clear();
      await pumpEventQueue();

      expect(seen, [
        (680300, 'Silver'),
        (680400, 'Silver'),
        (680600, 'Gold'),
        (680300, 'Silver'),
      ]);
    },
  );
}
