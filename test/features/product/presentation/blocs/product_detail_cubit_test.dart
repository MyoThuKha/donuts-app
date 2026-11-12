import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:donuts/core/result/app_failure.dart';
import 'package:donuts/core/result/result.dart';
import 'package:donuts/features/product/domain/params/add_to_cart_params.dart';
import 'package:donuts/features/product/domain/product_rules.dart';
import 'package:donuts/features/product/domain/vo/product_detail_vo.dart';
import 'package:donuts/features/product/presentation/blocs/product_detail_cubit.dart';
import 'package:donuts/features/product/presentation/blocs/product_detail_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/product_fakes.dart';

const _ready = ProductDetailState(
  status: ProductLoadStatus.ready,
  product: testCoconut,
);

void main() {
  late MockWatchProductUseCase watchProduct;
  late MockAddToCartUseCase addToCart;
  late StreamController<ProductDetailVO?> products;

  setUpAll(registerProductFallbacks);

  setUp(() {
    watchProduct = MockWatchProductUseCase();
    addToCart = MockAddToCartUseCase();
    products = StreamController<ProductDetailVO?>();
    when(() => watchProduct('p_coconut')).thenAnswer((_) => products.stream);
    when(() => addToCart(any()))
        .thenAnswer((_) async => const Success<void>(null));
  });
  // Not awaited: close() never completes on a stream nobody listened to.
  tearDown(() => unawaited(products.close()));

  ProductDetailCubit build() => ProductDetailCubit(
    productId: 'p_coconut',
    watchProduct: watchProduct,
    addToCart: addToCart,
  );

  test('starts loading with a quantity of 1', () {
    final state = build().state;

    expect(state.status, ProductLoadStatus.loading);
    expect(state.quantity, ProductRules.minQuantity);
    expect(state.total, isNull);
  });

  blocTest<ProductDetailCubit, ProductDetailState>(
    'starts loading and becomes ready with the product',
    build: build,
    act: (cubit) {
      cubit.start();
      products.add(testCoconut);
    },
    expect: () => [_ready],
  );

  blocTest<ProductDetailCubit, ProductDetailState>(
    'an unknown id becomes notFound',
    build: build,
    act: (cubit) {
      cubit.start();
      products.add(null);
    },
    expect: () => [
      const ProductDetailState(status: ProductLoadStatus.notFound),
    ],
  );

  blocTest<ProductDetailCubit, ProductDetailState>(
    'a product removed while open shows the not-found message',
    build: build,
    act: (cubit) async {
      cubit.start();
      products.add(testCoconut);
      await pumpEventQueue();
      products.add(null);
    },
    expect: () => [
      _ready,
      const ProductDetailState(status: ProductLoadStatus.notFound),
    ],
  );

  blocTest<ProductDetailCubit, ProductDetailState>(
    'decrement at 1 stays at 1',
    build: build,
    seed: () => _ready,
    act: (cubit) => cubit.decrement(),
    expect: () => <ProductDetailState>[],
  );

  blocTest<ProductDetailCubit, ProductDetailState>(
    'increment stops at 99',
    build: build,
    seed: () => _ready.copyWith(quantity: ProductRules.maxQuantity - 1),
    act: (cubit) => cubit
      ..increment()
      ..increment(),
    expect: () => [_ready.copyWith(quantity: ProductRules.maxQuantity)],
  );

  blocTest<ProductDetailCubit, ProductDetailState>(
    'total follows the quantity',
    build: build,
    seed: () => _ready,
    act: (cubit) => cubit
      ..increment()
      ..increment()
      ..decrement(),
    verify: (cubit) {
      expect(cubit.state.quantity, 2);
      expect(cubit.state.total, 6400);
    },
  );

  blocTest<ProductDetailCubit, ProductDetailState>(
    'addToCart emits adding then added with the quantity',
    build: build,
    seed: () => _ready.copyWith(quantity: 3),
    act: (cubit) => cubit.addToCart(),
    expect: () => [
      _ready.copyWith(quantity: 3, addStatus: CartAddStatus.adding),
      _ready.copyWith(
        quantity: 3,
        addStatus: CartAddStatus.added,
        addedQuantity: 3,
      ),
    ],
  );

  blocTest<ProductDetailCubit, ProductDetailState>(
    'the next interaction after an add returns to idle',
    build: build,
    seed: () => _ready.copyWith(addStatus: CartAddStatus.added),
    act: (cubit) => cubit.increment(),
    expect: () => [_ready.copyWith(quantity: 2)],
  );

  blocTest<ProductDetailCubit, ProductDetailState>(
    'a second tap while adding is ignored',
    setUp: () =>
        when(() => addToCart(any()))
            .thenAnswer((_) => Completer<Result<void>>().future),
    build: build,
    seed: () => _ready,
    act: (cubit) {
      unawaited(cubit.addToCart());
      unawaited(cubit.addToCart());
    },
    expect: () => [_ready.copyWith(addStatus: CartAddStatus.adding)],
    verify: (_) => verify(() => addToCart(any())).called(1),
  );

  blocTest<ProductDetailCubit, ProductDetailState>(
    'addToCart passes the product id and quantity as AddToCartParams',
    build: build,
    seed: () => _ready.copyWith(quantity: 4),
    act: (cubit) => cubit.addToCart(),
    verify: (_) => verify(
      () =>
          addToCart(const AddToCartParams(productId: 'p_coconut', quantity: 4)),
    ).called(1),
  );

  blocTest<ProductDetailCubit, ProductDetailState>(
    'a failed add emits failed and keeps the quantity',
    setUp: () =>
        when(() => addToCart(any()))
            .thenAnswer((_) async => const Failure<void>(DatabaseFailure())),
    build: build,
    seed: () => _ready.copyWith(quantity: 2),
    act: (cubit) => cubit.addToCart(),
    expect: () => [
      _ready.copyWith(quantity: 2, addStatus: CartAddStatus.adding),
      _ready.copyWith(quantity: 2, addStatus: CartAddStatus.failed),
    ],
  );

  blocTest<ProductDetailCubit, ProductDetailState>(
    'addToCart does nothing before the product has loaded',
    build: build,
    act: (cubit) => cubit.addToCart(),
    expect: () => <ProductDetailState>[],
    verify: (_) => verifyNever(() => addToCart(any())),
  );
}
