import 'package:donuts/core/database/app_database.dart';
import 'package:donuts/core/sync/data/catalog_importer.dart';
import 'package:donuts/features/product/data/repositories/product_repository_impl.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/seed_files.dart';

void main() {
  late AppDatabase db;
  late ProductRepositoryImpl repository;

  setUp(() async {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    await CatalogImporter(
      db,
      now: () => DateTime.utc(2026, 11, 12),
    ).importCatalog(readCatalogFile(seedCatalogPath).data!, version: 1);
    repository = ProductRepositoryImpl(db.catalogDao);
  });
  tearDown(() => db.close());

  test(
    'watchProduct maps the Coconut Donut with code JD022123 and 3,200 MMK',
    () async {
      final product = await repository.watchProduct('p_coconut').first;

      expect(product?.code, 'JD022123');
      expect(product?.name, 'Coconut Donut');
      expect(product?.priceMmk, 3200);
      expect(product?.unitPriceMmk, 3200);
      expect(product?.isNew, isTrue);
      expect(product?.discountPercent, isNull);
      expect(product?.description, startsWith('Enjoy our scrumptious donuts'));
      expect(product?.imageUrl, endsWith('donut_choco_pink_drizzle.webp'));
      expect(
        product?.imageAsset,
        'assets/images/donut_choco_pink_drizzle.webp',
      );
    },
  );

  test('watchProduct emits null for an unknown id', () async {
    expect(await repository.watchProduct('p_missing').first, isNull);
  });
}
