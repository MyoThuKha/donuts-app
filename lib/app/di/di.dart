import 'package:donuts/app/di/auth_module.dart';
import 'package:donuts/app/di/cart_module.dart';
import 'package:donuts/app/di/core_module.dart';
import 'package:donuts/app/di/home_module.dart';
import 'package:donuts/app/di/product_module.dart';
import 'package:donuts/app/di/rewards_module.dart';
import 'package:donuts/app/di/settings_module.dart';
import 'package:donuts/app/di/sync_module.dart';
import 'package:donuts/core/database/app_database.dart';
import 'package:donuts/core/di/locator.dart';
import 'package:donuts/core/network/api_config.dart';
import 'package:donuts/core/network/connectivity_source.dart';
import 'package:donuts/core/network/reachability_probe.dart';
import 'package:donuts/core/storage/language_store.dart';
import 'package:donuts/core/storage/session_store.dart';
import 'package:donuts/core/sync/data/seed_source.dart';
import 'package:donuts/features/auth/data/repositories/fake_auth_repository.dart';

/// Registers every module on [getIt]. Tests pass in-memory replacements.
Future<void> configureDependencies({
  AppDatabase? database,
  SessionStore? sessionStore,
  LanguageStore? languageStore,
  Duration authLatency = FakeAuthRepository.defaultLatency,
  ApiConfig? apiConfig,
  SeedSource? seedSource,
  ConnectivitySource? connectivitySource,
  ReachabilityProbe? probe,
}) async {
  await getIt.reset();
  registerCoreModule(
    getIt,
    database: database,
    sessionStore: sessionStore,
    languageStore: languageStore,
  );
  registerAuthModule(getIt, latency: authLatency);
  registerSyncModule(
    getIt,
    config: apiConfig ?? ApiConfig.fromEnvironment(),
    seedSource: seedSource,
    connectivitySource: connectivitySource,
    probe: probe,
  );
  registerHomeModule(getIt);
  registerCartModule(getIt);
  registerProductModule(getIt);
  registerRewardsModule(getIt);
  registerSettingsModule(getIt);
}
