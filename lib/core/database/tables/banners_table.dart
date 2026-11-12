import 'package:drift/drift.dart';

/// Home carousel banners. `style` names a theme colour, not a hex value.
class BannersTable extends Table {
  TextColumn get id => text()();
  TextColumn get tag => text()();
  TextColumn get title => text()();
  TextColumn get style => text()();
  TextColumn get imageUrl => text()();
  TextColumn get imageAsset => text().nullable()();
  IntColumn get sortOrder => integer()();

  @override
  Set<Column<Object>> get primaryKey => {id};

  @override
  String get tableName => 'banners';
}
