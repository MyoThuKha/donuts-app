import 'package:donuts/core/database/tables/home_sections_table.dart';
import 'package:donuts/core/database/tables/products_table.dart';
import 'package:drift/drift.dart';

/// Which products a Home section shows, in order.
class SectionProductsTable extends Table {
  TextColumn get sectionId => text().references(
    HomeSectionsTable,
    #id,
    onDelete: KeyAction.cascade,
  )();
  TextColumn get productId =>
      text().references(ProductsTable, #id, onDelete: KeyAction.cascade)();
  IntColumn get sortOrder => integer()();

  @override
  Set<Column<Object>> get primaryKey => {sectionId, productId};

  @override
  String get tableName => 'section_products';
}
