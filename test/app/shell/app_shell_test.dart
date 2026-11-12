import 'dart:ui';

import 'package:donuts/app/app.dart';
import 'package:donuts/app/shell/widgets/nav_pill_widget.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

final Finder _rewardIcon = find.byIcon(LucideIcons.crown);
final Finder _homeIcon = find.byIcon(LucideIcons.house);

Future<void> _pumpApp(WidgetTester tester) async {
  await tester.pumpWidget(const DonutsApp());
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('app opens on the Home tab with the pill on Home', (
    tester,
  ) async {
    await _pumpApp(tester);

    expect(find.text('Home is coming soon'), findsOneWidget);
    expect(find.text('Home'), findsOneWidget);
    expect(find.text('Reward'), findsNothing);
  });

  testWidgets('tapping Reward slides the pill and shows the Reward tab', (
    tester,
  ) async {
    await _pumpApp(tester);

    await tester.tap(_rewardIcon);
    await tester.pumpAndSettle();

    expect(find.text('Reward is coming soon'), findsOneWidget);
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

    expect(find.text('Reward is coming soon'), findsOneWidget);
  });

  testWidgets('re-tapping the active tab keeps the same tab without errors', (
    tester,
  ) async {
    await _pumpApp(tester);

    await tester.tap(_homeIcon);
    await tester.pumpAndSettle();
    await tester.tap(_homeIcon);
    await tester.pumpAndSettle();

    expect(find.text('Home is coming soon'), findsOneWidget);
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
    expect(find.text('Reward is coming soon'), findsOneWidget);
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
      LucideIcons.crown,
      LucideIcons.target,
      LucideIcons.wallet,
      LucideIcons.settings,
      LucideIcons.house,
    ]) {
      await tester.tap(find.byIcon(icon));
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
    }
  });
}
