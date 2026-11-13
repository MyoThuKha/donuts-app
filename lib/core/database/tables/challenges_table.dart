import 'package:drift/drift.dart';

/// Rewards challenges. `kind` is `donutQuarters` or `coffeeArc`.
class ChallengesTable extends Table {
  TextColumn get id => text()();
  TextColumn get title => text()();
  TextColumn get kind => text()();
  IntColumn get progress => integer()();
  IntColumn get target => integer()();
  IntColumn get rewardPoints => integer()();
  TextColumn get imageUrl => text().nullable()();
  TextColumn get imageAsset => text().nullable()();
  IntColumn get sortOrder => integer()();

  @override
  Set<Column<Object>> get primaryKey => {id};

  @override
  String get tableName => 'challenges';
}
