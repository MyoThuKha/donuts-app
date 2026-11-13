import 'package:donuts/core/database/app_database.steps.dart';
import 'package:donuts/core/database/daos/cart_dao.dart';
import 'package:donuts/core/database/daos/catalog_dao.dart';
import 'package:donuts/core/database/daos/member_dao.dart';
import 'package:donuts/core/database/daos/sync_state_dao.dart';
import 'package:donuts/core/database/daos/users_dao.dart';
import 'package:donuts/core/database/tables/banners_table.dart';
import 'package:donuts/core/database/tables/cart_items_table.dart';
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
    CartItemsTable,
  ],
  daos: [UsersDao, CatalogDao, MemberDao, SyncStateDao, CartDao],
)
class AppDatabase extends _$AppDatabase {
  new() : super(driftDatabase(name: 'donuts'));

  new forTesting(super.e);

  @override
  int get schemaVersion => 4;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onUpgrade: stepByStep(
      from1To2: _addCatalogTables,
      // v3 adds `cart_items`, the persistent cart.
      from2To3: (m, schema) => m.createTable(schema.cartItems),
      from3To4: _addRewardImages,
    ),
    beforeOpen: (details) => customStatement('PRAGMA foreign_keys = ON'),
  );
}

/// v4 adds network images to tiers, challenges and gifts. It also forgets
/// every import, so the next launch seeds the catalog and member data
/// again with the new images and the Americano. Both hold seed data only.
Future<void> _addRewardImages(Migrator m, Schema4 schema) async {
  await m.addColumn(schema.tiers, schema.tiers.imageUrl);
  await m.addColumn(schema.tiers, schema.tiers.imageAsset);
  await m.addColumn(schema.challenges, schema.challenges.imageUrl);
  await m.addColumn(schema.gifts, schema.gifts.imageUrl);
  await m.database.delete(schema.syncState).go();
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
