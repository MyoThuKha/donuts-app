import 'package:donuts/core/database/app_database.dart';
import 'package:donuts/core/result/result.dart';
import 'package:donuts/core/sync/data/catalog_importer.dart';
import 'package:donuts/features/rewards/data/repositories/rewards_repository_impl.dart';
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
    repository = RewardsRepositoryImpl(db.memberDao, db.catalogDao);
    final importer = CatalogImporter(
      db,
      now: () => DateTime.utc(2026, 11, 12),
      imageBase: testImageBase,
    );
    await importer.importMember(
      readMemberFile(seedMemberPath).data!,
      version: 1,
    );
    await importer.importCatalog(
      readCatalogFile(seedCatalogPath).data!,
      version: 1,
    );
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
    expect(
      challenges.first.imageUrl,
      'http://localhost:8080/assets/rewards/reward-donut.webp',
    );
    expect(challenges.first.imageAsset, isNull);
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

  test('the catalog gifts come in order with their costs and Home images '
      'from the mock server', () async {
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
    expect(
      [for (final g in gifts) g.imageUrl],
      [
        'http://localhost:8080/assets/home/donuts/blueberry-sprinkle.png',
        'http://localhost:8080/assets/home/daigona-coffee.png',
        'http://localhost:8080/assets/home/box.jpg',
      ],
    );
    expect(gifts.first.imageAsset, isNull);
  });

  group('claimChallenge', () {
    Future<int?> totalPoints() async =>
        (await db.memberDao.watchProfile().first)?.totalPoints;

    Future<bool> claimed(String id) async =>
        (await repository.watchChallenges().first)
            .firstWhere((c) => c.id == id)
            .claimed;

    test('stores a complete challenge as claimed and adds its points to the '
        'stored total', () async {
      final result = await repository.claimChallenge('c_coco_donuts');

      expect(result, isA<Success<void>>());
      expect(await claimed('c_coco_donuts'), isTrue);
      expect(await totalPoints(), 680500);
    });

    test('keeps the claim for a new repository on the same database', () async {
      await repository.claimChallenge('c_coco_donuts');

      final reopened = RewardsRepositoryImpl(db.memberDao, db.catalogDao);
      final challenges = await reopened.watchChallenges().first;

      expect(challenges.first.claimed, isTrue);
    });

    test('pays a challenge only once', () async {
      await repository.claimChallenge('c_coco_donuts');
      await repository.claimChallenge('c_coco_donuts');

      expect(await totalPoints(), 680500);
    });

    test('leaves an incomplete or unknown challenge alone', () async {
      await repository.claimChallenge('c_americano');
      await repository.claimChallenge('c_missing');

      expect(await claimed('c_americano'), isFalse);
      expect(await totalPoints(), 680300);
    });

    test(
      'fails and rolls the claim back when there is no profile row',
      () async {
        await db.delete(db.memberProfileTable).go();

        final result = await repository.claimChallenge('c_coco_donuts');

        expect(result, isA<Failure<void>>());
        expect(await claimed('c_coco_donuts'), isFalse);
      },
    );
  });
}
