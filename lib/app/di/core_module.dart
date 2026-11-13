import 'package:donuts/core/database/app_database.dart';
import 'package:donuts/core/l10n/language_cubit.dart';
import 'package:donuts/core/storage/language_store.dart';
import 'package:donuts/core/storage/session_store.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

void registerCoreModule(
  GetIt getIt, {
  AppDatabase? database,
  SessionStore? sessionStore,
  LanguageStore? languageStore,
}) {
  getIt
    ..registerLazySingleton<AppDatabase>(
      () => database ?? AppDatabase(),
      dispose: (db) => db.close(),
    )
    ..registerLazySingleton<SessionStore>(
      () => sessionStore ?? const SecureSessionStore(FlutterSecureStorage()),
    )
    ..registerLazySingleton<LanguageStore>(
      () => languageStore ?? const SecureLanguageStore(FlutterSecureStorage()),
    )
    ..registerLazySingleton(
      () => LanguageCubit(getIt()),
      dispose: (cubit) => cubit.close(),
    )
    ..registerLazySingleton<DateTime Function()>(() => DateTime.now);
}
