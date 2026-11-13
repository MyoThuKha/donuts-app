import 'package:donuts/core/database/app_database.dart';
import 'package:drift/drift.dart';
import 'package:drift_dev/api/migrations_native.dart';
import 'package:flutter_test/flutter_test.dart';

import 'generated/schema.dart';
import 'generated/schema_v1.dart' as v1;
import 'generated/schema_v2.dart' as v2;
import 'generated/schema_v3.dart' as v3;
import 'generated/schema_v4.dart' as v4;
import 'generated/schema_v5.dart' as v5;

void main() {
  driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;
  late SchemaVerifier verifier;

  setUpAll(() {
    verifier = SchemaVerifier(GeneratedHelper());
  });

  group('every schema upgrade produces the expected schema', () {
    const versions = GeneratedHelper.versions;
    for (final (i, fromVersion) in versions.indexed) {
      for (final toVersion in versions.skip(i + 1)) {
        test('from $fromVersion to $toVersion', () async {
          final schema = await verifier.schemaAt(fromVersion);
          final db = AppDatabase.forTesting(schema.newConnection());
          await verifier.migrateAndValidate(db, toVersion);
          await db.close();
        });
      }
    }
  });

  test('upgrading from v1 to v2 keeps registered users', () async {
    // Drift stores DateTime as Unix seconds by default.
    final dateOfBirth = DateTime(1980, 5).millisecondsSinceEpoch ~/ 1000;
    final createdAt = DateTime(2026, 11, 12).millisecondsSinceEpoch ~/ 1000;
    final oldUsers = [
      v1.UsersData(
        id: 1,
        phone: '+959254135592',
        firstName: 'Ye Min',
        dateOfBirth: dateOfBirth,
        createdAt: createdAt,
      ),
    ];
    final expectedUsers = [
      v2.UsersData(
        id: 1,
        phone: '+959254135592',
        firstName: 'Ye Min',
        dateOfBirth: dateOfBirth,
        createdAt: createdAt,
      ),
    ];

    await verifier.testWithDataIntegrity(
      oldVersion: 1,
      newVersion: 2,
      createOld: v1.DatabaseAtV1.new,
      createNew: v2.DatabaseAtV2.new,
      openTestedDatabase: AppDatabase.forTesting,
      createItems: (batch, oldDb) => batch.insertAll(oldDb.users, oldUsers),
      validateItems: (newDb) async {
        expect(await newDb.select(newDb.users).get(), expectedUsers);
      },
    );
  });
  test(
    'upgrading from v2 to v3 keeps products and adds an empty cart',
    () async {
      final updatedAt =
          DateTime.utc(2026, 11, 12).millisecondsSinceEpoch ~/ 1000;
      const oldProduct = v2.ProductsData(
        id: 'p_coconut',
        code: 'JD022123',
        name: 'Coconut Donut',
        priceMmk: 3200,
        isNew: 1,
        description: 'Enjoy our scrumptious donuts.',
        imageUrl: 'https://example.com/coconut.webp',
        updatedAt: 0,
      );
      const oldProfile = v2.MemberProfileData(
        id: 1,
        totalPoints: 680000,
        avatarUrl: 'https://example.com/avatar.webp',
        notificationCount: 3,
        rewardsCount: 2,
      );

      await verifier.testWithDataIntegrity(
        oldVersion: 2,
        newVersion: 3,
        createOld: v2.DatabaseAtV2.new,
        createNew: v3.DatabaseAtV3.new,
        openTestedDatabase: AppDatabase.forTesting,
        createItems: (batch, oldDb) {
          batch
            ..insertAll(oldDb.products, [
              oldProduct.copyWith(updatedAt: updatedAt),
            ])
            ..insertAll(oldDb.memberProfile, [oldProfile]);
        },
        validateItems: (newDb) async {
          final products = await newDb.select(newDb.products).get();
          final profiles = await newDb.select(newDb.memberProfile).get();
          expect(products.map((p) => (p.id, p.priceMmk, p.updatedAt)), [
            ('p_coconut', 3200, updatedAt),
          ]);
          expect(profiles.map((p) => p.totalPoints), [680000]);
          expect(await newDb.select(newDb.cartItems).get(), isEmpty);
        },
      );
    },
  );

  test('upgrading from v3 to v4 keeps tiers, adds empty image columns and '
      'forgets every import so the seed loads again', () async {
    const oldTier = v3.TiersData(
      id: 'silver',
      name: 'Silver',
      minPoints: 678500,
      sortOrder: 0,
    );
    const oldSync = v3.SyncStateData(key: 'member', version: 1, fetchedAt: 0);

    await verifier.testWithDataIntegrity(
      oldVersion: 3,
      newVersion: 4,
      createOld: v3.DatabaseAtV3.new,
      createNew: v4.DatabaseAtV4.new,
      openTestedDatabase: AppDatabase.forTesting,
      createItems: (batch, oldDb) {
        batch
          ..insertAll(oldDb.tiers, [oldTier])
          ..insertAll(oldDb.syncState, [oldSync]);
      },
      validateItems: (newDb) async {
        final tiers = await newDb.select(newDb.tiers).get();
        expect(tiers.map((t) => (t.id, t.imageUrl, t.imageAsset)), [
          ('silver', null, null),
        ]);
        expect(await newDb.select(newDb.syncState).get(), isEmpty);
      },
    );
  });

  test('upgrading from v4 to v5 keeps challenges and starts them '
      'unclaimed', () async {
    const oldChallenge = v4.ChallengesData(
      id: 'c_coco_donuts',
      title: 'Eat 4 Coco donuts',
      kind: 'donutQuarters',
      progress: 4,
      target: 4,
      rewardPoints: 200,
      sortOrder: 0,
    );

    await verifier.testWithDataIntegrity(
      oldVersion: 4,
      newVersion: 5,
      createOld: v4.DatabaseAtV4.new,
      createNew: v5.DatabaseAtV5.new,
      openTestedDatabase: AppDatabase.forTesting,
      createItems: (batch, oldDb) =>
          batch.insertAll(oldDb.challenges, [oldChallenge]),
      validateItems: (newDb) async {
        final challenges = await newDb.select(newDb.challenges).get();
        expect(challenges.map((c) => (c.id, c.progress, c.claimed)), [
          ('c_coco_donuts', 4, 0),
        ]);
      },
    );
  });
}
