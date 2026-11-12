import 'dart:async';

import 'package:donuts/core/network/connectivity_cubit.dart';
import 'package:donuts/core/result/app_failure.dart';
import 'package:donuts/core/result/result.dart';
import 'package:donuts/core/sync/domain/sync_outcome.dart';
import 'package:donuts/core/sync/domain/usecases/refresh_catalog_use_case.dart';
import 'package:donuts/core/sync/presentation/catalog_sync_cubit.dart';
import 'package:donuts/core/sync/presentation/catalog_sync_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../helpers/fake_connectivity.dart';

class _MockRefresh extends Mock implements RefreshCatalogUseCase;

final _syncedAt = DateTime.utc(2026, 11, 12, 9);

void main() {
  late _MockRefresh refresh;
  late FakeConnectivitySource source;
  late ConnectivityCubit connectivity;

  CatalogSyncCubit build() => CatalogSyncCubit(
    refresh: refresh,
    connectivity: connectivity,
    now: () => _syncedAt,
  );

  setUp(() {
    refresh = _MockRefresh();
    source = FakeConnectivitySource();
    connectivity = ConnectivityCubit(source, FakeReachabilityProbe());
  });
  tearDown(() => connectivity.close());

  test('going online triggers a refresh and ends succeeded', () async {
    when(refresh.call)
        .thenAnswer((_) async => const Success(SyncOutcome.updated));
    source.interfaceUp = true;
    final cubit = build();
    final states = <CatalogSyncState>[];
    final sub = cubit.stream.listen(states.add);

    await connectivity.start();
    await pumpEventQueue();

    expect(states.map((s) => s.status), [
      CatalogSyncStatus.syncing,
      CatalogSyncStatus.succeeded,
    ]);
    expect(cubit.state.lastSyncedAt, _syncedAt);
    expect(cubit.state.outcome, SyncOutcome.updated);
    await sub.cancel();
    await cubit.close();
  });

  test(
    'a reconnect during a running refresh starts no second refresh',
    () async {
      final pending = Completer<Result<SyncOutcome>>();
      when(refresh.call).thenAnswer((_) => pending.future);
      source.interfaceUp = true;
      final cubit = build();

      await connectivity.start();
      source.change(interfaceUp: false);
      await pumpEventQueue();
      source.change(interfaceUp: true);
      await pumpEventQueue();
      pending.complete(const Success(SyncOutcome.updated));
      await pumpEventQueue();

      verify(refresh.call).called(1);
      expect(cubit.state.status, CatalogSyncStatus.succeeded);
      await cubit.close();
    },
  );

  test(
    'refresh while offline fails with NetworkFailure without calling the use '
    'case',
    () async {
      final cubit = build();
      await connectivity.start();

      await cubit.refresh();

      expect(cubit.state.status, CatalogSyncStatus.failed);
      expect(cubit.state.failure, isA<NetworkFailure>());
      verifyNever(refresh.call);
      await cubit.close();
    },
  );

  test('a failed refresh keeps lastSyncedAt', () async {
    final answers = <Result<SyncOutcome>>[
      const Success(SyncOutcome.updated),
      const Failure(TimeoutFailure()),
    ];
    when(refresh.call).thenAnswer((_) async => answers.removeAt(0));
    source.interfaceUp = true;
    final cubit = build();
    await connectivity.start();
    await pumpEventQueue();

    await cubit.refresh();

    expect(cubit.state.status, CatalogSyncStatus.failed);
    expect(cubit.state.failure, isA<TimeoutFailure>());
    expect(cubit.state.lastSyncedAt, _syncedAt);
    await cubit.close();
  });
}
