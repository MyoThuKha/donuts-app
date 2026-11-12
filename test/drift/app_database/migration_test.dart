import 'package:donuts/core/database/app_database.dart';
import 'package:drift/drift.dart';
import 'package:drift_dev/api/migrations_native.dart';
import 'package:flutter_test/flutter_test.dart';

import 'generated/schema.dart';
import 'generated/schema_v1.dart' as v1;
import 'generated/schema_v2.dart' as v2;
import 'generated/schema_v3.dart' as v3;

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
}
