import 'package:donuts/core/database/app_database.steps.dart';
import 'package:donuts/core/database/daos/users_dao.dart';
import 'package:donuts/core/database/tables/banners_table.dart';
import 'package:donuts/core/database/tables/challenges_table.dart';
import 'package:donuts/core/database/tables/gifts_table.dart';
import 'package:donuts/core/database/tables/home_sections_table.dart';
import 'package:donuts/core/database/tables/member_profile_table.dart';
import 'package:donuts/core/database/tables/products_table.dart';
import 'package:donuts/core/database/tables/section_products_table.dart';
import 'package:donuts/core/database/tables/shops_table.dart';
import 'package:donuts/core/database/tables/sync_state_table.dart';
import 'package:donuts/core/database/tables/tiers_table.dart';
import 'package:donuts/core/database/tables/users_table.dart';
import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    UsersTable,
    MemberProfileTable,
    TiersTable,
    ProductsTable,
    HomeSectionsTable,
    SectionProductsTable,
    BannersTable,
    ShopsTable,
    ChallengesTable,
    GiftsTable,
    SyncStateTable,
  ],
  daos: [UsersDao],
)
class AppDatabase extends _$AppDatabase {
  new() : super(driftDatabase(name: 'donuts'));

  new forTesting(super.e);

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onUpgrade: stepByStep(from1To2: _addCatalogTables),
    beforeOpen: (details) => customStatement('PRAGMA foreign_keys = ON'),
  );
}

/// v2 adds the catalog, member and sync tables. `users` is unchanged.
Future<void> _addCatalogTables(Migrator m, Schema2 schema) async {
  for (final table in [
    schema.memberProfile,
    schema.tiers,
    schema.products,
    schema.homeSections,
    schema.sectionProducts,
    schema.banners,
    schema.shops,
    schema.challenges,
    schema.gifts,
    schema.syncState,
  ]) {
    await m.createTable(table);
  }
}
