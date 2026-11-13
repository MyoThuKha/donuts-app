import 'package:donuts/core/result/result.dart';
import 'package:donuts/features/cart/domain/params/add_to_cart_params.dart';
import 'package:donuts/features/cart/domain/usecases/add_to_cart_use_case.dart';
import 'package:donuts/features/product/domain/usecases/watch_product_use_case.dart';
import 'package:donuts/features/product/domain/vo/product_detail_vo.dart';
import 'package:donuts/features/product/presentation/blocs/product_detail_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';

/// The seeded reference product: Coconut Donut, 3,200 MMK, New.
const ProductDetailVO testCoconut = ProductDetailVO(
  id: 'p_coconut',
  code: 'JD022123',
  name: 'Coconut Donut',
  priceMmk: 3200,
  isNew: true,
  description: 'Enjoy our scrumptious donuts.',
  imageUrl: 'https://example.com/coconut.webp',
);

class MockWatchProductUseCase extends Mock implements WatchProductUseCase;

class MockAddToCartUseCase extends Mock implements AddToCartUseCase;

/// Call from `setUpAll` before stubbing with `any()`.
void registerProductFallbacks() {
  registerFallbackValue(const AddToCartParams(productId: '', quantity: 1));
}

/// Fakes for the product screen's get_it dependencies, used by
/// `pumpRouterApp`. Register each one only if
/// `getIt.isRegistered<T>()` is false, so a test's own fakes win.
void registerProductFakes(GetIt getIt) {
  if (!getIt.isRegistered<WatchProductUseCase>()) {
    getIt.registerSingleton<WatchProductUseCase>(FakeWatchProductUseCase());
  }
  if (!getIt.isRegistered<AddToCartUseCase>()) {
    getIt.registerSingleton<AddToCartUseCase>(FakeAddToCartUseCase());
  }
  if (!getIt.isRegistered<ProductDetailCubit>()) {
    getIt.registerFactoryParam<ProductDetailCubit, String, void>(
      (productId, _) => ProductDetailCubit(
        productId: productId,
        watchProduct: getIt(),
        addToCart: getIt(),
      ),
    );
  }
}

/// Emits the product with the requested id from [products], or null.
class FakeWatchProductUseCase implements WatchProductUseCase {
  new([this.products = const [testCoconut]]);

  final List<ProductDetailVO> products;

  @override
  Stream<ProductDetailVO?> call(String id) =>
      Stream.value(products.where((p) => p.id == id).firstOrNull);
}

/// Accepts every add and remembers it.
class FakeAddToCartUseCase implements AddToCartUseCase {
  final List<AddToCartParams> added = [];

  @override
  Future<Result<void>> call(AddToCartParams params) async {
    added.add(params);
    return const Success(null);
  }
}
