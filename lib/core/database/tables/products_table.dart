import 'package:drift/drift.dart';

/// Every product the catalog sells.
class ProductsTable extends Table {
  TextColumn get id => text()();
  TextColumn get code => text()();
  TextColumn get name => text()();
  IntColumn get priceMmk => integer()();
  BoolColumn get isNew => boolean()();
  IntColumn get discountPercent => integer().nullable()();
  TextColumn get description => text()();
  TextColumn get imageUrl => text()();
  TextColumn get imageAsset => text().nullable()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};

  @override
  String get tableName => 'products';
}
