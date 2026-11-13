import 'dart:async';

import 'package:donuts/core/result/app_failure.dart';
import 'package:donuts/core/result/result.dart';
import 'package:donuts/core/state/section_state.dart';
import 'package:donuts/features/cart/domain/cart_rules.dart';
import 'package:donuts/features/cart/domain/params/set_cart_quantity_params.dart';
import 'package:donuts/features/cart/domain/vo/cart_vo.dart';
import 'package:donuts/features/cart/presentation/blocs/cart_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/cart_fakes.dart';

void main() {
  late MockWatchCartUseCase watchCart;
  late MockSetCartQuantityUseCase setQuantity;
  late MockRemoveFromCartUseCase remove;
  late StreamController<CartVO> carts;

  CartCubit build() =>
      CartCubit(watchCart: watchCart, setQuantity: setQuantity, remove: remove);

  Future<CartCubit> ready([CartVO cart = testCart]) async {
    final cubit = build()..start();
    addTearDown(cubit.close);
    carts.add(cart);
    await pumpEventQueue();
    return cubit;
  }

  setUpAll(() {
    registerFallbackValue(
      const SetCartQuantityParams(productId: '', quantity: 1),
    );
  });

  setUp(() {
    watchCart = MockWatchCartUseCase();
    setQuantity = MockSetCartQuantityUseCase();
    remove = MockRemoveFromCartUseCase();
    carts = StreamController<CartVO>.broadcast();
    when(watchCart.call).thenAnswer((_) => carts.stream);
    when(() => setQuantity(any())).thenAnswer((_) async => const Success(null));
    when(() => remove(any())).thenAnswer((_) async => const Success(null));
  });
  tearDown(() => carts.close());

  test('start shows loading, then the cart', () async {
    final cubit = build()..start();
    addTearDown(cubit.close);

    expect(cubit.state.cart, isA<SectionLoading<CartVO>>());
    carts.add(testCart);
    await pumpEventQueue();

    expect(cubit.state.cart, const SectionReady(testCart));
  });

  test('an empty cart shows empty', () async {
    final cubit = await ready(const CartVO(items: []));

    expect(cubit.state.cart, isA<SectionEmpty<CartVO>>());
  });

  test('a stream failure shows the error, and retry resubscribes', () async {
    final cubit = build()..start();
    addTearDown(cubit.close);
    carts.addError(const DatabaseFailure());
    await pumpEventQueue();
    expect(cubit.state.cart, isA<SectionFailed<CartVO>>());

    cubit.retry();
    carts.add(testCart);
    await pumpEventQueue();

    expect(cubit.state.cart, const SectionReady(testCart));
    verify(watchCart.call).called(2);
  });

  test('increment sets the quantity one higher', () async {
    final cubit = await ready();

    await cubit.increment('p_coconut');

    verify(
      () => setQuantity(
        const SetCartQuantityParams(productId: 'p_coconut', quantity: 3),
      ),
    ).called(1);
  });

  test('increment at 99 writes nothing', () async {
    final cubit = await ready(cartWith('p_coconut', CartRules.maxQuantity));

    await cubit.increment('p_coconut');

    verifyNever(() => setQuantity(any()));
  });

  test('decrement above 1 sets the quantity one lower', () async {
    final cubit = await ready();

    await cubit.decrement('p_coconut');

    verify(
      () => setQuantity(
        const SetCartQuantityParams(productId: 'p_coconut', quantity: 1),
      ),
    ).called(1);
    expect(cubit.state.lastRemoved, isNull);
  });

  test('decrement at 1 removes the item and remembers it', () async {
    final cubit = await ready();

    await cubit.decrement('p_berry');

    verify(() => remove('p_berry')).called(1);
    verifyNever(() => setQuantity(any()));
    expect(cubit.state.lastRemoved?.productId, 'p_berry');
    expect(cubit.state.lastRemoved?.name, 'Strawberry Donut');
    expect(cubit.state.lastRemoved?.quantity, 1);
  });

  test('undoRemove writes the removed quantity back', () async {
    final cubit = await ready();
    await cubit.decrement('p_berry');

    await cubit.undoRemove();

    verify(
      () => setQuantity(
        const SetCartQuantityParams(productId: 'p_berry', quantity: 1),
      ),
    ).called(1);
  });

  test('undo after close does nothing', () async {
    final cubit = await ready();
    await cubit.decrement('p_berry');
    await cubit.close();

    await cubit.undoRemove();

    verifyNever(() => setQuantity(any()));
  });

  test('two quick increments end two above', () async {
    final cubit = await ready();
    final first = Completer<Result<void>>();
    final written = <int>[];
    when(() => setQuantity(any())).thenAnswer((invocation) {
      final params =
          invocation.positionalArguments.single as SetCartQuantityParams;
      written.add(params.quantity);
      return written.length == 1
          ? first.future
          : Future.value(const Success(null));
    });

    final a = cubit.increment('p_coconut');
    final b = cubit.increment('p_coconut');
    await pumpEventQueue();
    expect(written, [3], reason: 'the second write waits for the first');
    first.complete(const Success(null));
    await Future.wait([a, b]);

    expect(written, [3, 4]);
  });

  test('a tap after a write but before the database catches up counts from '
      'the written quantity', () async {
    final cubit = await ready();

    await cubit.increment('p_coconut');
    await cubit.increment('p_coconut');

    verify(
      () => setQuantity(
        const SetCartQuantityParams(productId: 'p_coconut', quantity: 4),
      ),
    ).called(1);
  });

  test('a failed write counts a failure for the snackbar', () async {
    final cubit = await ready();
    when(() => setQuantity(any()))
        .thenAnswer((_) async => const Failure(DatabaseFailure()));
    final errors = <Object>[];
    final sub = cubit.stream.listen((_) {}, onError: errors.add);
    addTearDown(sub.cancel);

    await cubit.increment('p_coconut');

    expect(cubit.state.failedWrites, 1);
  });
}
