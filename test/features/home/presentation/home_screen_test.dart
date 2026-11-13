import 'dart:io';

import 'package:donuts/core/network/connectivity_cubit.dart';
import 'package:donuts/core/theme/donuts_colors.dart';
import 'package:donuts/core/widgets/badges/discount_badge.dart';
import 'package:donuts/core/widgets/buttons/circle_filled_button.dart';
import 'package:donuts/core/widgets/buttons/pill_button.dart';
import 'package:donuts/core/widgets/buttons/text_button.dart';
import 'package:donuts/core/widgets/feedback/offline_banner.dart';
import 'package:donuts/core/widgets/feedback/section_empty_state.dart';
import 'package:donuts/core/widgets/feedback/section_error_state.dart';
import 'package:donuts/core/widgets/feedback/skeleton.dart';
import 'package:donuts/core/widgets/images/network_image.dart';
import 'package:donuts/features/home/presentation/home_assets.dart';
import 'package:donuts/features/home/presentation/home_dimens.dart';
import 'package:donuts/features/home/presentation/items/banner_item.dart';
import 'package:donuts/features/home/presentation/items/product_tile_item.dart';
import 'package:donuts/features/home/presentation/views/banner_carousel_view.dart';
import 'package:donuts/features/home/presentation/views/home_header_view.dart';
import 'package:donuts/features/home/presentation/views/member_panel_view.dart';
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

  /// The asset behind the member panel, or null when it shows none.
  String? backdropAsset(WidgetTester tester) => tester
      .widgetList<DecoratedBox>(
        _inside<MemberPanelView>(find.byType(DecoratedBox)),
      )
      .map((box) => box.decoration)
      .whereType<BoxDecoration>()
      .map((decoration) => decoration.image?.image)
      .whereType<AssetImage>()
      .map((image) => image.assetName)
      .lastOrNull;

  testWidgets('the panel is plain blue until the member loads, then shows '
      'the backdrop of their tier', (tester) async {
    await pumpHomeScreen(tester, streams);
    await tester.pump();
    expect(backdropAsset(tester), isNull);
    expect(
      _inside<MemberPanelView>(
        find.byWidgetPredicate(
          (w) => w is ColoredBox && w.color == DonutsColors.light.primary,
        ),
      ),
      findsOneWidget,
    );

    streams.member.add(testMemberSummary);
    await tester.pump(_entrance);
    expect(backdropAsset(tester), HomeAssets.headerBackdrop('silver'));
  });

  test('each tier has its own backdrop, and others have none', () {
    final tiers = ['silver', 'gold', 'platinum'];
    final assets = {for (final id in tiers) HomeAssets.headerBackdrop(id)};
    expect(assets, hasLength(tiers.length));
    expect(assets, isNot(contains(null)));
    expect(HomeAssets.headerBackdrop('bronze'), isNull);
    expect(HomeAssets.headerBackdrop(null), isNull);
  });

  test('every tier backdrop is bundled', () {
    for (final id in ['silver', 'gold', 'platinum']) {
      expect(File(HomeAssets.headerBackdrop(id)!).existsSync(), isTrue);
    }
  });

  testWidgets('the panel cuts the banners off at its bottom edge', (
    tester,
  ) async {
    await pumpHomeScreen(tester, streams);
    streams.banners.add(testBanners);
    await tester.pump(_entrance);

    final panelBottom = tester
        .getBottomLeft(_inside<MemberPanelView>(find.byType(ClipRRect)).first)
        .dy;
    final bannerTop = tester.getTopLeft(find.byType(BannerItem).first).dy;
    final bannerBottom = tester.getBottomLeft(find.byType(BannerItem).first).dy;
    expect(bannerBottom - bannerTop, HomeDimens.bannerHeight);
    expect(panelBottom - bannerTop, HomeDimens.bannerVisibleHeight);
  });

  testWidgets('the shops band sits on the garden scene, anchored at the '
      'bottom', (tester) async {
    await pumpHomeScreen(tester, streams);
    await tester.pump(_entrance);

    final scene = tester
        .widgetList<DecoratedBox>(
          _inside<ShopsBandView>(find.byType(DecoratedBox)),
        )
        .map((box) => box.decoration)
        .whereType<BoxDecoration>()
        .singleWhere((decoration) => decoration.image != null)
        .image!;
    expect((scene.image as AssetImage).assetName, HomeAssets.shopsBackdrop);
    expect(scene.alignment, Alignment.bottomCenter);
  });

  testWidgets('the avatar is a white circle when its photo is missing', (
    tester,
  ) async {
    await pumpHomeScreen(tester, streams);
    streams.member.add(testMemberSummary);
    await tester.pump(_entrance);

    final placeholder = tester.widget<DecoratedBox>(
      _inside<HomeHeaderView>(find.byKey(AppNetworkImage.placeholderKey)),
    );
    expect(
      (placeholder.decoration as ShapeDecoration).color,
      DonutsColors.light.surface,
    );
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
    expect(find.text('🔥'), findsOneWidget);
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
    expect(find.text('J’Donuts Myaynigone'), findsOneWidget);
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
    expect(find.text('We couldn’t load this section.'), findsOneWidget);
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

    expect(
      find.text('There are 4 J’Donut shops near\u00A0you.\u00A0😋'),
      findsOneWidget,
    );
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
    expect(find.text('You’re offline. Showing saved data.'), findsOneWidget);
  });

  testWidgets('every row lines its See all button up on the right edge', (
    tester,
  ) async {
    await pumpHomeScreen(tester, streams);
    streams.emitAll();
    await tester.pump(_entrance);

    final buttons = find.byType(AppCircleFilledButton);
    final rightEdges = {
      for (var i = 0; i < 3; i++) tester.getTopRight(buttons.at(i)).dx,
    };
    expect(find.byType(AppCircleFilledButton), findsNWidgets(3));
    expect(rightEdges, hasLength(1));
  });

  testWidgets('See all, Explore now and Order online say the feature is '
      'coming soon', (tester) async {
    await pumpHomeScreen(tester, streams);
    streams.emitAll();
    await tester.pump(_entrance);
    const message = 'This feature is coming soon.';

    for (final button in [
      find.byType(AppCircleFilledButton).first,
      find.byType(AppPillButton),
      find.byType(AppTextButton).first,
    ]) {
      await tester.ensureVisible(button);
      await tester.pumpAndSettle();
      await tester.tap(button);
      await tester.pump();
      expect(find.text(message), findsOneWidget);
      ScaffoldMessenger.of(tester.element(find.byType(ShopsBandView)))
          .removeCurrentSnackBar();
      await tester.pumpAndSettle();
    }
  });

  testWidgets('the offline banner pushes the header down instead of '
      'covering it', (tester) async {
    final connectivity = ConnectivityCubit(
      FakeConnectivitySource(),
      FakeReachabilityProbe(),
    );
    await pumpHomeScreen(tester, streams, connectivity: connectivity);
    streams.emitAll();
    await connectivity.start();
    await tester.pumpAndSettle();

    final banner = tester.getRect(find.byType(OfflineBanner));
    final name = tester.getRect(find.text('Ye Min'));

    expect(name.top, greaterThanOrEqualTo(banner.bottom));
  });

  testWidgets('product rows keep their place after scrolling away and back '
      'on a small phone', (tester) async {
    await pumpHomeScreen(tester, streams, surface: smallPhoneSurface);
    streams.emitAll();
    await tester.pumpAndSettle();
    final position = tester
        .state<ScrollableState>(
          find
              .descendant(
                of: find.byType(CustomScrollView),
                matching: find.byType(Scrollable),
              )
              .first,
        )
        .position;

    position.jumpTo(position.maxScrollExtent);
    await tester.pump();
    position.jumpTo(0);
    await tester.pump();

    final fade = tester.widget<FadeTransition>(
      find
          .ancestor(
            of: find.text('Seasonal specials'),
            matching: find.byType(FadeTransition),
          )
          .first,
    );
    expect(fade.opacity.value, 1);
  });

  testWidgets('long shop and member names end in an ellipsis', (tester) async {
    await pumpHomeScreen(tester, streams);
    streams.emitAll();
    await tester.pump(_entrance);

    for (final name in ['Ye Min', 'J’Donuts Central Boulevard']) {
      expect(
        tester.widget<Text>(find.text(name)).overflow,
        TextOverflow.ellipsis,
        reason: name,
      );
    }
  });

  testWidgets('banner photos decode at the card width', (tester) async {
    await pumpHomeScreen(tester, streams);
    streams.emitAll();
    await tester.pump(_entrance);

    final photos = tester.widgetList<AppNetworkImage>(
      find.descendant(
        of: find.byType(BannerItem),
        matching: find.byType(AppNetworkImage),
      ),
    );
    expect(photos, isNotEmpty);
    expect(photos.map((p) => p.cacheWidth), everyElement(isNotNull));
  });
}
