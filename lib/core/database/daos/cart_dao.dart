import 'package:donuts/core/database/app_database.dart';
import 'package:donuts/core/database/tables/cart_items_table.dart';
import 'package:drift/drift.dart';

part 'cart_dao.g.dart';

/// The persistent cart.
@DriftAccessor(tables: [CartItemsTable])
class CartDao extends DatabaseAccessor<AppDatabase> with _$CartDaoMixin {
  new(super.attachedDatabase);

  /// Puts [quantity] of [productId] in the cart, adding to any quantity
  /// already there. One statement, so two quick adds never race.
  Future<void> add(String productId, int quantity, {required DateTime at}) =>
      into(cartItemsTable).insert(
        CartItemsTableCompanion.insert(
          productId: productId,
          quantity: quantity,
          updatedAt: at,
        ),
        onConflict: DoUpdate.withExcluded(
          (old, excluded) => CartItemsTableCompanion.custom(
            quantity: old.quantity + excluded.quantity,
            updatedAt: excluded.updatedAt,
          ),
        ),
      );

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
