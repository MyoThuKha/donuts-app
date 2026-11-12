import 'package:drift/drift.dart';

/// People registered through the fake auth flow.
class UsersTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get phone => text().unique()();
  TextColumn get firstName => text()();
  TextColumn get lastName => text().nullable()();
  DateTimeColumn get dateOfBirth => dateTime()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  String get tableName => 'users';
}
