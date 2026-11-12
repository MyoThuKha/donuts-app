import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:donuts/features/home/domain/usecases/watch_banners_use_case.dart';
import 'package:donuts/features/home/domain/usecases/watch_home_sections_use_case.dart';
import 'package:donuts/features/home/domain/usecases/watch_shops_use_case.dart';
import 'package:donuts/features/home/domain/vo/banner_vo.dart';
import 'package:donuts/features/home/domain/vo/home_section_vo.dart';
import 'package:donuts/features/home/domain/vo/shop_vo.dart';
import 'package:donuts/features/home/presentation/blocs/home_cubit.dart';
import 'package:donuts/features/home/presentation/blocs/home_state.dart';
import 'package:donuts/features/home/presentation/blocs/section_state.dart';
import 'package:donuts/features/rewards/domain/usecases/watch_member_summary_use_case.dart';
import 'package:donuts/features/rewards/domain/vo/member_summary.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/home_fixtures.dart';
import '../../../../helpers/member_fakes.dart';

class _MockMember extends Mock implements WatchMemberSummaryUseCase;

class _MockBanners extends Mock implements WatchBannersUseCase;

class _MockSections extends Mock implements WatchHomeSectionsUseCase;

class _MockShops extends Mock implements WatchShopsUseCase;

void main() {
  late StreamController<MemberSummary?> member;
  late StreamController<List<BannerVO>> banners;
  late StreamController<List<HomeSectionVO>> sections;
  late StreamController<List<ShopVO>> shops;
  late int bannerSubscriptions;

  setUp(() {
    member = StreamController.broadcast();
    banners = StreamController.broadcast();
    sections = StreamController.broadcast();
    shops = StreamController.broadcast();
    bannerSubscriptions = 0;
  });

  HomeCubit build() {
    final memberUseCase = _MockMember();
    final bannersUseCase = _MockBanners();
    final sectionsUseCase = _MockSections();
    final shopsUseCase = _MockShops();
    when(memberUseCase.call).thenAnswer((_) => member.stream);
    when(bannersUseCase.call).thenAnswer((_) {
      bannerSubscriptions++;
      return banners.stream;
    });
    when(sectionsUseCase.call).thenAnswer((_) => sections.stream);
    when(shopsUseCase.call).thenAnswer((_) => shops.stream);
    return HomeCubit(
      member: memberUseCase,
      banners: bannersUseCase,
      sections: sectionsUseCase,
      shops: shopsUseCase,
    );
  }

  test('starts with every section loading', () {
    final cubit = build()..start();
    addTearDown(cubit.close);

    expect(cubit.state, const HomeState());
    expect(cubit.state.member, isA<SectionLoading<MemberSummary>>());
    expect(cubit.state.banners, isA<SectionLoading<List<BannerVO>>>());
    expect(cubit.state.sections, isA<SectionLoading<List<HomeSectionVO>>>());
    expect(cubit.state.shops, isA<SectionLoading<List<ShopVO>>>());
  });

  blocTest<HomeCubit, HomeState>(
    "each stream's first list makes its section ready",
    build: build,
    act: (cubit) async {
      cubit.start();
      member.add(testMemberSummary);
      banners.add(testBanners);
      sections.add(testHomeSections);
      shops.add(testShops);
    },
    verify: (cubit) => expect(
      cubit.state,
      HomeState(
        member: SectionReady(testMemberSummary),
        banners: SectionReady(testBanners),
        sections: SectionReady(testHomeSections),
        shops: SectionReady(testShops),
      ),
    ),
  );

  blocTest<HomeCubit, HomeState>(
    'an empty banner list makes banners empty',
    build: build,
    act: (cubit) async {
      cubit.start();
      banners.add(const []);
    },
    expect: () => [const HomeState(banners: SectionEmpty())],
  );

  blocTest<HomeCubit, HomeState>(
    'a missing member summary makes the member section empty',
    build: build,
    act: (cubit) async {
      cubit.start();
      member.add(null);
    },
    expect: () => [const HomeState(member: SectionEmpty())],
  );

  blocTest<HomeCubit, HomeState>(
    'a banner stream error marks only banners as failed',
    build: build,
    act: (cubit) async {
      cubit.start();
      shops.add(testShops);
      await pumpEventQueue();
      banners.addError(StateError('corrupt row'));
    },
    expect: () => [
      HomeState(shops: SectionReady(testShops)),
      HomeState(banners: const SectionFailed(), shops: SectionReady(testShops)),
    ],
  );

  blocTest<HomeCubit, HomeState>(
    'retry banners subscribes again and recovers',
    build: build,
    act: (cubit) async {
      cubit.start();
      banners.addError(StateError('corrupt row'));
      await pumpEventQueue();
      cubit.retry(HomeSectionId.banners);
      banners.add(testBanners);
    },
    expect: () => [
      const HomeState(banners: SectionFailed()),
      const HomeState(),
      HomeState(banners: SectionReady(testBanners)),
    ],
    verify: (_) => expect(bannerSubscriptions, 2),
  );

  test('close cancels all subscriptions', () async {
    final cubit = build()..start();
    expect(
      [member, banners, sections, shops].map((c) => c.hasListener),
      everyElement(isTrue),
    );

    await cubit.close();

    expect(
      [member, banners, sections, shops].map((c) => c.hasListener),
      everyElement(isFalse),
    );
  });
}
