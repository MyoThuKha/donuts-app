import 'package:donuts/app/bootstrap.dart';
import 'package:donuts/app/di/di.dart';
import 'package:donuts/core/database/app_database.dart';
import 'package:donuts/core/di/locator.dart';
import 'package:donuts/features/home/presentation/blocs/home_cubit.dart';
import 'package:donuts/features/home/presentation/blocs/section_state.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/fake_connectivity.dart';
import '../../helpers/file_seed_source.dart';
import '../../helpers/memory_session_store.dart';

void main() {
  tearDown(getIt.reset);

  test('registerHomeModule gives a new HomeCubit each time, reading the '
      'seeded catalog and member', () async {
    await configureDependencies(
      database: AppDatabase.forTesting(NativeDatabase.memory()),
      sessionStore: MemorySessionStore(),
      authLatency: Duration.zero,
      seedSource: FileSeedSource(),
      connectivitySource: FakeConnectivitySource(),
      probe: FakeReachabilityProbe(),
    );
    await bootstrap();

    final cubit = getIt<HomeCubit>()..start();
    addTearDown(cubit.close);
    await pumpEventQueue();

    expect(getIt<HomeCubit>(), isNot(same(cubit)));
    expect(cubit.state.member, isA<SectionReady<Object?>>());
    expect(cubit.state.banners, isA<SectionReady<Object?>>());
    expect(cubit.state.sections, isA<SectionReady<Object?>>());
    expect(cubit.state.shops, isA<SectionReady<Object?>>());
  });
}
