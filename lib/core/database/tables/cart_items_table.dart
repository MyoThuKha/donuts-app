import 'package:donuts/core/database/tables/products_table.dart';
import 'package:drift/drift.dart';

/// The persistent cart: one row per product, holding its quantity.
class CartItemsTable extends Table {
  TextColumn get productId =>
      text().references(ProductsTable, #id, onDelete: KeyAction.cascade)();
  IntColumn get quantity => integer()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {productId};

  @override
  String get tableName => 'cart_items';
}
