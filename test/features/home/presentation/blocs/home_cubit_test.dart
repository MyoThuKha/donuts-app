import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:donuts/core/state/section_state.dart';
import 'package:donuts/features/home/domain/usecases/watch_banners_use_case.dart';
import 'package:donuts/features/home/domain/usecases/watch_home_sections_use_case.dart';
import 'package:donuts/features/home/domain/usecases/watch_section_products_use_case.dart';
import 'package:donuts/features/home/domain/usecases/watch_shops_use_case.dart';
import 'package:donuts/features/home/domain/vo/banner_vo.dart';
import 'package:donuts/features/home/domain/vo/home_product_vo.dart';
import 'package:donuts/features/home/domain/vo/home_section_vo.dart';
import 'package:donuts/features/home/domain/vo/shop_vo.dart';
import 'package:donuts/features/home/presentation/blocs/home_cubit.dart';
import 'package:donuts/features/home/presentation/blocs/home_state.dart';
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

class _MockSectionProducts extends Mock implements WatchSectionProductsUseCase;

void main() {
  late StreamController<MemberSummary?> member;
  late StreamController<List<BannerVO>> banners;
  late StreamController<List<HomeSectionVO>> sections;
  late StreamController<List<ShopVO>> shops;
  late int bannerSubscriptions;
  late Map<String, StreamController<List<HomeProductVO>>> rows;
  late Map<String, int> rowSubscriptions;

  StreamController<List<HomeProductVO>> row(String id) =>
      rows.putIfAbsent(id, StreamController.broadcast);

  setUp(() {
    rows = {};
    rowSubscriptions = {};
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
    final productsUseCase = _MockSectionProducts();
    when(() => productsUseCase(any())).thenAnswer((invocation) {
      final id = invocation.positionalArguments.single as String;
      rowSubscriptions[id] = (rowSubscriptions[id] ?? 0) + 1;
      return row(id).stream;
    });
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
      sectionProducts: productsUseCase,
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
      await pumpEventQueue();
      for (final MapEntry(:key, :value) in testSectionProducts.entries) {
        row(key).add(value);
      }
    },
    verify: (cubit) => expect(
      cubit.state,
      HomeState(
        member: SectionReady(testMemberSummary),
        banners: SectionReady(testBanners),
        sections: const SectionReady(testHomeSections),
        shops: SectionReady(testShops),
        rows: {
          for (final MapEntry(:key, :value) in testSectionProducts.entries)
            key: SectionReady(value),
        },
      ),
    ),
  );

  blocTest<HomeCubit, HomeState>(
    'each row loads until its own products arrive',
    build: build,
    act: (cubit) async {
      cubit.start();
      sections.add(testHomeSections);
      await pumpEventQueue();
      row('popular').add(testSectionProducts['popular']!);
      row('seasonal').add(const []);
    },
    verify: (cubit) {
      expect(cubit.state.row('popular'), isA<SectionReady<Object?>>());
      expect(cubit.state.row('seasonal'), isA<SectionEmpty<Object?>>());
      expect(cubit.state.row('order_again'), isA<SectionLoading<Object?>>());
    },
  );

  blocTest<HomeCubit, HomeState>(
    'a row error fails only that row, and retryRow recovers it',
    build: build,
    act: (cubit) async {
      cubit.start();
      sections.add(testHomeSections);
      await pumpEventQueue();
      row('order_again').add(testSectionProducts['order_again']!);
      row('popular').addError(StateError('corrupt row'));
      await pumpEventQueue();
      expect(cubit.state.row('popular'), isA<SectionFailed<Object?>>());
      expect(cubit.state.row('order_again'), isA<SectionReady<Object?>>());
      cubit.retryRow('popular');
      row('popular').add(testSectionProducts['popular']!);
    },
    errors: () => [isA<StateError>()],
    verify: (cubit) {
      expect(cubit.state.row('popular'), isA<SectionReady<Object?>>());
      expect(rowSubscriptions['popular'], 2);
      expect(rowSubscriptions['order_again'], 1);
    },
  );

  blocTest<HomeCubit, HomeState>(
    'a row that leaves the catalog is dropped and no longer followed',
    build: build,
    act: (cubit) async {
      cubit.start();
      sections.add(testHomeSections);
      await pumpEventQueue();
      sections.add(testHomeSections.skip(1).toList());
      await pumpEventQueue();
      // Checked here: blocTest closes the cubit before verify.
      expect(row('seasonal').hasListener, isFalse);
      expect(row('popular').hasListener, isTrue);
    },
    verify: (cubit) {
      expect(cubit.state.rows.keys, ['popular', 'order_again']);
      expect(rowSubscriptions['popular'], 1);
    },
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
    errors: () => [isA<StateError>()],
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
    errors: () => [isA<StateError>()],
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
