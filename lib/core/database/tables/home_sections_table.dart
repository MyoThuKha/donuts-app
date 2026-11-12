import 'package:drift/drift.dart';

/// The product rows on Home. `titleKey` names an l10n string.
class HomeSectionsTable extends Table {
  TextColumn get id => text()();
  TextColumn get titleKey => text()();
  IntColumn get sortOrder => integer()();

  @override
  Set<Column<Object>> get primaryKey => {id};

  @override
  String get tableName => 'home_sections';
}
