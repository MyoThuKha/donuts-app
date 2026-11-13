import 'package:donuts/core/database/app_database.dart';
import 'package:donuts/core/sync/data/catalog_importer.dart';
import 'package:donuts/features/rewards/data/repositories/rewards_repository_impl.dart';
import 'package:donuts/features/rewards/data/sources/reward_claims_memory_source.dart';
import 'package:donuts/features/rewards/domain/types/challenge_kind.dart';
import 'package:drift/drift.dart' hide isNull;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/seed_files.dart';

void main() {
  late AppDatabase db;
  late RewardsRepositoryImpl repository;

  setUp(() async {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    repository = RewardsRepositoryImpl(
      db.memberDao,
      RewardClaimsMemorySource(),
    );
    await CatalogImporter(
      db,
      now: () => DateTime.utc(2026, 11, 12),
    ).importMember(readMemberFile(seedMemberPath).data!, version: 1);
  });
  tearDown(() => db.close());

  test('the seeded challenges are Coco 4/4, americano 9/12 and strawberry 1/4 '
      'in order', () async {
    final challenges = await repository.watchChallenges().first;

    expect(
      [for (final c in challenges) (c.id, c.kind, c.progress, c.target)],
      [
        ('c_coco_donuts', ChallengeKind.donutQuarters, 4, 4),
        ('c_americano', ChallengeKind.coffeeArc, 9, 12),
        ('c_strawberry_donuts', ChallengeKind.donutQuarters, 1, 4),
      ],
    );
    expect(challenges.first.title, 'Eat 4 Coco donuts');
    expect(challenges.first.rewardPoints, 200);
    expect(challenges.first.imageAsset, 'assets/images/reward_donut.png');
  });

  test('a challenge with an unknown kind is left out', () async {
    await db
        .into(db.challengesTable)
        .insert(
          ChallengesTableCompanion.insert(
            id: 'c_mystery',
            title: 'Mystery',
            kind: 'stampCard',
            progress: 1,
            target: 2,
            rewardPoints: 50,
            sortOrder: 3,
            imageAsset: const Value(null),
          ),
        );

    final challenges = await repository.watchChallenges().first;

    expect(challenges.map((c) => c.id), isNot(contains('c_mystery')));
    expect(challenges, hasLength(3));
  });

  test('the seeded gifts come in order with their costs', () async {
    final gifts = await repository.watchGifts().first;

    expect(
      [for (final g in gifts) (g.id, g.costPoints)],
      [
        ('g_classic_donut', 20000),
        ('g_iced_latte', 35000),
        ('g_box_of_six', 90000),
      ],
    );
    expect(gifts.first.title, 'Free classic donut');
    expect(gifts.first.imageAsset, 'assets/images/donut_caramel_glaze.webp');
  });
}
