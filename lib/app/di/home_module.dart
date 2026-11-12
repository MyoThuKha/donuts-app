import 'package:donuts/core/database/app_database.dart';
import 'package:donuts/features/home/data/repositories/home_repository_impl.dart';
import 'package:donuts/features/home/domain/repositories/home_repository.dart';
import 'package:donuts/features/home/domain/usecases/watch_banners_use_case.dart';
import 'package:donuts/features/home/domain/usecases/watch_home_sections_use_case.dart';
import 'package:donuts/features/home/domain/usecases/watch_shops_use_case.dart';
import 'package:get_it/get_it.dart';

/// Home's repository and use cases.
void registerHomeModule(GetIt getIt) {
  getIt
    ..registerLazySingleton<HomeRepository>(
      () => HomeRepositoryImpl(getIt<AppDatabase>().catalogDao),
    )
    ..registerLazySingleton(() => WatchBannersUseCase(getIt()))
    ..registerLazySingleton(() => WatchHomeSectionsUseCase(getIt()))
    ..registerLazySingleton(() => WatchShopsUseCase(getIt()));
}
