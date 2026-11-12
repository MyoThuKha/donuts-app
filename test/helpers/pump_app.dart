import 'package:donuts/app/router/app_router.dart';
import 'package:donuts/core/di/locator.dart';
import 'package:donuts/core/l10n/l10n.dart';
import 'package:donuts/core/network/connectivity_cubit.dart';
import 'package:donuts/core/result/result.dart';
import 'package:donuts/core/router/app_routes.dart';
import 'package:donuts/core/sync/domain/sync_outcome.dart';
import 'package:donuts/core/sync/presentation/catalog_sync_cubit.dart';
import 'package:donuts/core/theme/app_theme.dart';
import 'package:donuts/features/auth/presentation/session/blocs/session_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mocktail/mocktail.dart';

import 'fake_connectivity.dart';
import 'fakes.dart';
import 'feature_fakes.dart';

/// Pumps the real router with [session] and the app-wide cubits provided
/// above it, the way `DonutsApp` does.
///
/// Feature screens read get_it, so it registers each feature's fakes that a
/// test hasn't registered itself, and resets get_it after the test.
Future<void> pumpRouterApp(
  WidgetTester tester, {
  required SessionCubit session,
  String initialLocation = AppRoutes.home,
}) async {
  registerFeatureFakes(getIt);
  addTearDown(getIt.reset);
  final router = buildAppRouter(
    session: session,
    initialLocation: initialLocation,
  );
  addTearDown(router.dispose);
  final connectivity = ConnectivityCubit(
    FakeConnectivitySource(),
    FakeReachabilityProbe(),
  );
  final refresh = MockRefreshCatalogUseCase();
  when(refresh.call)
      .thenAnswer((_) async => const Success(SyncOutcome.upToDate));
  final sync = CatalogSyncCubit(
    refresh: refresh,
    connectivity: connectivity,
    now: DateTime.now,
  );
  addTearDown(() async {
    await sync.close();
    await connectivity.close();
  });
  await tester.pumpWidget(
    MultiBlocProvider(
      providers: [
        BlocProvider.value(value: session),
        BlocProvider.value(value: connectivity),
        BlocProvider.value(value: sync),
      ],
      child: MaterialApp.router(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        theme: AppTheme.light(),
        routerConfig: router,
      ),
    ),
  );
  await tester.pumpAndSettle();
}

/// Pumps [child] with the app theme and localisations.
Future<void> pumpThemed(WidgetTester tester, Widget child) async {
  await tester.pumpWidget(
    MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: AppTheme.light(),
      home: Scaffold(body: child),
    ),
  );
}
