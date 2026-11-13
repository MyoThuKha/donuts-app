import 'package:donuts/core/database/app_database.dart';
import 'package:donuts/features/home/data/repositories/home_repository_impl.dart';
import 'package:donuts/features/home/domain/repositories/home_repository.dart';
import 'package:donuts/features/home/domain/usecases/watch_banners_use_case.dart';
import 'package:donuts/features/home/domain/usecases/watch_home_sections_use_case.dart';
import 'package:donuts/features/home/domain/usecases/watch_shops_use_case.dart';
import 'package:donuts/features/home/presentation/blocs/home_cubit.dart';
import 'package:get_it/get_it.dart';

/// Home's repository, use cases and cubit. The cubit reads the member
/// summary that `registerRewardsModule` registers.
void registerHomeModule(GetIt getIt) {
  getIt
    ..registerLazySingleton<HomeRepository>(
      () => HomeRepositoryImpl(getIt<AppDatabase>().catalogDao),
    )
    ..registerLazySingleton(() => WatchBannersUseCase(getIt()))
    ..registerLazySingleton(() => WatchHomeSectionsUseCase(getIt()))
    ..registerLazySingleton(() => WatchShopsUseCase(getIt()))
    ..registerFactory(
      () => HomeCubit(
        member: getIt(),
        banners: getIt(),
        sections: getIt(),
        shops: getIt(),
        clearRewardClaims: getIt(),
      ),
    );
}
