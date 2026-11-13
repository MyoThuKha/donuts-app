import 'package:donuts/core/database/app_database.dart';
import 'package:donuts/features/cart/data/repositories/cart_repository_impl.dart';
import 'package:donuts/features/cart/domain/repositories/cart_repository.dart';
import 'package:donuts/features/cart/domain/usecases/add_to_cart_use_case.dart';
import 'package:get_it/get_it.dart';

/// The persistent cart.
void registerCartModule(GetIt getIt) {
  getIt
    ..registerLazySingleton<CartRepository>(
      () => CartRepositoryImpl(
        getIt<AppDatabase>().cartDao,
        now: getIt<DateTime Function()>(),
      ),
    )
    ..registerLazySingleton(() => AddToCartUseCase(getIt()));
}
