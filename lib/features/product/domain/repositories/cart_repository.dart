import 'package:donuts/core/result/result.dart';

abstract interface class CartRepository {
  /// Adds [quantity] of [productId] to the persistent cart.
  ///
  /// Throws an [ArgumentError] when [quantity] is outside `ProductRules`.
  Future<Result<void>> add(String productId, int quantity);
}
