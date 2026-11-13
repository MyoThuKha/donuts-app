import 'dart:async';

import 'package:donuts/core/di/locator.dart';
import 'package:donuts/core/l10n/language_cubit.dart';
import 'package:donuts/core/network/connectivity_cubit.dart';
import 'package:donuts/core/result/result.dart';
import 'package:donuts/core/sync/domain/usecases/seed_local_data_use_case.dart';
import 'package:donuts/core/sync/presentation/catalog_sync_cubit.dart';
import 'package:donuts/features/auth/presentation/session/blocs/session_cubit.dart';
import 'package:flutter/foundation.dart';

/*
 Runs once before the first frame, after `configureDependencies`.
 1. Seeds the database on first launch. A failed seed is logged and the
    app starts with empty sections.
 2. Restores the session, so the router's first redirect is right, and
    the language, so the first frame is already in it.
 3. Creates the sync cubit, so it hears the first online status, then
    starts connectivity without waiting for the network probe.
*/
Future<void> bootstrap() async {
  if (await getIt<SeedLocalDataUseCase>()() case Failure(:final failure)) {
    debugPrint('Seeding failed: ${failure.runtimeType} ${failure.error}');
  }

  await getIt<SessionCubit>().restore();
  await getIt<LanguageCubit>().restore();
  final sync = getIt<CatalogSyncCubit>();
  final connectivity = getIt<ConnectivityCubit>();

  if (kDebugMode) {
    sync.stream.listen((state) => debugPrint('Catalog sync: $state'));
    connectivity.stream.listen((status) => debugPrint('Network: $status'));
  }

  unawaited(connectivity.start());
}
