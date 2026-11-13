import 'package:donuts/core/database/app_database.dart';
import 'package:donuts/core/database/daos/cart_dao.dart';
import 'package:donuts/core/result/app_failure.dart';
import 'package:donuts/core/result/result.dart';
import 'package:donuts/features/cart/data/repositories/cart_repository_impl.dart';
import 'package:donuts/features/cart/domain/cart_rules.dart';
import 'package:donuts/features/cart/domain/vo/cart_vo.dart';
import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../helpers/catalog_rows.dart';

void main() {
  late AppDatabase db;
  late CartRepositoryImpl repository;

  setUp(() async {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    final catalog = catalogRows(['p_coconut']);
    await db.catalogDao.replaceCatalog((
      products: [
        productRow('p_coconut', priceMmk: 3200),
        productRow(
          'p_berry',
          priceMmk: 2500,
        ).copyWith(discountPercent: const Value(20)),
      ],
      sections: catalog.sections,
      sectionProducts: catalog.sectionProducts,
      banners: catalog.banners,
      shops: catalog.shops,
      gifts: catalog.gifts,
    ));
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
      () => repository.add('p_coconut', CartRules.minQuantity - 1),
      throwsArgumentError,
    );
    expect(
      () => repository.add('p_coconut', CartRules.maxQuantity + 1),
      throwsArgumentError,
    );
  });

  test('add stops at the cart limit', () async {
    await repository.add('p_coconut', 60);
    await repository.add('p_coconut', 60);

    expect(await db.cartDao.quantityOf('p_coconut'), CartRules.maxQuantity);
  });

  test('watchCart maps lines to a cart with line and grand totals', () async {
    await repository.add('p_coconut', 2);
    await repository.add('p_berry', 1);

    final cart = await repository.watchCart().first;

    expect(cart.items, hasLength(2));
    final berry = cart.items.firstWhere((i) => i.productId == 'p_berry');
    expect(berry.unitPriceMmk, 2000);
    expect(berry.lineTotal, 2000);
    expect(cart.totalQuantity, 3);
    expect(cart.totalMmk, 2 * 3200 + 2000);
  });

  test('an empty cart is empty', () async {
    final cart = await repository.watchCart().first;

    expect(cart.isEmpty, isTrue);
    expect(cart, const CartVO(items: []));
  });

  test('watchCount follows the total quantity', () async {
    final counts = repository.watchCount();
    final expectation = expectLater(counts, emitsInOrder([0, 3]));

    await pumpEventQueue();
    await repository.setQuantity('p_coconut', 3);

    await expectation;
  });

  test('setQuantity replaces the quantity', () async {
    await repository.add('p_coconut', 2);

    final result = await repository.setQuantity('p_coconut', 7);

    expect(result, isA<Success<void>>());
    expect(await db.cartDao.quantityOf('p_coconut'), 7);
  });

  test('setQuantity outside 1 to 99 throws a RangeError', () {
    expect(() => repository.setQuantity('p_coconut', 0), throwsRangeError);
    expect(() => repository.setQuantity('p_coconut', 100), throwsRangeError);
  });

  test('setQuantity for a product the catalog no longer has returns '
      'DatabaseFailure', () async {
    final result = await repository.setQuantity('p_gone', 1);

    expect((result as Failure<void>).failure, isA<DatabaseFailure>());
  });

  test('remove takes the product out of the cart', () async {
    await repository.add('p_coconut', 2);

    expect(await repository.remove('p_coconut'), isA<Success<void>>());
    expect(await db.cartDao.quantityOf('p_coconut'), isNull);
  });

  test('clear empties the cart', () async {
    await repository.add('p_coconut', 2);
    await repository.add('p_berry', 1);

    expect(await repository.clear(), isA<Success<void>>());
    expect((await repository.watchCart().first).isEmpty, isTrue);
  });

  test('watchCart turns a database error into a DatabaseFailure', () async {
    final dao = _MockCartDao();
    when(dao.watchLines).thenAnswer(
      (_) => Stream.error(
        SqliteException(
          extendedResultCode: 1,
          message: 'no such table: cart_items',
        ),
      ),
    );
    final failing = CartRepositoryImpl(dao, now: DateTime.now);

    await expectLater(failing.watchCart(), emitsError(isA<DatabaseFailure>()));
  });
}

class _MockCartDao extends Mock implements CartDao;
