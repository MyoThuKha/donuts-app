import 'package:donuts/core/database/app_database.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/catalog_rows.dart';

void main() {
  late AppDatabase db;

  setUp(() => db = AppDatabase.forTesting(NativeDatabase.memory()));
  tearDown(() => db.close());

  test('watchSectionProducts returns products in section order', () async {
    await db.catalogDao.replaceCatalog((
      products: [productRow('a'), productRow('b'), productRow('c')],
      sections: [sectionRow('popular')],
      sectionProducts: [
        linkRow('popular', 'c', 0),
        linkRow('popular', 'a', 1),
        linkRow('popular', 'b', 2),
      ],
      banners: const [],
      shops: const [],
      gifts: const [],
    ));

    final products = await db.catalogDao.watchSectionProducts('popular').first;

    expect(products.map((p) => p.id), ['c', 'a', 'b']);
  });

  test('replaceCatalog removes a product that is no longer in the catalog, '
      'with its section links', () async {
    await db.catalogDao.replaceCatalog(catalogRows(['a', 'b']));
    await db.catalogDao.replaceCatalog(catalogRows(['a']));

    final all = await db.select(db.productsTable).get();
    final links = await db.select(db.sectionProductsTable).get();

    expect(all.map((p) => p.id), ['a']);
    expect(links.map((l) => l.productId), ['a']);
  });

  test('replaceCatalog updates a product that is still listed', () async {
    await db.catalogDao.replaceCatalog(catalogRows(['a']));
    final changed = catalogRows(['a']);
    await db.catalogDao.replaceCatalog((
      products: [productRow('a', priceMmk: 3200)],
      sections: changed.sections,
      sectionProducts: changed.sectionProducts,
      banners: changed.banners,
      shops: changed.shops,
      gifts: changed.gifts,
    ));

    final product = await db.catalogDao.watchProduct('a').first;

    expect(product?.priceMmk, 3200);
  });

  test('watchSections emits again after replaceCatalog', () async {
    final sections = db.catalogDao.watchSections();
    final expectation = expectLater(
      sections.map((rows) => rows.map((s) => s.id).toList()),
      emitsInOrder([
        <String>[],
        ['popular'],
      ]),
    );

    await pumpEventQueue();
    await db.catalogDao.replaceCatalog(catalogRows(['a']));

    await expectation;
  });

  test('watchBanners and watchShops order rows by sortOrder', () async {
    await db.catalogDao.replaceCatalog((
      products: const [],
      sections: const [],
      sectionProducts: const [],
      banners: [bannerRow('late', sortOrder: 1), bannerRow('early')],
      shops: [shopRow('second', sortOrder: 1), shopRow('first')],
      gifts: const [],
    ));

    final banners = await db.catalogDao.watchBanners().first;
    final shops = await db.catalogDao.watchShops().first;

    expect(banners.map((b) => b.id), ['early', 'late']);
    expect(shops.map((s) => s.id), ['first', 'second']);
  });

  test('watchHomeSections returns sections in order with their products '
      'in order', () async {
    await db.catalogDao.replaceCatalog((
      products: [productRow('a'), productRow('b'), productRow('c')],
      sections: [sectionRow('second', sortOrder: 1), sectionRow('first')],
      sectionProducts: [
        linkRow('second', 'a', 1),
        linkRow('first', 'c', 0),
        linkRow('second', 'b', 0),
        linkRow('first', 'a', 1),
      ],
      banners: const [],
      shops: const [],
      gifts: const [],
    ));

    final sections = await db.catalogDao.watchHomeSections().first;

    expect(sections.map((s) => s.section.id), ['first', 'second']);
    expect(sections[0].products.map((p) => p.id), ['c', 'a']);
    expect(sections[1].products.map((p) => p.id), ['b', 'a']);
  });

  test('a section with no products is listed with an empty list', () async {
    await db.catalogDao.replaceCatalog((
      products: [productRow('a')],
      sections: [sectionRow('popular'), sectionRow('empty', sortOrder: 1)],
      sectionProducts: [linkRow('popular', 'a', 0)],
      banners: const [],
      shops: const [],
      gifts: const [],
    ));

    final sections = await db.catalogDao.watchHomeSections().first;

    expect(sections.map((s) => s.section.id), ['popular', 'empty']);
    expect(sections[1].products, isEmpty);
  });

  test('watchHomeSections emits again after replaceCatalog', () async {
    final sections = db.catalogDao.watchHomeSections();
    final expectation = expectLater(
      sections.map(
        (rows) => [
          for (final row in rows)
            '${row.section.id}:${row.products.map((p) => p.id).join(',')}',
        ],
      ),
      emitsInOrder([
        <String>[],
        ['popular:a,b'],
      ]),
    );

    await pumpEventQueue();
    await db.catalogDao.replaceCatalog(catalogRows(['a', 'b']));

    await expectation;
  });

  test(
    'replaceCatalog keeps the listed gifts in order and drops the rest',
    () async {
      final first = catalogRows(['a']);
      await db.catalogDao.replaceCatalog((
        products: first.products,
        sections: first.sections,
        sectionProducts: first.sectionProducts,
        banners: first.banners,
        shops: first.shops,
        gifts: [giftRow('old'), giftRow('later', sortOrder: 2)],
      ));
      await db.catalogDao.replaceCatalog((
        products: first.products,
        sections: first.sections,
        sectionProducts: first.sectionProducts,
        banners: first.banners,
        shops: first.shops,
        gifts: [giftRow('later', sortOrder: 2), giftRow('new', sortOrder: 1)],
      ));

      final gifts = await db.catalogDao.watchGifts().first;

      expect(gifts.map((g) => g.id), ['new', 'later']);
    },
  );
}
