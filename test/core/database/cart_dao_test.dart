import 'package:donuts/core/database/app_database.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/catalog_rows.dart';

void main() {
  late AppDatabase db;
  final at = DateTime.utc(2026, 11, 12, 9);

  setUp(() async {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    await db.catalogDao.replaceCatalog(catalogRows(['a', 'b']));
  });
  tearDown(() => db.close());

  test('add puts a new product in the cart with its quantity', () async {
    await db.cartDao.add('a', 2, at: at);

    expect(await db.cartDao.quantityOf('a'), 2);
    expect(await db.cartDao.quantityOf('b'), isNull);
  });

  test('adding a product already in the cart increases its quantity', () async {
    await db.cartDao.add('a', 2, at: at);
    await db.cartDao.add('a', 3, at: at.add(const Duration(minutes: 1)));

    final rows = await db.select(db.cartItemsTable).get();

    expect(rows, hasLength(1));
    expect(rows.single.quantity, 5);
    expect(
      rows.single.updatedAt.isAtSameMomentAs(
        at.add(const Duration(minutes: 1)),
      ),
      isTrue,
    );
  });

  test(
    'removing a product from the catalog removes it from the cart',
    () async {
      await db.cartDao.add('a', 1, at: at);
      await db.cartDao.add('b', 1, at: at);

      await db.catalogDao.replaceCatalog(catalogRows(['b']));

      expect(await db.cartDao.quantityOf('a'), isNull);
      expect(await db.cartDao.quantityOf('b'), 1);
    },
  );

  test('watchTotalQuantity sums every row', () async {
    final totals = db.cartDao.watchTotalQuantity();
    final expectation = expectLater(totals, emitsInOrder([0, 2, 5]));

    await pumpEventQueue();
    await db.cartDao.add('a', 2, at: at);
    await pumpEventQueue();
    await db.cartDao.add('b', 3, at: at);

    await expectation;
  });

  test('add never takes a product past the cap it is given', () async {
    await db.cartDao.add('a', 60, at: at, cap: 99);
    await db.cartDao.add('a', 60, at: at, cap: 99);

    expect(await db.cartDao.quantityOf('a'), 99);
  });

  test('watchLines joins each item with its product, newest first', () async {
    await db.cartDao.add('a', 2, at: at);
    await db.cartDao.add('b', 1, at: at.add(const Duration(minutes: 1)));

    final lines = await db.cartDao.watchLines().first;

    expect([for (final l in lines) l.product.id], ['b', 'a']);
    expect(lines.last.item.quantity, 2);
    expect(lines.last.product.name, 'Product a');
  });

  test('setQuantity replaces the quantity instead of adding', () async {
    await db.cartDao.add('a', 2, at: at);
    await db.cartDao.setQuantity('a', 5, at: at);

    expect(await db.cartDao.quantityOf('a'), 5);
  });

  test('setQuantity puts a product not yet in the cart there', () async {
    await db.cartDao.setQuantity('b', 3, at: at);

    expect(await db.cartDao.quantityOf('b'), 3);
  });

  test("remove deletes one product's line", () async {
    await db.cartDao.add('a', 2, at: at);
    await db.cartDao.add('b', 1, at: at);

    await db.cartDao.remove('a');

    expect(await db.cartDao.quantityOf('a'), isNull);
    expect(await db.cartDao.quantityOf('b'), 1);
  });

  test('clear empties the cart', () async {
    await db.cartDao.add('a', 2, at: at);
    await db.cartDao.add('b', 1, at: at);

    await db.cartDao.clear();

    expect(await db.cartDao.watchLines().first, isEmpty);
  });

  test('a product removed from the catalog drops out of the lines', () async {
    await db.cartDao.add('a', 1, at: at);
    await db.cartDao.add('b', 1, at: at);

    await db.catalogDao.replaceCatalog(catalogRows(['b']));

    final lines = await db.cartDao.watchLines().first;
    expect([for (final l in lines) l.product.id], ['b']);
  });

  test('watchTotalQuantity follows set and remove', () async {
    final totals = db.cartDao.watchTotalQuantity();
    final expectation = expectLater(totals, emitsInOrder([0, 4, 0]));

    await pumpEventQueue();
    await db.cartDao.setQuantity('a', 4, at: at);
    await pumpEventQueue();
    await db.cartDao.remove('a');

    await expectation;
  });
}
