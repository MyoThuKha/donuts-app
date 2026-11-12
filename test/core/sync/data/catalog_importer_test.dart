import 'package:donuts/core/database/app_database.dart';
import 'package:donuts/core/sync/data/catalog_importer.dart';
import 'package:donuts/core/sync/data/catalog_integrity_exception.dart';
import 'package:donuts/core/sync/data/dto/catalog_dto.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/seed_files.dart';

final _now = DateTime.utc(2026, 11, 12, 9);

void main() {
  late AppDatabase db;
  late CatalogImporter importer;
  final seed = readCatalogFile(seedCatalogPath).data!;
  final remote = readCatalogFile(remoteCatalogPath).data!;

  setUp(() {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    importer = CatalogImporter(db, now: () => _now);
  });
  tearDown(() => db.close());

  Future<int> productCount() async =>
      (await db.select(db.productsTable).get()).length;

  test(
    'importing the seed fills every catalog table and records version 1',
    () async {
      final outcome = await importer.importCatalog(seed, version: 1);

      expect(outcome, ImportOutcome.imported);
      expect(await productCount(), 8);
      expect(await db.catalogDao.watchSections().first, hasLength(3));
      expect(await db.catalogDao.watchBanners().first, hasLength(2));
      expect(await db.catalogDao.watchShops().first, hasLength(4));
      expect((await db.syncStateDao.find(SyncKeys.catalog))?.version, 1);
      expect(await importer.hasData(SyncKeys.catalog), isTrue);
    },
  );

  test(
    'importing version 2 adds the toasted coconut donut to popular first',
    () async {
      await importer.importCatalog(seed, version: 1);

      final outcome = await importer.importCatalog(remote, version: 2);
      final popular = await db.catalogDao.watchSectionProducts('popular').first;

      expect(outcome, ImportOutcome.imported);
      expect(popular.first.id, 'p_toasted_coconut');
      expect(popular.first.imageAsset, isNull);
      expect(await productCount(), 9);
    },
  );

  test('importing version 1 after version 2 changes nothing', () async {
    await importer.importCatalog(remote, version: 2);

    final outcome = await importer.importCatalog(seed, version: 1);

    expect(outcome, ImportOutcome.skipped);
    expect(await productCount(), 9);
    expect((await db.syncStateDao.find(SyncKeys.catalog))?.version, 2);
  });

  test('a section naming an unknown product writes nothing', () async {
    final broken = seed.copyWith(
      sections: [
        ...seed.sections,
        const HomeSectionDto(
          id: 'ghost',
          titleKey: 'ghost',
          sortOrder: 9,
          productIds: ['p_missing'],
        ),
      ],
    );

    await expectLater(
      importer.importCatalog(broken, version: 1),
      throwsA(isA<CatalogIntegrityException>()),
    );
    expect(await productCount(), 0);
    expect(await importer.hasData(SyncKeys.catalog), isFalse);
  });

  test('a repeated product id writes nothing', () async {
    final broken = seed.copyWith(
      products: [...seed.products, seed.products.first],
    );

    await expectLater(
      importer.importCatalog(broken, version: 1),
      throwsA(isA<CatalogIntegrityException>()),
    );
    expect(await productCount(), 0);
  });

  test(
    'importMember stores one profile with 680,000 points and three tiers',
    () async {
      final member = readMemberFile(seedMemberPath).data!;

      final outcome = await importer.importMember(member, version: 1);

      expect(outcome, ImportOutcome.imported);
      expect((await db.memberDao.watchProfile().first)?.totalPoints, 680000);
      expect(await db.memberDao.watchTiers().first, hasLength(3));
      expect(await db.memberDao.watchChallenges().first, hasLength(3));
      expect((await db.syncStateDao.find(SyncKeys.member))?.version, 1);
    },
  );
}
