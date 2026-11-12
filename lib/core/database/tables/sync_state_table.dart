import 'package:drift/drift.dart';

/// The data version stored for each data set and when it was last fetched.
class SyncStateTable extends Table {
  TextColumn get key => text()();
  IntColumn get version => integer()();
  DateTimeColumn get fetchedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {key};

  @override
  String get tableName => 'sync_state';
}
