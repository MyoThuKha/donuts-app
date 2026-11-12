import 'package:donuts/core/database/app_database.dart';
import 'package:donuts/core/database/daos/catalog_dao.dart';
import 'package:drift/drift.dart';

/// Builds catalog companions for DAO tests.
ProductsTableCompanion productRow(String id, {int priceMmk = 3000}) =>
    ProductsTableCompanion.insert(
      id: id,
      code: 'JD$id',
      name: 'Product $id',
      priceMmk: priceMmk,
      isNew: false,
      description: 'A donut.',
      imageUrl: 'https://example.com/$id.webp',
      updatedAt: DateTime.utc(2026, 11, 12),
    );

HomeSectionsTableCompanion sectionRow(String id, {int sortOrder = 0}) =>
    HomeSectionsTableCompanion.insert(
      id: id,
      titleKey: id,
      sortOrder: sortOrder,
    );

SectionProductsTableCompanion linkRow(
  String sectionId,
  String productId,
  int sortOrder,
) => SectionProductsTableCompanion.insert(
  sectionId: sectionId,
  productId: productId,
  sortOrder: sortOrder,
);

BannersTableCompanion bannerRow(String id, {int sortOrder = 0}) =>
    BannersTableCompanion.insert(
      id: id,
      tag: 'New',
      title: 'Banner $id',
      style: 'sky',
      imageUrl: 'https://example.com/$id.webp',
      sortOrder: sortOrder,
    );

ShopsTableCompanion shopRow(String id, {int sortOrder = 0}) =>
    ShopsTableCompanion.insert(
      id: id,
      name: 'Shop $id',
      address: 'Yangon',
      imageUrl: 'https://example.com/$id.webp',
      sortOrder: sortOrder,
      imageAsset: const Value(null),
    );

/// A catalog with [productIds] all listed, in order, under one `popular`
/// section.
CatalogRows catalogRows(List<String> productIds) => (
  products: [for (final id in productIds) productRow(id)],
  sections: [sectionRow('popular')],
  sectionProducts: [
    for (final (i, id) in productIds.indexed) linkRow('popular', id, i),
  ],
  banners: [bannerRow('b1')],
  shops: [shopRow('s1')],
);
