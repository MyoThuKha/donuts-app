// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member_dao.dart';

// ignore_for_file: type=lint
mixin _$MemberDaoMixin on DatabaseAccessor<AppDatabase> {
  $MemberProfileTableTable get memberProfileTable =>
      attachedDatabase.memberProfileTable;
  $TiersTableTable get tiersTable => attachedDatabase.tiersTable;
  $ChallengesTableTable get challengesTable => attachedDatabase.challengesTable;
  MemberDaoManager get managers => MemberDaoManager(this);
}

class MemberDaoManager {
  final _$MemberDaoMixin _db;
  MemberDaoManager(this._db);
  $$MemberProfileTableTableTableManager get memberProfileTable =>
      $$MemberProfileTableTableTableManager(
        _db.attachedDatabase,
        _db.memberProfileTable,
      );
  $$TiersTableTableTableManager get tiersTable =>
      $$TiersTableTableTableManager(_db.attachedDatabase, _db.tiersTable);
  $$ChallengesTableTableTableManager get challengesTable =>
      $$ChallengesTableTableTableManager(
        _db.attachedDatabase,
        _db.challengesTable,
      );
}
