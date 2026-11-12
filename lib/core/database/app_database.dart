import 'package:donuts/core/database/daos/users_dao.dart';
import 'package:donuts/core/database/tables/users_table.dart';
import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [UsersTable], daos: [UsersDao])
class AppDatabase extends _$AppDatabase {
  new() : super(driftDatabase(name: 'donuts'));

  new forTesting(super.e);

  @override
  int get schemaVersion => 1;
}
