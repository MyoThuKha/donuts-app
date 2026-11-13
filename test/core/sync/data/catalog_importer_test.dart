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
    importer = CatalogImporter(db, now: () => _now, imageBase: testImageBase);
  });
  tearDown(() => db.close());

  Future<int> productCount() async =>
      (await db.select(db.productsTable).get()).length;

  test(
    'importing the seed fills every catalog table and records version 1',
    () async {
      final outcome = await importer.importCatalog(seed, version: 1);

      expect(outcome, ImportOutcome.imported);
      expect(await productCount(), 10);
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
      expect(await productCount(), 11);
    },
  );

  test('relative image paths resolve against the API base URL', () async {
    await importer.importCatalog(remote, version: 2);

    final product = await db.catalogDao.watchProduct('p_dalgona').first;
    final shops = await db.catalogDao.watchShops().first;

    expect(
      product?.imageUrl,
      'http://localhost:8080/assets/home/daigona-coffee.png',
    );
    expect(
      shops.map((s) => s.imageUrl),
      everyElement('http://localhost:8080/assets/home/shop.jpg'),
    );
  });

  test('an absolute image URL is stored as it is', () async {
    const url = 'https://cdn.example.com/box.jpg';
    final catalog = remote.copyWith(
      products: [
        for (final p in remote.products)
          if (p.id == 'p_mistletoe_box') p.copyWith(imageUrl: url) else p,
      ],
    );

    await importer.importCatalog(catalog, version: 2);
    final box = await db.catalogDao.watchProduct('p_mistletoe_box').first;

    expect(box?.imageUrl, url);
  });

  test('importing version 1 after version 2 changes nothing', () async {
    await importer.importCatalog(remote, version: 2);

    final outcome = await importer.importCatalog(seed, version: 1);

    expect(outcome, ImportOutcome.skipped);
    expect(await productCount(), 11);
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

  Future<void> expectRejected(CatalogDto broken) async {
    await expectLater(
      importer.importCatalog(broken, version: 1),
      throwsA(isA<CatalogIntegrityException>()),
    );
    expect(await productCount(), 0);
    expect(await importer.hasData(SyncKeys.catalog), isFalse);
  }

  test('a repeated section id writes nothing', () async {
    await expectRejected(
      seed.copyWith(sections: [...seed.sections, seed.sections.first]),
    );
  });

  test('a repeated banner id writes nothing', () async {
    await expectRejected(
      seed.copyWith(banners: [...seed.banners, seed.banners.first]),
    );
  });

  test('a repeated shop id writes nothing', () async {
    await expectRejected(
      seed.copyWith(shops: [...seed.shops, seed.shops.first]),
    );
  });

  test('a product listed twice in one section writes nothing', () async {
    final popular = seed.sections.firstWhere((s) => s.id == 'popular');
    final doubled = popular.copyWith(
      productIds: [...popular.productIds, popular.productIds.first],
    );
    await expectRejected(
      seed.copyWith(
        sections: [
          for (final s in seed.sections)
            if (s.id == 'popular') doubled else s,
        ],
      ),
    );
  });

  test(
    'importMember stores one profile with 680,300 points and three tiers',
    () async {
      final member = readMemberFile(seedMemberPath).data!;

      final outcome = await importer.importMember(member, version: 1);

      expect(outcome, ImportOutcome.imported);
      expect((await db.memberDao.watchProfile().first)?.totalPoints, 680300);
      expect(await db.memberDao.watchTiers().first, hasLength(3));
      expect(await db.memberDao.watchChallenges().first, hasLength(3));
      expect((await db.syncStateDao.find(SyncKeys.member))?.version, 1);
    },
  );
}
