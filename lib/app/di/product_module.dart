import 'package:donuts/core/database/app_database.dart';
import 'package:donuts/features/product/data/repositories/cart_repository_impl.dart';
import 'package:donuts/features/product/data/repositories/product_repository_impl.dart';
import 'package:donuts/features/product/domain/repositories/cart_repository.dart';
import 'package:donuts/features/product/domain/repositories/product_repository.dart';
import 'package:donuts/features/product/domain/usecases/add_to_cart_use_case.dart';
import 'package:donuts/features/product/domain/usecases/watch_product_use_case.dart';
import 'package:get_it/get_it.dart';

/// Product detail and the persistent cart.
void registerProductModule(GetIt getIt) {
  getIt
    ..registerLazySingleton<ProductRepository>(
      () => ProductRepositoryImpl(getIt<AppDatabase>().catalogDao),
    )
    ..registerLazySingleton<CartRepository>(
      () => CartRepositoryImpl(
        getIt<AppDatabase>().cartDao,
        now: getIt<DateTime Function()>(),
      ),
    )
    ..registerLazySingleton(() => WatchProductUseCase(getIt()))
    ..registerLazySingleton(() => AddToCartUseCase(getIt()));
}
