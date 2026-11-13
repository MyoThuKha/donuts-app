import 'dart:async';
import 'dart:math' as math;

import 'package:donuts/core/result/app_failure.dart';
import 'package:donuts/core/result/result.dart';
import 'package:donuts/features/cart/domain/cart_rules.dart';
import 'package:donuts/features/cart/domain/repositories/cart_repository.dart';
import 'package:donuts/features/cart/domain/usecases/remove_from_cart_use_case.dart';
import 'package:donuts/features/cart/domain/usecases/set_cart_quantity_use_case.dart';
import 'package:donuts/features/cart/domain/usecases/watch_cart_count_use_case.dart';
import 'package:donuts/features/cart/domain/usecases/watch_cart_use_case.dart';
import 'package:donuts/features/cart/domain/vo/cart_item_vo.dart';
import 'package:donuts/features/cart/domain/vo/cart_vo.dart';
import 'package:donuts/features/cart/presentation/blocs/cart_count_cubit.dart';
import 'package:donuts/features/cart/presentation/blocs/cart_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';

class MockWatchCartUseCase extends Mock implements WatchCartUseCase;

class MockWatchCartCountUseCase extends Mock implements WatchCartCountUseCase;

class MockSetCartQuantityUseCase extends Mock implements SetCartQuantityUseCase;

class MockRemoveFromCartUseCase extends Mock implements RemoveFromCartUseCase;

const CartItemVO testCoconutLine = CartItemVO(
  productId: 'p_coconut',
  name: 'Coconut Donut',
  unitPriceMmk: 3200,
  quantity: 2,
  imageUrl: 'https://example.com/coconut.webp',
);

const CartItemVO testBerryLine = CartItemVO(
  productId: 'p_berry',
  name: 'Strawberry Donut',
  unitPriceMmk: 2500,
  quantity: 1,
  imageUrl: 'https://example.com/berry.webp',
);

/// Coconut (2 × 3,200) then Strawberry (1 × 2,500): 8,900 MMK.
const CartVO testCart = CartVO(items: [testCoconutLine, testBerryLine]);

/// [testCart] with [productId]'s quantity set to [quantity].
CartVO cartWith(String productId, int quantity) => CartVO(
  items: [
    for (final item in testCart.items)
      if (item.productId == productId)
        item.copyWith(quantity: quantity)
      else
        item,
  ],
);

/// An in-memory cart that streams like the Drift one: every change sends
/// the whole cart again. Products come from `catalog`, by default
/// [testCart]'s items.
class FakeCartRepository implements CartRepository {
  new({Map<String, CartItemVO>? catalog})
    : _catalog = catalog ?? {for (final i in testCart.items) i.productId: i};

  final Map<String, CartItemVO> _catalog;
  final Map<String, int> _quantities = {};
  final _changes = StreamController<void>.broadcast();

  /// Makes every write fail with a `DatabaseFailure` while true.
  bool failWrites = false;

  /// Makes the next [watchCart] subscription fail while true.
  bool failWatch = false;

  /// Fills the cart without going through the write checks.
  void seed(Map<String, int> quantities) {
    _quantities
      ..clear()
      ..addAll(quantities);
    _changes.add(null);
  }

  /// Like the Drift cart: the most recently added first, and a quantity
  /// change keeps a line in place.
  CartVO get cart => CartVO(
    items: [
      for (final MapEntry(:key, :value)
          in _quantities.entries.toList().reversed)
        _catalog[key]!.copyWith(quantity: value),
    ],
  );

  @override
  Stream<CartVO> watchCart() async* {
    if (failWatch) {
      yield* Stream.error(const DatabaseFailure());
      return;
    }
    yield cart;
    yield* _changes.stream.map((_) => cart);
  }

  @override
  Stream<int> watchCount() async* {
    yield cart.totalQuantity;
    yield* _changes.stream.map((_) => cart.totalQuantity);
  }

  @override
  Future<Result<void>> add(String productId, int quantity) => _write(
    () => _quantities[productId] = math.min(
      (_quantities[productId] ?? 0) + quantity,
      CartRules.maxQuantity,
    ),
  );

  @override
  Future<Result<void>> setQuantity(String productId, int quantity) =>
      _write(() => _quantities[productId] = quantity);

  @override
  Future<Result<void>> remove(String productId) =>
      _write(() => _quantities.remove(productId));

  @override
  Future<Result<void>> clear() => _write(_quantities.clear);

  Future<Result<void>> _write(void Function() change) async {
    if (failWrites) return const Failure(DatabaseFailure());
    change();
    _changes.add(null);
    return const Success(null);
  }
}

/// The cart screen's and Settings tag's cubits over [repository], unless a
/// test registered its own.
void registerCartFakes(GetIt getIt, {CartRepository? repository}) {
  if (!getIt.isRegistered<CartRepository>()) {
    getIt.registerSingleton<CartRepository>(repository ?? FakeCartRepository());
  }
  if (!getIt.isRegistered<CartCubit>()) {
    getIt.registerFactory(
      () => CartCubit(
        watchCart: WatchCartUseCase(getIt()),
        setQuantity: SetCartQuantityUseCase(getIt()),
        remove: RemoveFromCartUseCase(getIt()),
      ),
    );
  }
  if (!getIt.isRegistered<CartCountCubit>()) {
    getIt.registerFactory(() => CartCountCubit(WatchCartCountUseCase(getIt())));
  }
}
