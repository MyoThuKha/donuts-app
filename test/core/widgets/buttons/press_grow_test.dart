import 'package:donuts/core/motion/app_motion.dart';
import 'package:donuts/core/widgets/buttons/press_grow.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

import '../../../helpers/pump_app.dart';

const Key _box = Key('box');

double _scale(WidgetTester tester) => tester
    .widget<ScaleTransition>(
      find.descendant(
        of: find.byType(AppPressGrow),
        matching: find.byType(ScaleTransition),
      ),
    )
    .scale
    .value;

Future<void> _pump(
  WidgetTester tester, {
  VoidCallback? onTap,
  bool reduceMotion = false,
}) => pumpThemed(
  tester,
  MediaQuery(
    data: MediaQueryData(disableAnimations: reduceMotion),
    child: Center(
      child: AppPressGrow(
        onTap: onTap,
        child: const SizedBox.square(key: _box, dimension: 40),
      ),
    ),
  ),
);

void main() {
  testWidgets('it grows while held and springs back on release', (
    tester,
  ) async {
    var taps = 0;
    await _pump(tester, onTap: () => taps++);

    final gesture = await tester.startGesture(
      tester.getCenter(find.byKey(_box)),
    );
    await tester.pumpAndSettle();
    expect(_scale(tester), closeTo(AppMotion.pressGrow, 1e-6));
    expect(taps, 0);

    await gesture.up();
    await tester.pumpAndSettle();
    expect(_scale(tester), 1);
    expect(taps, 1);
  });

  testWidgets('sliding off cancels: no tap, and it settles back', (
    tester,
  ) async {
    var taps = 0;
    await _pump(tester, onTap: () => taps++);

    final gesture = await tester.startGesture(
      tester.getCenter(find.byKey(_box)),
    );
    await tester.pump();
    await gesture.moveBy(const Offset(0, 200));
    await gesture.up();
    await tester.pumpAndSettle();

    expect(_scale(tester), 1);
    expect(taps, 0);
  });

  testWidgets('the layout size stays the same while it grows', (tester) async {
    await _pump(tester, onTap: () {});
    final before = tester.getSize(find.byType(AppPressGrow));

    final gesture = await tester.startGesture(
      tester.getCenter(find.byKey(_box)),
    );
    await tester.pumpAndSettle();
    expect(tester.getSize(find.byType(AppPressGrow)), before);
    await gesture.up();
  });

  testWidgets('Reduce Motion keeps it at its own size', (tester) async {
    await _pump(tester, onTap: () {}, reduceMotion: true);

    final gesture = await tester.startGesture(
      tester.getCenter(find.byKey(_box)),
    );
    await tester.pumpAndSettle();
    expect(_scale(tester), 1);
    await gesture.up();
  });

  testWidgets('a disabled press neither grows nor taps', (tester) async {
    await _pump(tester);

    final gesture = await tester.startGesture(
      tester.getCenter(find.byKey(_box)),
    );
    await tester.pumpAndSettle();
    expect(_scale(tester), 1);
    await gesture.up();
  });
}
