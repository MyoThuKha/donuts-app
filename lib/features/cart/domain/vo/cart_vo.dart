// Freezed's redirecting factory must keep the class name.
// ignore_for_file: unnecessary_type_name_in_constructor
import 'package:donuts/features/cart/domain/vo/cart_item_vo.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'cart_vo.freezed.dart';

/// The whole cart, most recently changed item first.
@freezed
abstract class CartVO with _$CartVO {
  const factory CartVO({required List<CartItemVO> items}) = _CartVO;

  const CartVO._();

  bool get isEmpty => items.isEmpty;

  /// How many items, counting every line's quantity.
  int get totalQuantity => items.fold(0, (sum, item) => sum + item.quantity);

  /// What the whole cart costs.
  int get totalMmk => items.fold(0, (sum, item) => sum + item.lineTotal);
}
