import 'package:donuts/app/di/auth_module.dart';
import 'package:donuts/app/di/core_module.dart';
import 'package:donuts/core/database/app_database.dart';
import 'package:donuts/core/di/locator.dart';
import 'package:donuts/core/storage/session_store.dart';
import 'package:donuts/features/auth/data/repositories/fake_auth_repository.dart';

/// Registers every module on [getIt]. Tests pass in-memory replacements.
Future<void> configureDependencies({
  AppDatabase? database,
  SessionStore? sessionStore,
  Duration authLatency = FakeAuthRepository.defaultLatency,
}) async {
  await getIt.reset();
  registerCoreModule(getIt, database: database, sessionStore: sessionStore);
  registerAuthModule(getIt, latency: authLatency);
}
