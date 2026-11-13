import 'package:donuts/features/rewards/presentation/blocs/rewards_state.dart';
import 'package:donuts/features/rewards/presentation/views/rewards_tabs_view.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../helpers/pump_app.dart';

const String _challenges = 'Eat more earn more';
const String _gifts = 'Gift';

final Finder _indicator = find.byKey(RewardsTabsView.indicatorKey);

/// The tappable box around [label]: the outline its pill is drawn to.
Rect _pillOf(WidgetTester tester, String label) => tester.getRect(
  find
      .ancestor(of: find.text(label), matching: find.byType(GestureDetector))
      .first,
);

Future<TabController> _pumpTabs(
  WidgetTester tester, {
  ValueChanged<RewardsTab>? onSelected,
}) async {
  final controller = TabController(length: 2, vsync: const TestVSync());
  addTearDown(controller.dispose);
  await pumpThemed(
    tester,
    Center(
      child: RewardsTabsView(
        controller: controller,
        onSelected: onSelected ?? (_) {},
      ),
    ),
  );
  return controller;
}

void main() {
  testWidgets('at rest the blue pill covers the selected tab exactly', (
    tester,
  ) async {
    await _pumpTabs(tester);

    expect(tester.getRect(_indicator), _pillOf(tester, _challenges));
  });

  testWidgets('mid-swipe the blue pill sits between the two tabs, in step '
      'with the swipe', (tester) async {
    final controller = await _pumpTabs(tester);

    controller.offset = 0.25;
    await tester.pump();

    // Both pills resize with the swipe, so read them at the same moment.
    final from = _pillOf(tester, _challenges);
    final to = _pillOf(tester, _gifts);
    final at = tester.getRect(_indicator);
    expect(at.left, greaterThan(from.left));
    expect(at.right, lessThan(to.right));
    expect(at.left, closeTo(from.left + (to.left - from.left) * 0.25, 0.5));
    expect(at.width, closeTo(from.width + (to.width - from.width) * 0.25, 0.5));
  });

  testWidgets('after switching to Gift the blue pill covers Gift and Gift '
      'reads as selected', (tester) async {
    final controller = await _pumpTabs(tester);

    controller.index = 1;
    await tester.pumpAndSettle();

    expect(tester.getRect(_indicator), _pillOf(tester, _gifts));
    expect(
      tester.getSemantics(find.text(_gifts)),
      isSemantics(isSelected: true),
    );
  });

  testWidgets('tapping a tab reports it', (tester) async {
    final taps = <RewardsTab>[];
    await _pumpTabs(tester, onSelected: taps.add);

    await tester.tap(find.text(_gifts));

    expect(taps, [RewardsTab.gifts]);
  });
}
