import 'package:drift/drift.dart';

/// Membership tiers and the points each one starts at.
class TiersTable extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  IntColumn get minPoints => integer()();
  IntColumn get sortOrder => integer()();
  TextColumn get imageUrl => text().nullable()();
  TextColumn get imageAsset => text().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};

  @override
  String get tableName => 'tiers';
}
