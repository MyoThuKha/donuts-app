import 'package:donuts/core/database/app_database.dart';
import 'package:donuts/core/database/tables/sync_state_table.dart';
import 'package:drift/drift.dart';

part 'sync_state_dao.g.dart';

/// The stored version of each data set (catalog, member).
@DriftAccessor(tables: [SyncStateTable])
class SyncStateDao extends DatabaseAccessor<AppDatabase>
    with _$SyncStateDaoMixin {
  new(super.attachedDatabase);

  Future<SyncStateTableData?> find(String key) => (select(
    syncStateTable,
  )..where((s) => s.key.equals(key))).getSingleOrNull();

  Future<void> save({
    required String key,
    required int version,
    required DateTime fetchedAt,
  }) => into(syncStateTable).insertOnConflictUpdate(
    SyncStateTableCompanion.insert(
      key: key,
      version: version,
      fetchedAt: fetchedAt,
    ),
  );
}
