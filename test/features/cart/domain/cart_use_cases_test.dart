import 'package:donuts/core/result/app_failure.dart';
import 'package:donuts/core/result/result.dart';
import 'package:donuts/features/cart/domain/params/add_to_cart_params.dart';
import 'package:donuts/features/cart/domain/params/set_cart_quantity_params.dart';
import 'package:donuts/features/cart/domain/repositories/cart_repository.dart';
import 'package:donuts/features/cart/domain/usecases/add_to_cart_use_case.dart';
import 'package:donuts/features/cart/domain/usecases/clear_cart_use_case.dart';
import 'package:donuts/features/cart/domain/usecases/remove_from_cart_use_case.dart';
import 'package:donuts/features/cart/domain/usecases/set_cart_quantity_use_case.dart';
import 'package:donuts/features/cart/domain/usecases/watch_cart_count_use_case.dart';
import 'package:donuts/features/cart/domain/usecases/watch_cart_use_case.dart';
import 'package:donuts/features/cart/domain/vo/cart_vo.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCartRepository extends Mock implements CartRepository;

const String _coconutId = 'p_coconut';

void main() {
  group('AddToCartUseCase', () {
    late MockCartRepository cart;
    const params = AddToCartParams(productId: _coconutId, quantity: 3);

    setUp(() => cart = MockCartRepository());

    test('adds the params product and quantity through the repository '
        'once', () async {
      when(() => cart.add(_coconutId, 3))
          .thenAnswer((_) async => const Success(null));

      final result = await AddToCartUseCase(cart)(params);

      expect(result, isA<Success<void>>());
      verify(() => cart.add(_coconutId, 3)).called(1);
      verifyNoMoreInteractions(cart);
    });

    test('returns the repository failure when the cart cannot be '
        'written', () async {
      final failure = DatabaseFailure(error: Exception('disk full'));
      when(() => cart.add(_coconutId, 3))
          .thenAnswer((_) async => Failure(failure));

      final result = await AddToCartUseCase(cart)(params);

      expect(_failureOf(result), same(failure));
    });

    test("lets the repository's error for an out-of-range quantity "
        'through', () async {
      when(() => cart.add(_coconutId, 0))
          .thenThrow(ArgumentError.value(0, 'quantity'));

      await expectLater(
        () => AddToCartUseCase(cart)(
          const AddToCartParams(productId: _coconutId, quantity: 0),
        ),
        throwsArgumentError,
      );
    });
  });

  group('the cart use cases forward to the repository', () {
    late MockCartRepository cart;
    final failure = DatabaseFailure(error: Exception('disk full'));

    setUp(() => cart = MockCartRepository());

    test('WatchCartUseCase streams the repository cart', () {
      const empty = CartVO(items: []);
      when(cart.watchCart).thenAnswer((_) => Stream.value(empty));

      expect(WatchCartUseCase(cart)(), emits(empty));
    });

    test('WatchCartCountUseCase streams the repository count', () {
      when(cart.watchCount).thenAnswer((_) => Stream.value(4));

      expect(WatchCartCountUseCase(cart)(), emits(4));
    });

    test('SetCartQuantityUseCase sets the params quantity', () async {
      when(() => cart.setQuantity(_coconutId, 5))
          .thenAnswer((_) async => Failure(failure));

      final result = await SetCartQuantityUseCase(cart)(
        const SetCartQuantityParams(productId: _coconutId, quantity: 5),
      );

      expect(_failureOf(result), same(failure));
      verify(() => cart.setQuantity(_coconutId, 5)).called(1);
    });

    test('RemoveFromCartUseCase removes the product', () async {
      when(() => cart.remove(_coconutId))
          .thenAnswer((_) async => const Success(null));

      expect(
        await RemoveFromCartUseCase(cart)(_coconutId),
        isA<Success<void>>(),
      );
      verify(() => cart.remove(_coconutId)).called(1);
    });

    test('ClearCartUseCase clears the cart', () async {
      when(cart.clear).thenAnswer((_) async => Failure(failure));

      expect(_failureOf(await ClearCartUseCase(cart)()), same(failure));
      verify(cart.clear).called(1);
    });
  });
}

AppFailure _failureOf<T>(Result<T> result) => switch (result) {
  Failure(:final failure) => failure,
  Success(:final data) => throw TestFailure('Expected a failure, got $data'),
};
