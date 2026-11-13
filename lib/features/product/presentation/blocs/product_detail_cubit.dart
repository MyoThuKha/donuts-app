import 'dart:async';

import 'package:donuts/core/result/result.dart';
import 'package:donuts/features/product/domain/params/add_to_cart_params.dart';
import 'package:donuts/features/product/domain/product_rules.dart';
import 'package:donuts/features/product/domain/usecases/add_to_cart_use_case.dart';
import 'package:donuts/features/product/domain/usecases/watch_product_use_case.dart';
import 'package:donuts/features/product/domain/vo/product_detail_vo.dart';
import 'package:donuts/features/product/presentation/blocs/product_detail_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailCubit extends Cubit<ProductDetailState> {
  new({
    required this._productId,
    required this._watchProduct,
    required this._addToCart,
  }) : super(const ProductDetailState());

  final String _productId;
  final WatchProductUseCase _watchProduct;
  final AddToCartUseCase _addToCart;
  StreamSubscription<ProductDetailVO?>? _subscription;

  /// Follows the product. A null product, from an unknown id or a refresh
  /// that removed it, becomes [ProductLoadStatus.notFound]. A stream error
  /// becomes [ProductLoadStatus.failed] until [retry].
  void start() {
    unawaited(_subscription?.cancel());
    _subscription = _watchProduct(_productId)
        .listen(_productChanged, onError: _fail);
  }

  /// Shows the product as loading again, keeping the chosen quantity, and
  /// follows it afresh.
  void retry() {
    emit(ProductDetailState(quantity: state.quantity));
    start();
  }

  void increment() => _setQuantity(state.quantity + 1);

  void decrement() => _setQuantity(state.quantity - 1);

  /// Adds the chosen quantity to the cart. Ignored while an add is running
  /// or before the product has loaded.
  Future<void> addToCart() async {
    if (state.product == null || state.addStatus == CartAddStatus.adding) {
      return;
    }
    final quantity = state.quantity;
    emit(state.copyWith(addStatus: CartAddStatus.adding));
    final result = await _addToCart(
      AddToCartParams(productId: _productId, quantity: quantity),
    );
    if (isClosed) return;
    emit(switch (result) {
      Success() => state.copyWith(
        addStatus: CartAddStatus.added,
        addedQuantity: quantity,
      ),
      Failure() => state.copyWith(addStatus: CartAddStatus.failed),
    });
  }

  void _productChanged(ProductDetailVO? product) => emit(
    product == null
        ? const ProductDetailState(status: ProductLoadStatus.notFound)
        : ProductDetailState(
            status: ProductLoadStatus.ready,
            product: product,
            quantity: state.quantity,
            addStatus: state.addStatus,
            addedQuantity: state.addedQuantity,
          ),
  );

  void _fail(Object error, StackTrace stackTrace) {
    addError(error, stackTrace);
    unawaited(_subscription?.cancel());
    _subscription = null;
    emit(
      ProductDetailState(
        status: ProductLoadStatus.failed,
        quantity: state.quantity,
      ),
    );
  }

  /// Clamps to [ProductRules]. A change after an add or a failed add
  /// returns the add status to idle, so its snackbar shows only once.
  void _setQuantity(int quantity) {
    final clamped = quantity.clamp(
      ProductRules.minQuantity,
      ProductRules.maxQuantity,
    );
    if (clamped == state.quantity) return;
    emit(
      state.copyWith(
        quantity: clamped,
        addStatus: state.addStatus == CartAddStatus.adding
            ? CartAddStatus.adding
            : CartAddStatus.idle,
      ),
    );
  }

  @override
  Future<void> close() async {
    await _subscription?.cancel();
    await super.close();
  }
}
