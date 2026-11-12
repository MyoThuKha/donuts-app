import 'package:donuts/features/home/domain/types/banner_style.dart';
import 'package:donuts/features/home/domain/vo/banner_vo.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

import '../../../helpers/home_fixtures.dart';
import '../../../helpers/home_harness.dart';

/// The banner the carousel rests on. With two banners the last one rests
/// at page 0.75, aligned to the right edge, so the page is rounded.
int _page(WidgetTester tester) =>
    tester.widget<PageView>(find.byType(PageView)).controller!.page!.round();

void main() {
  late HomeStreams streams;

  setUp(() => streams = HomeStreams());

  testWidgets('the carousel moves to the next banner after 4 seconds', (
    tester,
  ) async {
    await pumpHomeScreen(tester, streams);
    streams.emitAll();
    await tester.pumpAndSettle();
    expect(_page(tester), 0);

    await tester.pump(const Duration(seconds: 4));
    await tester.pumpAndSettle();

    expect(_page(tester), 1);
  });

  testWidgets('the carousel pauses while a finger is down', (tester) async {
    await pumpHomeScreen(tester, streams);
    streams.emitAll();
    await tester.pumpAndSettle();

    final gesture = await tester.startGesture(
      tester.getCenter(find.byType(PageView)),
    );
    await tester.pump(const Duration(seconds: 6));
    await tester.pumpAndSettle();
    expect(_page(tester), 0);

    await gesture.up();
    await tester.pump(const Duration(seconds: 4));
    await tester.pumpAndSettle();
    expect(_page(tester), 1);
  });

  testWidgets('with reduce motion the carousel stays on the first banner', (
    tester,
  ) async {
    await pumpHomeScreen(tester, streams, reduceMotion: true);
    streams.emitAll();
    await tester.pump();

    await tester.pump(const Duration(seconds: 9));
    await tester.pump();

    expect(_page(tester), 0);
  });

  testWidgets('the carousel keeps moving after the banner list shrinks on '
      'its last banner', (tester) async {
    final three = [
      ...testBanners,
      const BannerVO(
        id: 'b_third',
        tag: 'New',
        title: 'A third banner',
        style: BannerStyle.sky,
        imageUrl: 'https://example.com/images/b_third.webp',
      ),
    ];
    await pumpHomeScreen(tester, streams);
    streams.emitAll();
    streams.banners.add(three);
    await tester.pumpAndSettle();
    for (var i = 0; i < 2; i++) {
      await tester.pump(const Duration(seconds: 4));
      await tester.pumpAndSettle();
    }
    expect(_page(tester), 2);

    streams.banners.add(testBanners);
    await tester.pumpAndSettle();
    await tester.pump(const Duration(seconds: 4));
    await tester.pumpAndSettle();

    expect(_page(tester), 0);
  });

  testWidgets('on iOS an auto-advance never scrolls past the last banner', (
    tester,
  ) async {
    await pumpHomeScreen(tester, streams);
    streams.emitAll();
    await tester.pumpAndSettle();
    final controller = tester
        .widget<PageView>(find.byType(PageView))
        .controller!;
    var furthest = 0.0;
    controller.addListener(() {
      if (controller.offset > furthest) furthest = controller.offset;
    });

    await tester.pump(const Duration(seconds: 4));
    for (var i = 0; i < 60; i++) {
      await tester.pump(const Duration(milliseconds: 16));
    }

    expect(_page(tester), 1);
    expect(furthest, lessThanOrEqualTo(controller.position.maxScrollExtent));
  }, variant: TargetPlatformVariant.only(TargetPlatform.iOS));
}
