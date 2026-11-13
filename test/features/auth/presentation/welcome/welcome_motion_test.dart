import 'package:donuts/core/motion/app_motion.dart';
import 'package:donuts/features/auth/presentation/session/blocs/session_cubit.dart';
import 'package:donuts/features/auth/presentation/welcome/views/welcome_tiles_view.dart';
import 'package:donuts/features/auth/presentation/welcome/welcome_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../helpers/fakes.dart';
import '../../../../helpers/pump_app.dart';

const Duration _step = Duration(milliseconds: 20);

double _opacityAbove(WidgetTester tester, Finder child) => tester
    .widget<FadeTransition>(
      find.ancestor(of: child, matching: find.byType(FadeTransition)).first,
    )
    .opacity
    .value;

void main() {
  test('the title delay matches when the last tile lands', () {
    expect(
      AppMotion.welcomeTitleDelay,
      AppMotion.stagger * (welcomeTiles.length - 1) + AppMotion.slow,
    );
  });

  testWidgets('the title fades up only after every donut tile has landed', (
    tester,
  ) async {
    final session = testSessionCubit();
    addTearDown(session.close);
    await pumpThemed(
      tester,
      BlocProvider<SessionCubit>.value(
        value: session,
        child: const WelcomeScreen(),
      ),
    );
    final lastTile = find.byType(WelcomeTileItem).last;
    final title = find.text('Welcome to the world of J’donuts');

    while (_opacityAbove(tester, lastTile) < 1) {
      expect(_opacityAbove(tester, title), 0);
      await tester.pump(_step);
    }
    expect(_opacityAbove(tester, title), 0);

    await tester.pumpAndSettle();
    expect(_opacityAbove(tester, title), 1);
  });
}
