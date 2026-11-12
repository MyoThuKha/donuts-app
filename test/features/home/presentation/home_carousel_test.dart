import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

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
}
