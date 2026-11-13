// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'catalog_dao.dart';

// ignore_for_file: type=lint
mixin _$CatalogDaoMixin on DatabaseAccessor<AppDatabase> {
  $ProductsTableTable get productsTable => attachedDatabase.productsTable;
  $HomeSectionsTableTable get homeSectionsTable =>
      attachedDatabase.homeSectionsTable;
  $SectionProductsTableTable get sectionProductsTable =>
      attachedDatabase.sectionProductsTable;
  $BannersTableTable get bannersTable => attachedDatabase.bannersTable;
  $ShopsTableTable get shopsTable => attachedDatabase.shopsTable;
  $GiftsTableTable get giftsTable => attachedDatabase.giftsTable;
  CatalogDaoManager get managers => CatalogDaoManager(this);
}

class CatalogDaoManager {
  final _$CatalogDaoMixin _db;
  CatalogDaoManager(this._db);
  $$ProductsTableTableTableManager get productsTable =>
      $$ProductsTableTableTableManager(_db.attachedDatabase, _db.productsTable);
  $$HomeSectionsTableTableTableManager get homeSectionsTable =>
      $$HomeSectionsTableTableTableManager(
        _db.attachedDatabase,
        _db.homeSectionsTable,
      );
  $$SectionProductsTableTableTableManager get sectionProductsTable =>
      $$SectionProductsTableTableTableManager(
        _db.attachedDatabase,
        _db.sectionProductsTable,
      );
  $$BannersTableTableTableManager get bannersTable =>
      $$BannersTableTableTableManager(_db.attachedDatabase, _db.bannersTable);
  $$ShopsTableTableTableManager get shopsTable =>
      $$ShopsTableTableTableManager(_db.attachedDatabase, _db.shopsTable);
  $$GiftsTableTableTableManager get giftsTable =>
      $$GiftsTableTableTableManager(_db.attachedDatabase, _db.giftsTable);
}
