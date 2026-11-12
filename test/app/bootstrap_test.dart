import 'package:donuts/app/bootstrap.dart';
import 'package:donuts/app/di/di.dart';
import 'package:donuts/core/database/app_database.dart';
import 'package:donuts/core/di/locator.dart';
import 'package:donuts/core/network/connectivity_cubit.dart';
import 'package:donuts/core/sync/presentation/catalog_sync_cubit.dart';
import 'package:donuts/core/sync/presentation/catalog_sync_state.dart';
import 'package:donuts/features/auth/presentation/session/blocs/session_cubit.dart';
import 'package:donuts/features/auth/presentation/session/blocs/session_state.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/fake_connectivity.dart';
import '../helpers/file_seed_source.dart';
import '../helpers/memory_session_store.dart';

void main() {
  tearDown(getIt.reset);

  test('bootstrap seeds the database, restores the session and starts '
      'connectivity', () async {
    final probe = FakeReachabilityProbe();
    await configureDependencies(
      database: AppDatabase.forTesting(NativeDatabase.memory()),
      sessionStore: MemorySessionStore(),
      authLatency: Duration.zero,
      seedSource: FileSeedSource(),
      connectivitySource: FakeConnectivitySource(),
      probe: probe,
    );

    await bootstrap();
    await pumpEventQueue();

    final db = getIt<AppDatabase>();
    expect(await db.select(db.productsTable).get(), hasLength(8));
    expect((await db.memberDao.watchProfile().first)?.totalPoints, 680000);
    expect(getIt<SessionCubit>().state, isA<SessionSignedOut>());
    expect(getIt<ConnectivityCubit>().state, ConnectivityStatus.offline);
    expect(getIt<CatalogSyncCubit>().state.status, CatalogSyncStatus.idle);
    expect(probe.calls, 0);
  });
}
