import 'package:donuts/core/database/app_database.dart';
import 'package:donuts/core/database/tables/users_table.dart';
import 'package:drift/drift.dart';

part 'users_dao.g.dart';

@DriftAccessor(tables: [UsersTable])
class UsersDao extends DatabaseAccessor<AppDatabase> with _$UsersDaoMixin {
  new(super.attachedDatabase);

  Future<UsersTableData?> findByPhone(String phone) => (select(
    usersTable,
  )..where((u) => u.phone.equals(phone))).getSingleOrNull();

  Future<UsersTableData?> findById(int id) =>
      (select(usersTable)..where((u) => u.id.equals(id))).getSingleOrNull();

  Future<int> insertUser(UsersTableCompanion user) =>
      into(usersTable).insert(user);
}
