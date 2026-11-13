import 'package:donuts/core/state/section_state.dart';
import 'package:donuts/features/cart/domain/vo/cart_vo.dart';
import 'package:equatable/equatable.dart';

final class CartState extends Equatable {
  const new({this.cart = const SectionLoading(), this.failedWrites = 0});

  final SectionState<CartVO> cart;

  /// How many writes have failed. The screen shows a snackbar each time it
  /// goes up.
  final int failedWrites;

  CartState copyWith({SectionState<CartVO>? cart, int? failedWrites}) =>
      CartState(
        cart: cart ?? this.cart,
        failedWrites: failedWrites ?? this.failedWrites,
      );

  @override
  List<Object?> get props => [cart, failedWrites];
}
