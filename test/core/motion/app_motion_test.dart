import 'package:donuts/core/motion/app_motion.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

Future<MotionScale> _motionWith(
  WidgetTester tester, {
  bool disableAnimations = false,
  bool reduceMotion = false,
}) async {
  late MotionScale motion;
  await tester.pumpWidget(
    MediaQuery(
      data: MediaQueryData(
        disableAnimations: disableAnimations,
        reduceMotion: reduceMotion,
      ),
      child: Builder(
        builder: (context) {
          motion = context.motion;
          return const SizedBox.shrink();
        },
      ),
    ),
  );
  return motion;
}

void main() {
  testWidgets('motion durations collapse to zero when Reduce Motion is on', (
    tester,
  ) async {
    final motion = await _motionWith(tester, disableAnimations: true);

    expect(motion.of(AppMotion.medium), Duration.zero);
    expect(motion.cue(AppMotion.medium), const Duration(milliseconds: 90));
  });

  testWidgets('motion durations stay unchanged when Reduce Motion is off', (
    tester,
  ) async {
    final motion = await _motionWith(tester);

    expect(motion.of(AppMotion.medium), AppMotion.medium);
    expect(motion.cue(AppMotion.medium), AppMotion.medium);
  });

  testWidgets(
    "motion durations collapse to zero under iOS's Reduce Motion setting",
    (tester) async {
      final motion = await _motionWith(tester, reduceMotion: true);

      expect(motion.reduced, isTrue);
      expect(motion.of(AppMotion.medium), Duration.zero);
    },
  );
}
