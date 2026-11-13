import 'package:donuts/core/result/app_failure.dart';
import 'package:donuts/core/result/result.dart';
import 'package:donuts/features/cart/domain/params/add_to_cart_params.dart';
import 'package:donuts/features/cart/domain/repositories/cart_repository.dart';
import 'package:donuts/features/cart/domain/usecases/add_to_cart_use_case.dart';
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
}

AppFailure _failureOf<T>(Result<T> result) => switch (result) {
  Failure(:final failure) => failure,
  Success(:final data) => throw TestFailure('Expected a failure, got $data'),
};
