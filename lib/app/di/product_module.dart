import 'package:donuts/core/database/app_database.dart';
import 'package:donuts/features/product/data/repositories/product_repository_impl.dart';
import 'package:donuts/features/product/domain/repositories/product_repository.dart';
import 'package:donuts/features/product/domain/usecases/watch_product_use_case.dart';
import 'package:donuts/features/product/presentation/blocs/product_detail_cubit.dart';
import 'package:get_it/get_it.dart';

/// Product detail. Its Add to cart comes from the cart module.
void registerProductModule(GetIt getIt) {
  getIt
    ..registerLazySingleton<ProductRepository>(
      () => ProductRepositoryImpl(getIt<AppDatabase>().catalogDao),
    )
    ..registerLazySingleton(() => WatchProductUseCase(getIt()))
    // A factory: each Product detail screen gets its own cubit for its id.
    ..registerFactoryParam<ProductDetailCubit, String, void>(
      (productId, _) => ProductDetailCubit(
        productId: productId,
        watchProduct: getIt(),
        addToCart: getIt(),
      ),
    );
}
