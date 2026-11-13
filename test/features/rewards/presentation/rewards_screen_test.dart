import 'dart:async';

import 'package:donuts/core/di/locator.dart';
import 'package:donuts/core/motion/app_motion.dart';
import 'package:donuts/core/network/connectivity_cubit.dart';
import 'package:donuts/core/widgets/feedback/offline_banner.dart';
import 'package:donuts/core/widgets/feedback/section_error_state.dart';
import 'package:donuts/core/widgets/feedback/skeleton.dart';
import 'package:donuts/features/rewards/domain/usecases/watch_challenges_use_case.dart';
import 'package:donuts/features/rewards/domain/usecases/watch_member_summary_use_case.dart';
import 'package:donuts/features/rewards/domain/vo/challenge_vo.dart';
import 'package:donuts/features/rewards/presentation/items/challenge_card_item.dart';
import 'package:donuts/features/rewards/presentation/painters/donut_quarters_painter.dart';
import 'package:donuts/features/rewards/presentation/painters/points_ring_painter.dart';
import 'package:donuts/features/rewards/presentation/rewards_screen.dart';
import 'package:donuts/features/rewards/presentation/views/rewards_header_view.dart';
import 'package:donuts/features/rewards/presentation/widgets/count_up_text_widget.dart';
import 'package:donuts/features/rewards/presentation/widgets/earn_button_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mocktail/mocktail.dart';

import '../../../helpers/fake_connectivity.dart';
import '../../../helpers/member_fakes.dart';
import '../../../helpers/pump_app.dart';
import '../../../helpers/rewards_fakes.dart';

class _MockWatchMember extends Mock implements WatchMemberSummaryUseCase;

const Duration _margin = Duration(milliseconds: 100);

/// Pumps the screen over the seeded fakes, then one more frame so the
/// cubit's first emissions are on screen.
Future<void> _pumpRewards(
  WidgetTester tester, {
  ConnectivityCubit? connectivity,
}) async {
  registerMemberFakes(getIt);
  registerRewardsFakes(getIt);
  addTearDown(getIt.reset);
  await pumpThemed(
    tester,
    BlocProvider.value(
      value: connectivity ?? testConnectivity(),
      child: const RewardsScreen(),
    ),
  );
  await tester.pump();
}

PointsRingPainter _ring(WidgetTester tester) => tester
    .widgetList<CustomPaint>(find.byType(CustomPaint))
    .map((p) => p.painter)
    .whereType<PointsRingPainter>()
    .single;

int _shownCount(WidgetTester tester) {
  final text = tester.widget<Text>(
    find.descendant(of: find.byType(CountUpText), matching: find.byType(Text)),
  );
  return int.parse(text.data!.replaceAll(',', ''));
}

void main() {
  testWidgets('the count reaches 680,000 when the sweep ends', (tester) async {
    await _pumpRewards(tester);

    await tester.pump(AppMotion.showcase + _margin);

    expect(find.text('680,000'), findsOneWidget);
  });

  testWidgets('halfway through, the count is between 0 and 680,000', (
    tester,
  ) async {
    await _pumpRewards(tester);

    await tester.pump(AppMotion.showcase ~/ 2);

    expect(_shownCount(tester), inExclusiveRange(0, 680000));
  });

  testWidgets('the ring ends at 75%', (tester) async {
    await _pumpRewards(tester);
    expect(_ring(tester).progress.value, closeTo(0, 0.01));

    await tester.pump(AppMotion.showcase + _margin);

    expect(_ring(tester).progress.value, closeTo(0.75, 0.001));
  });

  testWidgets(
    'the tier captions say Silver is here now, Gold is 500 pts away and '
    'Platinum is soon',
    (tester) async {
      await _pumpRewards(tester);

      expect(find.text('You’re here now'), findsOneWidget);
      expect(find.text('500 pts Remaining to become Gold'), findsOneWidget);
      expect(find.text('You’ll be here soon'), findsOneWidget);
    },
  );

  testWidgets('the Rewards badge shows 3', (tester) async {
    await _pumpRewards(tester);
    await tester.pump(AppMotion.showcase + _margin);

    expect(find.text('3'), findsOneWidget);
    expect(find.bySemanticsLabel('3 rewards available'), findsOneWidget);
  });

  testWidgets('Earn is active only on the complete challenge', (tester) async {
    await _pumpRewards(tester);

    final buttons = tester.widgetList<EarnButton>(find.byType(EarnButton));
    expect(buttons, hasLength(3));
    expect(buttons.where((b) => b.active), hasLength(1));
  });

  testWidgets('pressing the pulsing Earn turns it into a grey Earned', (
    tester,
  ) async {
    await _pumpRewards(tester);
    final earn = find.byWidgetPredicate((w) => w is EarnButton && w.active);
    final pulse = find
        .descendant(of: earn, matching: find.byType(ScaleTransition))
        .first;
    await tester.pump(RewardsMotion.earnPulsePeriod * 0.75);
    expect(tester.widget<ScaleTransition>(pulse).scale.value, greaterThan(1));

    await tester.ensureVisible(earn);
    await tester.tap(earn);
    await tester.pump(RewardsMotion.earnPulsePeriod * 0.75);

    final earned = find.byWidgetPredicate(
      (w) => w is EarnButton && !w.active && !w.pulse && w.label == 'Earned',
    );
    expect(earned, findsOneWidget);
    expect(find.text('EARNED'), findsOneWidget);
  });

  testWidgets('the donuts colour in to 4/4 and 1/4 after their cards enter', (
    tester,
  ) async {
    await _pumpRewards(tester);
    await tester.pumpAndSettle();

    final clips = tester
        .widgetList<CustomPaint>(find.byType(CustomPaint))
        .map((c) => c.foregroundPainter)
        .whereType<DonutQuartersPainter>()
        .map((c) => c.progress.value);
    expect(clips, [1.0, 0.25]);
  });

  testWidgets('swiping the list across shows the gift cards', (tester) async {
    await _pumpRewards(tester);
    await tester.pumpAndSettle();

    await tester.fling(
      find.text('Eat 4 Coco donuts'),
      const Offset(-300, 0),
      1000,
    );
    await tester.pumpAndSettle();

    expect(find.text('Free classic donut'), findsOneWidget);
  });

  testWidgets('tapping Gift shows the gift cards', (tester) async {
    await _pumpRewards(tester);
    expect(find.text('Free classic donut'), findsNothing);

    await tester.tap(find.text('Gift'));
    await tester.pumpAndSettle();

    expect(find.text('Free classic donut'), findsOneWidget);
    expect(find.text('Eat 4 Coco donuts'), findsNothing);
  });

  testWidgets('with reduce motion everything is final on the first frame', (
    tester,
  ) async {
    tester.platformDispatcher.accessibilityFeaturesTestValue =
        const FakeAccessibilityFeatures(disableAnimations: true);
    addTearDown(tester.platformDispatcher.clearAccessibilityFeaturesTestValue);

    await _pumpRewards(tester);

    expect(find.text('680,000'), findsOneWidget);
    expect(_ring(tester).progress.value, closeTo(0.75, 0.001));
    expect(find.text('3'), findsOneWidget);
    expect(tester.hasRunningAnimations, isFalse);
  });

  testWidgets('no overflow at 1.3x text on a 375 by 667 screen', (
    tester,
  ) async {
    tester.view
      ..physicalSize = const Size(750, 1334)
      ..devicePixelRatio = 2;
    tester.platformDispatcher.textScaleFactorTestValue = 1.3;
    addTearDown(tester.view.reset);
    addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);

    await _pumpRewards(tester);
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);

    await tester.scrollUntilVisible(find.text('Gift'), 200);
    await tester.ensureVisible(find.text('Gift'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Gift'));
    await tester.pumpAndSettle();
    // The header and the list share one NestedScrollView; drag the outer.
    await tester.scrollUntilVisible(
      find.text('Box of 6 donuts'),
      200,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
  });

  testWidgets('a null member shows the empty message', (tester) async {
    final member = _MockWatchMember();
    when(member.call).thenAnswer((_) => Stream.value(null));
    getIt.registerSingleton<WatchMemberSummaryUseCase>(member);

    await _pumpRewards(tester);

    expect(find.text('Nothing to show yet.'), findsOneWidget);
  });

  testWidgets('a failed load shows the error, and Try again resubscribes', (
    tester,
  ) async {
    final challenges = MockWatchChallengesUseCase();
    when(challenges.call)
        .thenAnswer((_) => Stream.error(StateError('database closed')));
    getIt.registerSingleton<WatchChallengesUseCase>(challenges);

    await _pumpRewards(tester);
    expect(find.text('We couldn’t load your rewards.'), findsOneWidget);

    await tester.tap(find.text('TRY AGAIN'));
    await tester.pump();

    verify(challenges.call).called(2);
  });

  testWidgets('Redeem on a gift says the feature is coming soon', (
    tester,
  ) async {
    await _pumpRewards(tester);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Gift'));
    await tester.pumpAndSettle();

    final redeem = find.text('REDEEM').first;
    await tester.ensureVisible(redeem);
    await tester.tap(redeem);
    await tester.pump();

    expect(find.text('This feature is coming soon.'), findsOneWidget);
  });

  testWidgets('the cards show skeletons until the challenges arrive', (
    tester,
  ) async {
    final stream = StreamController<List<ChallengeVO>>();
    addTearDown(stream.close);
    final challenges = MockWatchChallengesUseCase();
    when(challenges.call).thenAnswer((_) => stream.stream);
    getIt.registerSingleton<WatchChallengesUseCase>(challenges);

    await _pumpRewards(tester);

    expect(find.byType(Skeleton), findsWidgets);
    // A skeleton with no width of its own once collapsed to nothing.
    final skeletons = find.byType(Skeleton);
    for (var i = 0; i < skeletons.evaluate().length; i++) {
      final size = tester.getSize(skeletons.at(i));
      expect(size.width, greaterThan(0));
      expect(size.height, greaterThan(0));
    }
    expect(find.text('Nothing to show yet.'), findsNothing);
    expect(find.byType(ChallengeCardItem), findsNothing);

    stream.add(testChallenges);
    await tester.pumpAndSettle();

    expect(find.byType(Skeleton), findsNothing);
    expect(find.byType(ChallengeCardItem), findsWidgets);
  });

  testWidgets('a failed member shows its error above cards that still load', (
    tester,
  ) async {
    final member = _MockWatchMember();
    when(member.call)
        .thenAnswer((_) => Stream.error(StateError('database closed')));
    getIt.registerSingleton<WatchMemberSummaryUseCase>(member);

    await _pumpRewards(tester);
    await tester.pumpAndSettle();

    expect(find.byType(SectionErrorState), findsOneWidget);
    expect(find.byType(ChallengeCardItem), findsWidgets);
  });

  testWidgets('the offline banner opens above the header while offline', (
    tester,
  ) async {
    final connectivity = testConnectivity();
    await _pumpRewards(tester, connectivity: connectivity);

    await connectivity.start();
    await tester.pumpAndSettle();

    final banner = tester.widget<OfflineBanner>(find.byType(OfflineBanner));
    expect(banner.visible, isTrue);
    expect(
      tester.getRect(find.byType(OfflineBanner)).bottom,
      lessThanOrEqualTo(tester.getRect(find.byType(RewardsHeaderView)).top),
    );
  });
}
