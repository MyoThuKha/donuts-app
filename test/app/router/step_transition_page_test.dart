import 'package:donuts/app/router/step_transition_page.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

void main() {
  testWidgets("iOS's Reduce Motion shows the next step without the slide", (
    tester,
  ) async {
    const step = SizedBox(key: ValueKey('step'));
    final page = stepTransitionPage(
      key: const ValueKey('page'),
      child: step,
    ) as CustomTransitionPage<void>;
    late Widget built;

    await tester.pumpWidget(
      MediaQuery(
        data: const MediaQueryData(reduceMotion: true),
        child: Builder(
          builder: (context) {
            built = page.transitionsBuilder(
              context,
              const AlwaysStoppedAnimation(0.5),
              const AlwaysStoppedAnimation(0),
              step,
            );
            return const SizedBox.shrink();
          },
        ),
      ),
    );

    expect(built, same(step));
  });
}
