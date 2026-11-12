import 'package:donuts/core/database/app_database.dart';
import 'package:donuts/core/result/app_failure.dart';
import 'package:donuts/core/result/result.dart';
import 'package:donuts/features/product/data/repositories/cart_repository_impl.dart';
import 'package:donuts/features/product/domain/product_rules.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/catalog_rows.dart';

void main() {
  late AppDatabase db;
  late CartRepositoryImpl repository;

  setUp(() async {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    await db.catalogDao.replaceCatalog(catalogRows(['p_coconut']));
    repository = CartRepositoryImpl(
      db.cartDao,
      now: () => DateTime.utc(2026, 11, 12),
    );
  });
  tearDown(() => db.close());

  test('add writes the quantity to the cart', () async {
    final result = await repository.add('p_coconut', 3);

    expect(result, isA<Success<void>>());
    expect(await db.cartDao.quantityOf('p_coconut'), 3);
  });

  test(
    'add for a product the catalog no longer has returns DatabaseFailure',
    () async {
      final result = await repository.add('p_gone', 1);

      expect(result, isA<Failure<void>>());
      expect((result as Failure<void>).failure, isA<DatabaseFailure>());
      expect(await db.cartDao.quantityOf('p_gone'), isNull);
    },
  );

  test('add rejects a quantity outside the product rules', () {
    expect(
      () => repository.add('p_coconut', ProductRules.minQuantity - 1),
      throwsArgumentError,
    );
    expect(
      () => repository.add('p_coconut', ProductRules.maxQuantity + 1),
      throwsArgumentError,
    );
  });
}
