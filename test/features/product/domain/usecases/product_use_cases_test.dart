import 'dart:async';

import 'package:donuts/features/product/domain/repositories/product_repository.dart';
import 'package:donuts/features/product/domain/usecases/watch_product_use_case.dart';
import 'package:donuts/features/product/domain/vo/product_detail_vo.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/product_fakes.dart';

class MockProductRepository extends Mock implements ProductRepository;

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
}
