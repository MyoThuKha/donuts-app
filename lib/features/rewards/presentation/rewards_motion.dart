import 'package:donuts/core/motion/app_motion.dart';
import 'package:donuts/features/rewards/presentation/rewards_dimens.dart';
import 'package:material_ui/material_ui.dart';

/// Rewards timings, all derived from [AppMotion].
///
/// One controller runs the entrance over [entrance]. The ring sweeps over
/// all of it, and the shields, ladder line, glow and badge run in
/// [Interval]s inside it.
abstract final class RewardsMotion {
  static const Duration entrance = AppMotion.showcase;
  static const Curve ringSweep = AppMotion.emphasized;

  static Duration get shieldStagger => AppMotion.stagger * 3;

  /// Shield [index] pops over [AppMotion.slow], one stagger after the last.
  static Curve shieldPop(int index) =>
      _span(shieldStagger * index, AppMotion.slow, AppMotion.pop);

  /// The current shield's glow fades in once that shield has popped.
  static Curve glow(int index) => _span(
    shieldStagger * index + AppMotion.slow,
    AppMotion.medium,
    AppMotion.standard,
  );

  /// The ladder line fills once the first shield is in.
  static final Curve lineFill = _span(
    AppMotion.slow,
    entrance - AppMotion.slow,
    AppMotion.emphasized,
  );

  /// The Rewards badge pops in after the ring has started.
  static final Curve badgePop = _span(
    AppMotion.medium,
    AppMotion.slow,
    AppMotion.pop,
  );

  static const Duration tabSwitch = AppMotion.medium;

  /// A card's art fills over [AppMotion.slow] once the card has entered.
  static Duration artDelay(int index) =>
      AppMotion.stagger * index + AppMotion.slow;
  static const Duration artFill = AppMotion.slow;

  /// One attention pulse on a complete challenge's Earn button, then a
  /// rest. It runs [earnPulseCycles] times each time the tab opens.
  static const Duration earnPulsePeriod = Duration(milliseconds: 1600);
  static const int earnPulseCycles = 3;
  static final Animatable<double> earnPulse = TweenSequence<double>([
    TweenSequenceItem(tween: ConstantTween<double>(1), weight: 2),
    TweenSequenceItem(
      tween: Tween<double>(
        begin: 1,
        end: RewardsDimens.pulseScale,
      ).chain(CurveTween(curve: AppMotion.standard)),
      weight: 1,
    ),
    TweenSequenceItem(
      tween: Tween<double>(
        begin: RewardsDimens.pulseScale,
        end: 1,
      ).chain(CurveTween(curve: AppMotion.standard)),
      weight: 1,
    ),
  ]);

  static Curve _span(Duration start, Duration length, Curve curve) {
    double at(Duration d) =>
        (d.inMicroseconds / entrance.inMicroseconds).clamp(0.0, 1.0);
    return Interval(at(start), at(start + length), curve: curve);
  }
}
