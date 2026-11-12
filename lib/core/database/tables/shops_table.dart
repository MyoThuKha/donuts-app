import 'package:drift/drift.dart';

/// Nearby J'Donuts shops shown on Home.
class ShopsTable extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get address => text()();
  TextColumn get imageUrl => text()();
  TextColumn get imageAsset => text().nullable()();
  IntColumn get sortOrder => integer()();

  @override
  Set<Column<Object>> get primaryKey => {id};

  @override
  String get tableName => 'shops';
}
