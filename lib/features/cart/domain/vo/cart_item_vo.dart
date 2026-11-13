// Freezed's redirecting factory must keep the class name.
// ignore_for_file: unnecessary_type_name_in_constructor
import 'package:freezed_annotation/freezed_annotation.dart';

part 'cart_item_vo.freezed.dart';

/// One product in the cart, with what the cart shows of it.
@freezed
abstract class CartItemVO with _$CartItemVO {
  const factory CartItemVO({
    required String productId,
    required String name,

    /// The price of one item after any discount.
    required int unitPriceMmk,
    required int quantity,
    required String imageUrl,
    String? imageAsset,
  }) = _CartItemVO;

  const CartItemVO._();

  /// What this line costs.
  int get lineTotal => unitPriceMmk * quantity;
}
