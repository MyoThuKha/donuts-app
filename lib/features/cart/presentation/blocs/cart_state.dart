import 'package:donuts/core/state/section_state.dart';
import 'package:donuts/features/cart/domain/vo/cart_vo.dart';
import 'package:equatable/equatable.dart';

/// An item the member just took out of the cart, kept for Undo. Each
/// removal is its own instance, so removing the same item twice still
/// changes the state and shows the snackbar again.
final class CartRemoval {
  const new({
    required this.productId,
    required this.name,
    required this.quantity,
  });

  final String productId;
  final String name;
  final int quantity;
}

final class CartState extends Equatable {
  const new({
    this.cart = const SectionLoading(),
    this.lastRemoved,
    this.failedWrites = 0,
  });

  final SectionState<CartVO> cart;

  /// The latest removal, for the Undo snackbar. Null until one happens.
  final CartRemoval? lastRemoved;

  /// How many writes have failed. The screen shows a snackbar each time it
  /// goes up.
  final int failedWrites;

  CartState copyWith({
    SectionState<CartVO>? cart,
    CartRemoval? lastRemoved,
    int? failedWrites,
  }) => CartState(
    cart: cart ?? this.cart,
    lastRemoved: lastRemoved ?? this.lastRemoved,
    failedWrites: failedWrites ?? this.failedWrites,
  );

  @override
  List<Object?> get props => [cart, lastRemoved, failedWrites];
}
