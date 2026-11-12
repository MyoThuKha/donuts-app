import 'package:drift/drift.dart';

/// The signed-in member's points and counters. Always one row, id 1.
class MemberProfileTable extends Table {
  IntColumn get id => integer()();
  IntColumn get totalPoints => integer()();
  TextColumn get avatarUrl => text()();
  TextColumn get avatarAsset => text().nullable()();
  IntColumn get notificationCount => integer()();
  IntColumn get rewardsCount => integer()();

  @override
  Set<Column<Object>> get primaryKey => {id};

  @override
  String get tableName => 'member_profile';
}
