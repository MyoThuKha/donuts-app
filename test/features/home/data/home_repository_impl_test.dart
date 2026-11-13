import 'package:donuts/core/database/app_database.dart';
import 'package:donuts/core/sync/data/catalog_importer.dart';
import 'package:donuts/features/home/data/repositories/home_repository_impl.dart';
import 'package:donuts/features/home/domain/types/banner_style.dart';
import 'package:donuts/features/home/domain/vo/home_section_vo.dart';
import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/catalog_rows.dart';
import '../../../helpers/seed_files.dart';

void main() {
  late AppDatabase db;
  late HomeRepositoryImpl repository;

  setUp(() async {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    repository = HomeRepositoryImpl(db.catalogDao);
    await CatalogImporter(
      db,
      now: () => DateTime.utc(2026, 11, 12),
      imageBase: testImageBase,
    ).importCatalog(readCatalogFile(seedCatalogPath).data!, version: 1);
  });
  tearDown(() => db.close());

  test('watchSections maps the seed into seasonal, popular and order '
      'again', () async {
    final sections = await repository.watchSections().first;

    expect(sections.map((s) => s.kind), [
      HomeSectionKind.seasonal,
      HomeSectionKind.popular,
      HomeSectionKind.orderAgain,
    ]);
    expect(sections.map((s) => s.id), ['seasonal', 'popular', 'order_again']);
  });

  test("watchSectionProducts maps a row's products in order", () async {
    final popular = await repository.watchSectionProducts('popular').first;
    final seasonal = await repository.watchSectionProducts('seasonal').first;

    expect(popular.map((p) => p.id), [
      'p_strawberry_chocolate',
      'p_dalgona',
      'p_americano',
      'p_coconut',
      'p_blueberry',
    ]);
    final mistletoe = seasonal.first;
    expect(mistletoe.name, 'Mistletoe Romance box');
    expect(mistletoe.discountPercent, 50);
    expect(mistletoe.imageAsset, isNull);
    expect(
      mistletoe.imageUrl,
      testImageBase.resolve('assets/home/romance.jpeg').toString(),
    );
    expect(popular.first.discountPercent, isNull);
  });

  test('watchBanners maps the seeded banners and their styles', () async {
    final banners = await repository.watchBanners().first;

    expect(banners.map((b) => b.id), ['b_central_boulevard', 'b_hot_drinks']);
    expect(banners.map((b) => b.style), [BannerStyle.indigo, BannerStyle.sky]);
    expect(banners.first.tag, 'New shop');
    expect(banners.first.title, 'We are now at Central Boulevard');
  });

  test('a banner with an unknown style falls back to sky', () async {
    await db
        .into(db.bannersTable)
        .insert(
          bannerRow(
            'b_neon',
            sortOrder: 9,
          ).copyWith(style: const Value('neon')),
        );

    final banners = await repository.watchBanners().first;

    expect(banners.last.id, 'b_neon');
    expect(banners.last.style, BannerStyle.sky);
  });

  test('watchShops returns the four seeded shops in order', () async {
    final shops = await repository.watchShops().first;

    expect(shops.map((s) => s.id), [
      's_myaynigone',
      's_sanchaung',
      's_downtown',
      's_central_boulevard',
    ]);
    expect(shops.first.name, 'J’Donuts Myaynigone');
    expect(shops.first.address, 'Bayint Naung Road, Hlaing Township, Yangon');
    expect(shops.first.imageUrl, 'http://localhost:8080/assets/home/shop.jpg');
    expect(shops.first.imageAsset, isNull);
  });

  test('a section titleKey nobody knows maps to other', () async {
    await db
        .into(db.homeSectionsTable)
        .insert(sectionRow('mystery', sortOrder: 9));

    final sections = await repository.watchSections().first;

    expect(sections.last.id, 'mystery');
    expect(sections.last.kind, HomeSectionKind.other);
    expect(sections.last.titleKey, 'mystery');
    expect(await repository.watchSectionProducts('mystery').first, isEmpty);
  });
}
