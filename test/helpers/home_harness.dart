import 'dart:async';

import 'package:donuts/core/di/locator.dart';
import 'package:donuts/core/network/connectivity_cubit.dart';
import 'package:donuts/core/result/result.dart';
import 'package:donuts/core/sync/domain/sync_outcome.dart';
import 'package:donuts/core/sync/presentation/catalog_sync_cubit.dart';
import 'package:donuts/features/auth/presentation/session/blocs/session_cubit.dart';
import 'package:donuts/features/home/domain/usecases/watch_banners_use_case.dart';
import 'package:donuts/features/home/domain/usecases/watch_home_sections_use_case.dart';
import 'package:donuts/features/home/domain/usecases/watch_shops_use_case.dart';
import 'package:donuts/features/home/domain/vo/banner_vo.dart';
import 'package:donuts/features/home/domain/vo/home_section_vo.dart';
import 'package:donuts/features/home/domain/vo/shop_vo.dart';
import 'package:donuts/features/home/presentation/blocs/home_cubit.dart';
import 'package:donuts/features/home/presentation/home_screen.dart';
import 'package:donuts/features/rewards/domain/usecases/watch_member_summary_use_case.dart';
import 'package:donuts/features/rewards/domain/vo/member_summary.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mocktail/mocktail.dart';

import 'fake_connectivity.dart';
import 'fakes.dart';
import 'home_fixtures.dart';
import 'member_fakes.dart';
import 'pump_app.dart';

class _MockMember extends Mock implements WatchMemberSummaryUseCase;

class _MockBanners extends Mock implements WatchBannersUseCase;

class _MockSections extends Mock implements WatchHomeSectionsUseCase;

class _MockShops extends Mock implements WatchShopsUseCase;

/// The four Home streams, driven by hand. Each subscription is counted so
/// a test can check that Retry subscribed again.
class HomeStreams {
  final StreamController<MemberSummary?> member = StreamController.broadcast();
  final StreamController<List<BannerVO>> banners = StreamController.broadcast();
  final StreamController<List<HomeSectionVO>> sections =
      StreamController.broadcast();
  final StreamController<List<ShopVO>> shops = StreamController.broadcast();
  int sectionSubscriptions = 0;

  HomeCubit cubit() {
    final memberUseCase = _MockMember();
    final bannersUseCase = _MockBanners();
    final sectionsUseCase = _MockSections();
    final shopsUseCase = _MockShops();
    when(memberUseCase.call).thenAnswer((_) => member.stream);
    when(bannersUseCase.call).thenAnswer((_) => banners.stream);
    when(sectionsUseCase.call).thenAnswer((_) {
      sectionSubscriptions++;
      return sections.stream;
    });
    when(shopsUseCase.call).thenAnswer((_) => shops.stream);
    return HomeCubit(
      member: memberUseCase,
      banners: bannersUseCase,
      sections: sectionsUseCase,
      shops: shopsUseCase,
    );
  }

  /// Emits the seed-shaped fixtures on every stream.
  void emitAll() {
    member.add(testMemberSummary);
    banners.add(testBanners);
    sections.add(testHomeSections);
    shops.add(testShops);
  }
}

/// A phone-wide but very tall surface, in logical pixels, so every Home
/// section is built at once.
const Size tallPhoneSurface = Size(430, 3000);

/// A 4.7" phone, in logical pixels.
const Size smallPhoneSurface = Size(375, 667);

/// Sizes the test view to [logicalSize] at a device pixel ratio of 3.
void useTallPhoneSurface(
  WidgetTester tester, {
  Size logicalSize = tallPhoneSurface,
}) {
  tester.view
    ..physicalSize = logicalSize * 3
    ..devicePixelRatio = 3;
  addTearDown(tester.view.reset);
}

/// Pumps [HomeScreen] with [streams] behind its cubit, the signed-in test
/// user, and the app-wide connectivity and catalog sync cubits.
Future<void> pumpHomeScreen(
  WidgetTester tester,
  HomeStreams streams, {
  ConnectivityCubit? connectivity,
  CatalogSyncCubit? sync,
  bool reduceMotion = false,
  Size surface = tallPhoneSurface,
}) async {
  useTallPhoneSurface(tester, logicalSize: surface);
  getIt.registerFactory(streams.cubit);
  addTearDown(getIt.reset);
  final connectivityCubit =
      connectivity ??
      ConnectivityCubit(FakeConnectivitySource(), FakeReachabilityProbe());
  final syncCubit = sync ?? _idleSync(connectivityCubit);
  final session = testSessionCubit()..signedIn(testUser);
  addTearDown(() async {
    await syncCubit.close();
    await connectivityCubit.close();
    await session.close();
  });
  await pumpThemed(
    tester,
    MultiBlocProvider(
      providers: [
        BlocProvider<SessionCubit>.value(value: session),
        BlocProvider.value(value: connectivityCubit),
        BlocProvider.value(value: syncCubit),
      ],
      child: Builder(
        builder: (context) => MediaQuery(
          data: MediaQuery.of(context)
              .copyWith(disableAnimations: reduceMotion),
          child: const HomeScreen(),
        ),
      ),
    ),
  );
}

CatalogSyncCubit _idleSync(ConnectivityCubit connectivity) {
  final refresh = MockRefreshCatalogUseCase();
  when(refresh.call)
      .thenAnswer((_) async => const Success(SyncOutcome.upToDate));
  return CatalogSyncCubit(
    refresh: refresh,
    connectivity: connectivity,
    now: DateTime.now,
  );
}
