import 'package:donuts/features/product/domain/params/add_to_cart_params.dart';
import 'package:donuts/features/product/domain/usecases/add_to_cart_use_case.dart';
import 'package:donuts/features/product/domain/usecases/watch_product_use_case.dart';
import 'package:donuts/features/product/domain/vo/product_detail_vo.dart';
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
void registerProductFakes(GetIt getIt) {}
