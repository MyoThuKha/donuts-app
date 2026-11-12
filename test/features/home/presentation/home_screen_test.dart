import 'package:donuts/core/network/connectivity_cubit.dart';
import 'package:donuts/core/widgets/badges/discount_badge.dart';
import 'package:donuts/core/widgets/feedback/offline_banner.dart';
import 'package:donuts/core/widgets/feedback/section_empty_state.dart';
import 'package:donuts/core/widgets/feedback/section_error_state.dart';
import 'package:donuts/core/widgets/feedback/skeleton.dart';
import 'package:donuts/features/home/presentation/items/product_tile_item.dart';
import 'package:donuts/features/home/presentation/views/banner_carousel_view.dart';
import 'package:donuts/features/home/presentation/views/home_header_view.dart';
import 'package:donuts/features/home/presentation/views/shops_band_view.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

import '../../../helpers/fake_connectivity.dart';
import '../../../helpers/home_fixtures.dart';
import '../../../helpers/home_harness.dart';
import '../../../helpers/member_fakes.dart';

/// Long enough for every section's staggered entrance to finish, so its
/// semantics are on screen.
const Duration _entrance = Duration(seconds: 1);

Finder _inside<T>(Finder matching) =>
    find.descendant(of: find.byType(T), matching: matching);

void main() {
  late HomeStreams streams;

  setUp(() => streams = HomeStreams());

  testWidgets('each section shows a skeleton until its stream emits', (
    tester,
  ) async {
    await pumpHomeScreen(tester, streams);
    await tester.pump();

    expect(_inside<HomeHeaderView>(find.byType(Skeleton)), findsWidgets);
    expect(_inside<BannerCarouselView>(find.byType(Skeleton)), findsWidgets);
    expect(_inside<ShopsBandView>(find.byType(Skeleton)), findsWidgets);
    expect(find.byType(ProductTileItem), findsNothing);
    expect(find.byType(CircularProgressIndicator), findsNothing);
    expect(find.byType(SectionEmptyState), findsNothing);

    streams.banners.add(testBanners);
    await tester.pump();

    expect(_inside<BannerCarouselView>(find.byType(Skeleton)), findsNothing);
    expect(_inside<ShopsBandView>(find.byType(Skeleton)), findsWidgets);
  });

  testWidgets('the header shows the first name, Silver member and 500 points '
      'left to become Gold Member', (tester) async {
    await pumpHomeScreen(tester, streams);
    streams.member.add(testMemberSummary);
    await tester.pump(_entrance);

    expect(find.text('Ye Min'), findsOneWidget);
    expect(find.text('Silver member'), findsOneWidget);
    expect(find.text('500 points left to become Gold Member'), findsOneWidget);
    expect(find.bySemanticsLabel('2 notifications'), findsOneWidget);
  });

  testWidgets('sections show their titles and products', (tester) async {
    await pumpHomeScreen(tester, streams);
    streams.emitAll();
    await tester.pump();

    expect(find.text('Seasonal specials'), findsOneWidget);
    expect(find.text('Popular'), findsOneWidget);
    expect(find.text('Order again'), findsOneWidget);
    final mistletoe = find.ancestor(
      of: find.text('Mistletoe Romance box'),
      matching: find.byType(ProductTileItem),
    );
    expect(mistletoe, findsOneWidget);
    expect(
      find.descendant(of: mistletoe, matching: find.byType(DiscountBadge)),
      findsOneWidget,
    );
    expect(
      find.descendant(of: mistletoe, matching: find.text('50% off')),
      findsOneWidget,
    );
    expect(find.text('Dalgona Creamy Coffee'), findsNWidgets(2));
  });

  testWidgets('an empty section shows its empty message and the others still '
      'render', (tester) async {
    await pumpHomeScreen(tester, streams);
    streams
      ..member.add(testMemberSummary)
      ..banners.add(const [])
      ..sections.add([
        testHomeSections[0].copyWith(products: const []),
        ...testHomeSections.skip(1),
      ])
      ..shops.add(testShops);
    await tester.pump();

    expect(find.text('Nothing here yet.'), findsNWidgets(2));
    expect(
      _inside<BannerCarouselView>(find.byType(SectionEmptyState)),
      findsOneWidget,
    );
    expect(find.text('Seasonal specials'), findsOneWidget);
    expect(find.text('Mistletoe Romance box'), findsNothing);
    expect(find.text('Coconut Donut'), findsOneWidget);
    expect(find.text("J'Donuts Myaynigone"), findsOneWidget);
  });

  testWidgets('Retry on a failed section subscribes again', (tester) async {
    await pumpHomeScreen(tester, streams);
    streams
      ..member.add(testMemberSummary)
      ..banners.add(testBanners)
      ..shops.add(testShops)
      ..sections.addError(StateError('corrupt row'));
    await tester.pump(_entrance);

    expect(find.byType(SectionErrorState), findsOneWidget);
    expect(find.text("We couldn't load this section."), findsOneWidget);
    expect(find.text('We are now at Central Boulevard'), findsOneWidget);
    expect(streams.sectionSubscriptions, 1);

    await tester.tap(find.bySemanticsLabel('Try again'));
    await tester.pump();
    streams.sections.add(testHomeSections);
    await tester.pump();

    expect(streams.sectionSubscriptions, 2);
    expect(find.byType(SectionErrorState), findsNothing);
    expect(find.text('Popular'), findsOneWidget);
  });

  testWidgets('the shops band says there are 4 shops near you', (tester) async {
    await pumpHomeScreen(tester, streams);
    streams.emitAll();
    await tester.pump();

    expect(find.text("There are 4 J'Donut shops near you"), findsOneWidget);
    expect(find.text('Explore now'.toUpperCase()), findsOneWidget);
    expect(find.text('Order online'), findsNWidgets(4));
  });

  testWidgets('the offline banner shows while connectivity is offline', (
    tester,
  ) async {
    final connectivity = ConnectivityCubit(
      FakeConnectivitySource(),
      FakeReachabilityProbe(),
    );
    await pumpHomeScreen(tester, streams, connectivity: connectivity);
    streams.emitAll();
    await tester.pump();
    expect(
      tester.widget<OfflineBanner>(find.byType(OfflineBanner)).visible,
      isFalse,
    );

    await connectivity.start();
    await tester.pumpAndSettle();

    expect(connectivity.state, ConnectivityStatus.offline);
    expect(
      tester.widget<OfflineBanner>(find.byType(OfflineBanner)).visible,
      isTrue,
    );
    expect(find.text("You're offline. Showing saved data."), findsOneWidget);
  });
}
