import 'dart:async';

import 'package:donuts/core/di/locator.dart';
import 'package:donuts/core/l10n/language_cubit.dart';
import 'package:donuts/core/network/connectivity_cubit.dart';
import 'package:donuts/core/result/result.dart';
import 'package:donuts/core/storage/fresh_install_cleanup.dart';
import 'package:donuts/core/sync/presentation/catalog_sync_cubit.dart';
import 'package:donuts/core/sync/presentation/seed_cubit.dart';
import 'package:donuts/features/auth/presentation/session/blocs/session_cubit.dart';
import 'package:flutter/foundation.dart';

/*
 Runs once before the first frame, after `configureDependencies`.
 1. Seeds the database on first launch. A failed seed stays in
    `SeedCubit`, so Home shows an error with Try again.
 2. On a new install, clears the session and language an earlier install
    left in the iOS keychain. A failure is reported and the launch goes on,
    because the session restore still drops a user the database lacks.
 3. Restores the session, so the router's first redirect is right, and
    the language, so the first frame is already in it.
 4. Creates the sync cubit, so it hears the first online status, then
    starts connectivity without waiting for the network probe.
*/
Future<void> bootstrap() async {
  await getIt<SeedCubit>().seed();

  if (await getIt<FreshInstallCleanup>().run() case Failure(:final failure)) {
    FlutterError.reportError(
      FlutterErrorDetails(
        exception: failure,
        stack: failure.stackTrace,
        library: 'bootstrap',
        context: ErrorDescription('while clearing an earlier install'),
      ),
    );
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
