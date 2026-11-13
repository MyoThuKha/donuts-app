import 'dart:async';

import 'package:donuts/core/result/app_failure.dart';
import 'package:donuts/core/result/result.dart';
import 'package:donuts/features/product/domain/params/add_to_cart_params.dart';
import 'package:donuts/features/product/domain/repositories/cart_repository.dart';
import 'package:donuts/features/product/domain/repositories/product_repository.dart';
import 'package:donuts/features/product/domain/usecases/add_to_cart_use_case.dart';
import 'package:donuts/features/product/domain/usecases/watch_product_use_case.dart';
import 'package:donuts/features/product/domain/vo/product_detail_vo.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/product_fakes.dart';

class MockProductRepository extends Mock implements ProductRepository;

class MockCartRepository extends Mock implements CartRepository;

const String _coconutId = 'p_coconut';

void main() {
  group('WatchProductUseCase', () {
    late MockProductRepository products;

    setUp(() => products = MockProductRepository());

    test('asks the repository for the given product only', () {
      when(() => products.watchProduct(_coconutId))
          .thenAnswer((_) => Stream.value(testCoconut));
      when(() => products.watchProduct('p_dalgona'))
          .thenAnswer((_) => Stream.value(null));

      expect(
        WatchProductUseCase(products)(_coconutId),
        emitsInOrder([testCoconut, emitsDone]),
      );
      verify(() => products.watchProduct(_coconutId)).called(1);
      verifyNever(() => products.watchProduct('p_dalgona'));
    });

    test('emits null for a product the catalog does not have', () {
      when(() => products.watchProduct('p_unknown'))
          .thenAnswer((_) => Stream.value(null));

      expect(
        WatchProductUseCase(products)('p_unknown'),
        emitsInOrder([isNull, emitsDone]),
      );
    });

    test('emits each version the repository emits, in order, then '
        'completes', () {
      final discounted = testCoconut.copyWith(discountPercent: 20);
      when(() => products.watchProduct(_coconutId)).thenAnswer(
        (_) => Stream<ProductDetailVO?>.fromIterable([
          testCoconut,
          discounted,
          null,
        ]),
      );

      expect(
        WatchProductUseCase(products)(_coconutId),
        emitsInOrder([testCoconut, discounted, isNull, emitsDone]),
      );
    });

    test('passes a repository error through and keeps emitting', () {
      final error = Exception('database is locked');
      when(() => products.watchProduct(_coconutId)).thenAnswer((_) {
        final controller = StreamController<ProductDetailVO?>()
          ..add(testCoconut)
          ..addError(error)
          ..add(null);
        unawaited(controller.close());
        return controller.stream;
      });

      expect(
        WatchProductUseCase(products)(_coconutId),
        emitsInOrder([testCoconut, emitsError(same(error)), isNull, emitsDone]),
      );
    });
  });

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
