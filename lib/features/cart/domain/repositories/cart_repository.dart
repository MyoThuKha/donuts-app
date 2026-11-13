import 'package:donuts/core/result/result.dart';
import 'package:donuts/features/cart/domain/vo/cart_vo.dart';

/// The persistent cart. Quantities outside `CartRules` throw an
/// [ArgumentError], because a caller that sends one has a bug.
abstract interface class CartRepository {
  /// The cart, again after every change. Errors arrive as `AppFailure`s.
  Stream<CartVO> watchCart();

  /// How many items the cart holds, again after every change.
  Stream<int> watchCount();

  /// Adds [quantity] of [productId], never taking it past
  /// `CartRules.maxQuantity`.
  Future<Result<void>> add(String productId, int quantity);

  /// Sets [productId]'s quantity, putting it in the cart if needed.
  Future<Result<void>> setQuantity(String productId, int quantity);

  /// Takes [productId] out of the cart.
  Future<Result<void>> remove(String productId);

  /// Empties the cart.
  Future<Result<void>> clear();
}
