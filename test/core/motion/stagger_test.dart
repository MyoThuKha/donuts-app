import 'package:donuts/core/motion/first_frame.dart';
import 'package:donuts/core/motion/stagger.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

double _opacity(WidgetTester tester) => tester
    .widget<FadeTransition>(
      find.descendant(
        of: find.byType(StaggeredEntrance),
        matching: find.byType(FadeTransition),
      ),
    )
    .opacity
    .value;

void main() {
  testWidgets('a later item waits for its turn, then fades fully in', (
    tester,
  ) async {
    await tester.pumpWidget(
      const StaggeredEntrance(index: 2, child: SizedBox.square(dimension: 10)),
    );

    await tester.pump(const Duration(milliseconds: 100));
    expect(_opacity(tester), 0);

    await tester.pumpAndSettle();
    expect(_opacity(tester), 1);
  });

  testWidgets('waits for the first frame to be shown before it starts', (
    tester,
  ) async {
    final hold = FirstFrame.debugHold();
    addTearDown(FirstFrame.debugReset);
    await tester.pumpWidget(
      const StaggeredEntrance(index: 0, child: SizedBox.square(dimension: 10)),
    );

    await tester.pump(const Duration(seconds: 1));
    expect(_opacity(tester), 0);

    hold.complete();
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));
    await tester.pump(const Duration(milliseconds: 100));
    expect(_opacity(tester), greaterThan(0));

    await tester.pumpAndSettle();
    expect(_opacity(tester), 1);
  });

  testWidgets('Reduce Motion shows the item on the first frame', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MediaQuery(
        data: MediaQueryData(disableAnimations: true),
        child: StaggeredEntrance(
          index: 3,
          child: SizedBox.square(dimension: 10),
        ),
      ),
    );

    expect(_opacity(tester), 1);
  });
}
