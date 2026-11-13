import 'dart:math' as math;

import 'package:donuts/core/database/app_database.dart';
import 'package:donuts/core/database/tables/cart_items_table.dart';
import 'package:donuts/core/database/tables/products_table.dart';
import 'package:drift/drift.dart';

part 'cart_dao.g.dart';

/// One cart row with the product it holds.
typedef CartLineRow = ({CartItemsTableData item, ProductsTableData product});

/// The persistent cart.
@DriftAccessor(tables: [CartItemsTable, ProductsTable])
class CartDao extends DatabaseAccessor<AppDatabase> with _$CartDaoMixin {
  new(super.attachedDatabase);

  /// Puts [quantity] of [productId] in the cart, adding to any quantity
  /// already there, but never past [cap] when one is given. One statement,
  /// so two quick adds never race.
  Future<void> add(
    String productId,
    int quantity, {
    required DateTime at,
    int? cap,
  }) {
    final summed = cartItemsTable.quantity + Variable(quantity);
    return into(cartItemsTable).insert(
      CartItemsTableCompanion.insert(
        productId: productId,
        quantity: cap == null ? quantity : math.min(quantity, cap),
        updatedAt: at,
      ),
      onConflict: DoUpdate(
        (old) => CartItemsTableCompanion.custom(
          quantity: cap == null
              ? summed
              : FunctionCallExpression<int>('MIN', [summed, Variable(cap)]),
          updatedAt: Variable(at),
        ),
      ),
    );
  }

  /// Sets [productId]'s quantity to [quantity], putting it in the cart if
  /// it isn't there.
  Future<void> setQuantity(
    String productId,
    int quantity, {
    required DateTime at,
  }) => into(cartItemsTable).insertOnConflictUpdate(
    CartItemsTableCompanion.insert(
      productId: productId,
      quantity: quantity,
      updatedAt: at,
    ),
  );

  /// Takes [productId] out of the cart.
  Future<void> remove(String productId) => (delete(
    cartItemsTable,
  )..where((c) => c.productId.equals(productId))).go();

  /// Empties the cart.
  Future<void> clear() => delete(cartItemsTable).go();

  /// Every cart row with its product, most recently changed first.
  Stream<List<CartLineRow>> watchLines() {
    final query =
        select(cartItemsTable).join([
          innerJoin(
            productsTable,
            productsTable.id.equalsExp(cartItemsTable.productId),
          ),
        ])..orderBy([
          OrderingTerm.desc(cartItemsTable.updatedAt),
          OrderingTerm.asc(cartItemsTable.productId),
        ]);
    return query.watch().map(
      (rows) => [
        for (final row in rows)
          (
            item: row.readTable(cartItemsTable),
            product: row.readTable(productsTable),
          ),
      ],
    );
  }

  /// How many items the cart holds, counting every product's quantity.
  Stream<int> watchTotalQuantity() {
    final total = cartItemsTable.quantity.sum();
    return (selectOnly(
      cartItemsTable,
    )..addColumns([total])).map((row) => row.read(total) ?? 0).watchSingle();
  }

  /// The quantity of [productId] in the cart, or null when it isn't there.
  Future<int?> quantityOf(String productId) =>
      (select(cartItemsTable)..where((c) => c.productId.equals(productId)))
          .map((row) => row.quantity)
          .getSingleOrNull();
}
