import 'dart:async';

import 'package:donuts/core/network/connectivity_cubit.dart';
import 'package:donuts/core/result/app_failure.dart';
import 'package:donuts/core/result/result.dart';
import 'package:donuts/core/sync/domain/sync_outcome.dart';
import 'package:donuts/core/sync/presentation/catalog_sync_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mocktail/mocktail.dart';

import '../../../helpers/fake_connectivity.dart';
import '../../../helpers/fakes.dart';
import '../../../helpers/home_harness.dart';

/// RefreshIndicator arms after a quarter of the viewport's height, and
/// the tall test surface is 3000 pt, so the pull is long.
const Offset _pull = Offset(0, 1200);

const String _refreshFailed = "Couldn't refresh. Showing saved data.";

void main() {
  late HomeStreams streams;
  late MockRefreshCatalogUseCase refresh;
  late ConnectivityCubit connectivity;
  late CatalogSyncCubit sync;

  // Connectivity is online before the sync cubit listens, so the only
  // refreshes are the ones a test starts.
  setUp(() async {
    streams = HomeStreams();
    refresh = MockRefreshCatalogUseCase();
    connectivity = ConnectivityCubit(
      FakeConnectivitySource(interfaceUp: true),
      FakeReachabilityProbe(),
    );
    await connectivity.start();
    sync = CatalogSyncCubit(
      refresh: refresh,
      connectivity: connectivity,
      now: DateTime.now,
    );
  });

  Future<void> pumpLoadedHome(WidgetTester tester) async {
    await pumpHomeScreen(
      tester,
      streams,
      connectivity: connectivity,
      sync: sync,
    );
    streams.emitAll();
    await tester.pumpAndSettle();
  }

  Future<void> pullToRefresh(WidgetTester tester) async {
    await tester.fling(find.byType(CustomScrollView), _pull, 1000);
    await tester.pumpAndSettle();
  }

  testWidgets('pull-to-refresh calls the catalog refresh once', (tester) async {
    when(refresh.call)
        .thenAnswer((_) async => const Success(SyncOutcome.updated));
    await pumpLoadedHome(tester);

    await pullToRefresh(tester);

    verify(refresh.call).called(1);
    expect(find.text(_refreshFailed), findsNothing);
  });

  testWidgets('a failed pull-to-refresh keeps the rows and shows one '
      'snackbar', (tester) async {
    when(refresh.call).thenAnswer((_) async => const Failure(NetworkFailure()));
    await pumpLoadedHome(tester);

    await pullToRefresh(tester);

    expect(find.text(_refreshFailed), findsOneWidget);
    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Popular'), findsOneWidget);
    expect(find.text('Mistletoe Romance box'), findsOneWidget);
    expect(find.text('We are now at Central Boulevard'), findsOneWidget);
  });

  testWidgets('a failed background refresh shows no snackbar', (tester) async {
    when(refresh.call).thenAnswer((_) async => const Failure(NetworkFailure()));
    await pumpLoadedHome(tester);

    await sync.refresh();
    await tester.pumpAndSettle();

    expect(find.byType(SnackBar), findsNothing);
    expect(find.text('Popular'), findsOneWidget);
  });

  testWidgets('a pull during a background refresh waits for it and reports '
      'its failure', (tester) async {
    final background = Completer<Result<SyncOutcome>>();
    when(refresh.call).thenAnswer((_) => background.future);
    await pumpLoadedHome(tester);
    unawaited(sync.refresh());
    await tester.pump();

    await tester.fling(find.byType(CustomScrollView), _pull, 1000);
    // Let the indicator snap into place and call onRefresh.
    for (var i = 0; i < 10; i++) {
      await tester.pump(const Duration(milliseconds: 100));
    }
    expect(find.byType(RefreshProgressIndicator), findsOneWidget);

    background.complete(const Failure(NetworkFailure()));
    await tester.pumpAndSettle();

    verify(refresh.call).called(1);
    expect(find.text(_refreshFailed), findsOneWidget);
  });
}
