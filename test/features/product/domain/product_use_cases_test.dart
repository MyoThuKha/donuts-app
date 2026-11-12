import 'package:donuts/core/result/result.dart';
import 'package:donuts/features/product/domain/params/add_to_cart_params.dart';
import 'package:donuts/features/product/domain/repositories/cart_repository.dart';
import 'package:donuts/features/product/domain/repositories/product_repository.dart';
import 'package:donuts/features/product/domain/usecases/add_to_cart_use_case.dart';
import 'package:donuts/features/product/domain/usecases/watch_product_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockProductRepository extends Mock implements ProductRepository;

class _MockCartRepository extends Mock implements CartRepository;

void main() {
  test('WatchProductUseCase reads the product from the repository', () {
    final repository = _MockProductRepository();
    when(() => repository.watchProduct('p_coconut'))
        .thenAnswer((_) => Stream.value(null));

    expect(WatchProductUseCase(repository)('p_coconut'), emits(isNull));
  });

  test('AddToCartUseCase adds the params quantity of the product', () async {
    final repository = _MockCartRepository();
    when(() => repository.add('p_coconut', 2))
        .thenAnswer((_) async => const Success(null));

    final result = await AddToCartUseCase(repository)(
      const AddToCartParams(productId: 'p_coconut', quantity: 2),
    );

    expect(result, isA<Success<void>>());
    verify(() => repository.add('p_coconut', 2)).called(1);
  });
}
