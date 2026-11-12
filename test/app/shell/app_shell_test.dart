import 'dart:ui';

import 'package:donuts/app/shell/widgets/nav_icons.dart';
import 'package:donuts/app/shell/widgets/nav_pill_widget.dart';
import 'package:donuts/features/home/presentation/home_screen.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/fakes.dart';
import '../../helpers/pump_app.dart';

final Finder _rewardIcon = find.byKey(const ValueKey(NavIcons.reward));
final Finder _homeIcon = find.byKey(const ValueKey(NavIcons.home));

Future<void> _pumpApp(WidgetTester tester) =>
    pumpRouterApp(tester, session: testSessionCubit()..signedIn(testUser));

void main() {
  testWidgets('app opens on the Home tab with the pill on Home', (
    tester,
  ) async {
    await _pumpApp(tester);

    expect(find.byType(HomeScreen), findsOneWidget);
    expect(find.text('Home'), findsOneWidget);
    expect(find.text('Reward'), findsNothing);
  });

  testWidgets('tapping Reward slides the pill and shows the Reward tab', (
    tester,
  ) async {
    await _pumpApp(tester);

    await tester.tap(_rewardIcon);
    await tester.pumpAndSettle();

    expect(find.text("J' Donuts Rewards"), findsOneWidget);
    expect(find.text('Reward'), findsOneWidget);
    expect(find.text('Home'), findsNothing);
  });

  testWidgets('rapid Reward, Home, Reward taps end on Reward', (tester) async {
    await _pumpApp(tester);

    await tester.tap(_rewardIcon);
    await tester.pump(const Duration(milliseconds: 50));
    await tester.tap(_homeIcon);
    await tester.pump(const Duration(milliseconds: 50));
    await tester.tap(_rewardIcon);
    await tester.pumpAndSettle();

    expect(find.text("J' Donuts Rewards"), findsOneWidget);
  });

  testWidgets('re-tapping the active tab keeps the same tab without errors', (
    tester,
  ) async {
    await _pumpApp(tester);

    await tester.tap(_homeIcon);
    await tester.pumpAndSettle();
    await tester.tap(_homeIcon);
    await tester.pumpAndSettle();

    expect(find.byType(HomeScreen), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('pill moves without animating when Reduce Motion is on', (
    tester,
  ) async {
    tester.platformDispatcher.accessibilityFeaturesTestValue =
        const FakeAccessibilityFeatures(disableAnimations: true);
    addTearDown(tester.platformDispatcher.clearAccessibilityFeaturesTestValue);
    await _pumpApp(tester);

    await tester.tap(_rewardIcon);
    await tester.pump();
    final pillAfterOneFrame = tester.getRect(find.byType(NavPillWidget));
    await tester.pumpAndSettle();

    expect(tester.getRect(find.byType(NavPillWidget)), pillAfterOneFrame);
    expect(find.text("J' Donuts Rewards"), findsOneWidget);
  });

  testWidgets('pill animates over several frames when Reduce Motion is off', (
    tester,
  ) async {
    await _pumpApp(tester);

    await tester.tap(_rewardIcon);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 50));
    final pillMidway = tester.getRect(find.byType(NavPillWidget));
    await tester.pumpAndSettle();

    expect(tester.getRect(find.byType(NavPillWidget)), isNot(pillMidway));
  });

  testWidgets('bottom nav fits a 4.7-inch phone at text scale 1.3', (
    tester,
  ) async {
    tester.view
      ..physicalSize = const Size(750, 1334)
      ..devicePixelRatio = 2;
    tester.platformDispatcher.textScaleFactorTestValue = 1.3;
    addTearDown(tester.view.reset);
    addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
    await _pumpApp(tester);

    for (final icon in [
      NavIcons.reward,
      NavIcons.explore,
      NavIcons.wallet,
      NavIcons.settings,
      NavIcons.home,
    ]) {
      await tester.tap(find.byKey(ValueKey(icon)));
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
    }
  });

  testWidgets('nav buttons expose a tap action to screen readers', (
    tester,
  ) async {
    final semantics = tester.ensureSemantics();
    await _pumpApp(tester);

    final reward = tester.getSemantics(find.bySemanticsLabel('Reward'));

    expect(reward.getSemanticsData().hasAction(SemanticsAction.tap), isTrue);
    semantics.dispose();
  });

  testWidgets('the new tab label fades in instead of appearing at once', (
    tester,
  ) async {
    await _pumpApp(tester);

    await tester.tap(_rewardIcon);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 30));
    final fade = tester.widget<Opacity>(
      find.ancestor(of: find.text('Reward'), matching: find.byType(Opacity)),
    );

    expect(fade.opacity, inExclusiveRange(0, 1));
  });

  testWidgets('the pill stretches while it travels, then lands on the tab', (
    tester,
  ) async {
    await _pumpApp(tester);
    final restingWidth = tester.getSize(find.byType(NavPillWidget)).width;

    await tester.tap(_rewardIcon);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 120));
    final travellingWidth = tester.getSize(find.byType(NavPillWidget)).width;
    await tester.pumpAndSettle();
    final landed = tester.getRect(find.byType(NavPillWidget));

    expect(travellingWidth, greaterThan(restingWidth));
    expect(landed.width, moreOrLessEquals(restingWidth));
    expect(landed.contains(tester.getCenter(_rewardIcon)), isTrue);
  });
}
