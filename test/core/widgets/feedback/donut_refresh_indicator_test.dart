import 'dart:async';

import 'package:donuts/core/widgets/feedback/donut_refresh_indicator.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

import '../../../helpers/pump_app.dart';

void main() {
  Widget list(Future<void> Function() onRefresh, {ScrollPhysics? physics}) =>
      DonutRefreshIndicator(
        onRefresh: onRefresh,
        child: CustomScrollView(
          physics: AlwaysScrollableScrollPhysics(
            parent: physics ?? const ClampingScrollPhysics(),
          ),
          slivers: [
            SliverList.list(
              children: [
                for (var i = 0; i < 30; i++)
                  SizedBox(height: 60, child: Text('Row $i')),
              ],
            ),
          ],
        ),
      );

  Future<void> pull(WidgetTester tester, double distance) async {
    await tester.timedDrag(
      find.text('Row 0'),
      Offset(0, distance),
      const Duration(milliseconds: 400),
    );
    await tester.pump();
  }

  for (final physics in [
    const ClampingScrollPhysics(),
    const BouncingScrollPhysics(),
  ]) {
    testWidgets('a long pull with ${physics.runtimeType} shows the loading '
        'pill until the refresh completes', (tester) async {
      final done = Completer<void>();
      var calls = 0;
      await pumpThemed(
        tester,
        list(() {
          calls++;
          return done.future;
        }, physics: physics),
      );

      await pull(tester, 300);
      await tester.pump(const Duration(seconds: 1));

      expect(calls, 1);
      expect(find.text('Loading'), findsOneWidget);
      expect(
        tester.getSemantics(find.text('Loading')),
        isSemantics(isLiveRegion: true),
      );

      done.complete();
      await tester.pumpAndSettle();

      expect(find.text('Loading'), findsNothing);
      expect(find.byType(Image), findsNothing);
    });
  }

  testWidgets('a short pull springs back without refreshing', (tester) async {
    var calls = 0;
    await pumpThemed(tester, list(() async => calls++));

    await pull(tester, 40);
    expect(find.byType(Image), findsOneWidget);

    await tester.pumpAndSettle();

    expect(calls, 0);
    expect(find.byType(Image), findsNothing);
  });
}
