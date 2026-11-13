import 'dart:async';

import 'package:donuts/core/result/result.dart';
import 'package:donuts/core/state/section_state.dart';
import 'package:donuts/core/state/section_watcher.dart';
import 'package:donuts/features/cart/domain/cart_rules.dart';
import 'package:donuts/features/cart/domain/params/set_cart_quantity_params.dart';
import 'package:donuts/features/cart/domain/usecases/remove_from_cart_use_case.dart';
import 'package:donuts/features/cart/domain/usecases/set_cart_quantity_use_case.dart';
import 'package:donuts/features/cart/domain/usecases/watch_cart_use_case.dart';
import 'package:donuts/features/cart/domain/vo/cart_item_vo.dart';
import 'package:donuts/features/cart/domain/vo/cart_vo.dart';
import 'package:donuts/features/cart/presentation/blocs/cart_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Follows the cart in the local database and steps its quantities.
///
/// The database stays the only source: a step writes the new quantity and
/// the list updates when the stream sends it back. Writes for one product
/// run one after another, and a quick second tap counts from the quantity
/// the first tap is writing, so no tap is lost.
class CartCubit extends Cubit<CartState>
    with SectionWatcher<Object, CartState> {
  new({
    required this._watchCart,
    required this._setQuantity,
    required this._remove,
  }) : super(const CartState());

  final WatchCartUseCase _watchCart;
  final SetCartQuantityUseCase _setQuantity;
  final RemoveFromCartUseCase _remove;

  static const Object _cartKey = 'cart';

  /// Per product, the quantity the latest queued write sets, and the end of
  /// its write queue.
  final Map<String, int> _pending = {};
  final Map<String, Future<void>> _queues = {};

  void start() => watchSection(
    _cartKey,
    _watchCart().map(
      (cart) =>
          cart.isEmpty ? const SectionEmpty<CartVO>() : SectionReady(cart),
    ),
    (section) => state.copyWith(cart: section),
    then: (_) => _settlePending(),
  );

  /// Shows loading again and follows the cart afresh.
  void retry() => start();

  Future<void> increment(String productId) {
    final current = _quantityOf(productId);
    if (current == null || current >= CartRules.maxQuantity) {
      return Future.value();
    }
    return _set(productId, current + 1);
  }

  /// Takes one away, or removes the item when the tile shows it at the
  /// minimum, with its trash button. A tap while an earlier step to the
  /// minimum is still being written does nothing, so a quick double tap on
  /// minus never removes an item the member didn't see a trash button for.
  Future<void> decrement(String productId) {
    final current = _quantityOf(productId);
    if (current == null) return Future.value();
    if (current > CartRules.minQuantity) return _set(productId, current - 1);
    if (_pending.containsKey(productId)) return Future.value();
    return _enqueue(productId, () => _remove(productId));
  }

  Future<void> _set(String productId, int quantity) {
    _pending[productId] = quantity;
    return _enqueue(
      productId,
      () => _setQuantity(
        SetCartQuantityParams(productId: productId, quantity: quantity),
      ),
    );
  }

  /// Runs [write] after the product's earlier writes.
  Future<void> _enqueue(
    String productId,
    Future<Result<void>> Function() write,
  ) async {
    final next = (_queues[productId] ?? Future.value()).then((_) async {
      if (await write() case Failure(:final failure)) {
        _reportFailure(productId, failure);
      }
    });
    _queues[productId] = next;
    await next;
    _queues.removeWhere(
      (id, queue) => id == productId && identical(queue, next),
    );
    // The database may already show the written quantity.
    _settlePending();
  }

  /// Forgets a pending quantity once the database shows it and no write for
  /// that product is queued. Until then a tap counts from the pending one.
  void _settlePending() {
    if (isClosed) return;
    _pending.removeWhere(
      (productId, quantity) =>
          !_queues.containsKey(productId) &&
          _itemOf(productId)?.quantity == quantity,
    );
  }

  void _reportFailure(String productId, Object failure) {
    _pending.remove(productId);
    if (isClosed) return;
    addError(failure, StackTrace.current);
    emit(state.copyWith(failedWrites: state.failedWrites + 1));
  }

  int? _quantityOf(String productId) =>
      _pending[productId] ?? _itemOf(productId)?.quantity;

  CartItemVO? _itemOf(String productId) => switch (state.cart) {
    SectionReady(:final data) =>
      data.items.where((item) => item.productId == productId).firstOrNull,
    _ => null,
  };
}
