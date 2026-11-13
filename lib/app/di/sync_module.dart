import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:donuts/core/network/api_config.dart';
import 'package:donuts/core/network/connectivity_cubit.dart';
import 'package:donuts/core/network/connectivity_source.dart';
import 'package:donuts/core/network/dio_factory.dart';
import 'package:donuts/core/network/reachability_probe.dart';
import 'package:donuts/core/sync/data/catalog_importer.dart';
import 'package:donuts/core/sync/data/catalog_remote_data_source.dart';
import 'package:donuts/core/sync/data/catalog_sync_repository_impl.dart';
import 'package:donuts/core/sync/data/seed_source.dart';
import 'package:donuts/core/sync/domain/catalog_sync_repository.dart';
import 'package:donuts/core/sync/domain/usecases/refresh_catalog_use_case.dart';
import 'package:donuts/core/sync/domain/usecases/seed_local_data_use_case.dart';
import 'package:donuts/core/sync/presentation/catalog_sync_cubit.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';

/// Seeding, the mock API, connectivity and background refresh. Tests pass
/// fakes for the seed files and the network checks.
void registerSyncModule(
  GetIt getIt, {
  required ApiConfig config,
  SeedSource? seedSource,
  ConnectivitySource? connectivitySource,
  ReachabilityProbe? probe,
}) {
  getIt
    ..registerLazySingleton<Dio>(
      () => buildApiDio(config),
      dispose: (dio) => dio.close(),
    )
    ..registerLazySingleton(() => CatalogRemoteDataSource(getIt()))
    ..registerLazySingleton(
      () => CatalogImporter(getIt(), now: getIt(), imageBase: config.baseUri),
    )
    ..registerLazySingleton<SeedSource>(
      () => seedSource ?? AssetSeedSource(rootBundle),
    )
    ..registerLazySingleton<CatalogSyncRepository>(
      () => CatalogSyncRepositoryImpl(
        seed: getIt(),
        remote: getIt(),
        importer: getIt(),
      ),
    )
    ..registerLazySingleton(() => SeedLocalDataUseCase(getIt()))
    ..registerLazySingleton(() => RefreshCatalogUseCase(getIt()));
  _registerConnectivity(getIt, config, connectivitySource, probe);
}

void _registerConnectivity(
  GetIt getIt,
  ApiConfig config,
  ConnectivitySource? connectivitySource,
  ReachabilityProbe? probe,
) {
  getIt
    ..registerLazySingleton<ConnectivitySource>(
      () => connectivitySource ?? PlusConnectivitySource(Connectivity()),
    )
    ..registerLazySingleton<ReachabilityProbe>(
      () => probe ?? HeadReachabilityProbe(buildProbeDio(), config.catalogUri),
    )
    ..registerLazySingleton(
      () => ConnectivityCubit(getIt(), getIt()),
      dispose: (cubit) => cubit.close(),
    )
    ..registerLazySingleton(
      () => CatalogSyncCubit(
        refresh: getIt(),
        connectivity: getIt(),
        now: getIt(),
      ),
      dispose: (cubit) => cubit.close(),
    );
}
