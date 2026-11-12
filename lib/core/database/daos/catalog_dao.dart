import 'package:donuts/core/database/app_database.dart';
import 'package:donuts/core/database/tables/banners_table.dart';
import 'package:donuts/core/database/tables/home_sections_table.dart';
import 'package:donuts/core/database/tables/products_table.dart';
import 'package:donuts/core/database/tables/section_products_table.dart';
import 'package:donuts/core/database/tables/shops_table.dart';
import 'package:drift/drift.dart';

part 'catalog_dao.g.dart';

/// Every row of one catalog version, ready to write.
typedef CatalogRows = ({
  List<ProductsTableCompanion> products,
  List<HomeSectionsTableCompanion> sections,
  List<SectionProductsTableCompanion> sectionProducts,
  List<BannersTableCompanion> banners,
  List<ShopsTableCompanion> shops,
});

/// One Home section and its products, in display order.
typedef SectionWithProducts = ({
  HomeSectionsTableData section,
  List<ProductsTableData> products,
});

/// The public catalog: products, Home sections, banners and shops.
@DriftAccessor(
  tables: [
    ProductsTable,
    HomeSectionsTable,
    SectionProductsTable,
    BannersTable,
    ShopsTable,
  ],
)
class CatalogDao extends DatabaseAccessor<AppDatabase> with _$CatalogDaoMixin {
  new(super.attachedDatabase);

  Stream<List<HomeSectionsTableData>> watchSections() => (select(
    homeSectionsTable,
  )..orderBy([(s) => OrderingTerm.asc(s.sortOrder)])).watch();

  /// Every Home section with its products, from one query, so a catalog
  /// write emits once with sections and products in step. Sections follow
  /// `sortOrder` and products their link's `sortOrder`. A section with no
  /// products is listed with an empty list.
  Stream<List<SectionWithProducts>> watchHomeSections() {
    final query =
        select(homeSectionsTable).join([
          leftOuterJoin(
            sectionProductsTable,
            sectionProductsTable.sectionId.equalsExp(homeSectionsTable.id),
          ),
          leftOuterJoin(
            productsTable,
            productsTable.id.equalsExp(sectionProductsTable.productId),
          ),
        ])..orderBy([
          OrderingTerm.asc(homeSectionsTable.sortOrder),
          OrderingTerm.asc(homeSectionsTable.id),
          OrderingTerm.asc(sectionProductsTable.sortOrder),
        ]);
    return query.watch().map(_groupBySection);
  }

  List<SectionWithProducts> _groupBySection(List<TypedResult> rows) {
    final sections = <String, SectionWithProducts>{};
    for (final row in rows) {
      final section = row.readTable(homeSectionsTable);
      final entry = sections.putIfAbsent(
        section.id,
        () => (section: section, products: <ProductsTableData>[]),
      );
      final product = row.readTableOrNull(productsTable);
      if (product != null) entry.products.add(product);
    }
    return sections.values.toList();
  }

  Stream<List<ProductsTableData>> watchSectionProducts(String sectionId) {
    final query =
        select(productsTable).join([
            innerJoin(
              sectionProductsTable,
              sectionProductsTable.productId.equalsExp(productsTable.id),
            ),
          ])
          ..where(sectionProductsTable.sectionId.equals(sectionId))
          ..orderBy([OrderingTerm.asc(sectionProductsTable.sortOrder)]);
    return query.watch().map(
      (rows) => [for (final row in rows) row.readTable(productsTable)],
    );
  }

  Stream<List<BannersTableData>> watchBanners() => (select(
    bannersTable,
  )..orderBy([(b) => OrderingTerm.asc(b.sortOrder)])).watch();

  Stream<List<ShopsTableData>> watchShops() => (select(
    shopsTable,
  )..orderBy([(s) => OrderingTerm.asc(s.sortOrder)])).watch();

  Stream<ProductsTableData?> watchProduct(String id) => (select(
    productsTable,
  )..where((p) => p.id.equals(id))).watchSingleOrNull();

  /// Makes the stored catalog equal [rows]: upserts every row, deletes the
  /// ones [rows] no longer lists, and rebuilds the section links.
  Future<void> replaceCatalog(CatalogRows rows) => transaction(() async {
    await delete(sectionProductsTable).go();
    await batch((b) {
      b
        ..insertAllOnConflictUpdate(productsTable, rows.products)
        ..insertAllOnConflictUpdate(homeSectionsTable, rows.sections)
        ..insertAllOnConflictUpdate(bannersTable, rows.banners)
        ..insertAllOnConflictUpdate(shopsTable, rows.shops);
    });
    await _deleteAbsent(rows);
    await batch((b) => b.insertAll(sectionProductsTable, rows.sectionProducts));
  });

  Future<void> _deleteAbsent(CatalogRows rows) async {
    final productIds = [for (final p in rows.products) p.id.value];
    final sectionIds = [for (final s in rows.sections) s.id.value];
    final bannerIds = [for (final b in rows.banners) b.id.value];
    final shopIds = [for (final s in rows.shops) s.id.value];
    await (delete(productsTable)..where((p) => p.id.isNotIn(productIds))).go();
    await (delete(
      homeSectionsTable,
    )..where((s) => s.id.isNotIn(sectionIds))).go();
    await (delete(bannersTable)..where((b) => b.id.isNotIn(bannerIds))).go();
    await (delete(shopsTable)..where((s) => s.id.isNotIn(shopIds))).go();
  }
}
