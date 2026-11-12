import 'package:drift/drift.dart';

/// Gifts the member can redeem with points.
class GiftsTable extends Table {
  TextColumn get id => text()();
  TextColumn get title => text()();
  IntColumn get costPoints => integer()();
  TextColumn get imageAsset => text().nullable()();
  IntColumn get sortOrder => integer()();

  @override
  Set<Column<Object>> get primaryKey => {id};

  @override
  String get tableName => 'gifts';
}
