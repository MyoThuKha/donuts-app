import 'package:material_ui/material_ui.dart';

/// Every duration and curve the app animates with. Widgets read durations
/// through [MotionScale] (`context.motion`) so Reduce Motion is respected.
abstract final class AppMotion {
  static const Duration fast = Duration(milliseconds: 150);
  static const Duration medium = Duration(milliseconds: 300);
  static const Duration slow = Duration(milliseconds: 500);
  static const Duration showcase = Duration(milliseconds: 1200);
  static const Duration stagger = Duration(milliseconds: 60);

  /// Welcome's title waits until its four donut tiles have landed: the
  /// last starts at 3 × [stagger] and runs for [slow].
  static const Duration welcomeTitleDelay = Duration(milliseconds: 680);

  /// How long a downloaded photo takes to fade in over its stand-in, and
  /// the stand-in to fade out under it (cached_network_image's defaults).
  static const Duration imageFadeIn = slow;
  static const Duration imageFadeOut = Duration(milliseconds: 1000);

  /// One attention pulse and the rest after it, such as on a complete
  /// challenge's Earn button.
  static const Duration attentionPulse = Duration(milliseconds: 1600);

  /// How long an auto-playing carousel holds each page.
  static const Duration carouselDwell = Duration(seconds: 4);

  static const Curve standard = Curves.easeOutCubic;
  static const Curve emphasized = Curves.easeInOutCubicEmphasized;
  static const Curve pop = Curves.easeOutBack;

  /// Starts slow and speeds up, for something leaving the screen.
  static const Curve exit = Curves.easeIn;

  /// The spring sheets slide on. Flutter's defaults (half a second, no
  /// bounce) match an iOS sheet's smooth spring.
  static final SpringDescription sheetSpring =
      SpringDescription.withDurationAndBounce();

  /// Scale a pressed control shrinks to before springing back.
  static const double pressScale = 0.96;

  /// Scale an attention pulse grows to, such as a complete challenge's
  /// Earn button.
  static const double attentionScale = 1.06;

  /// A stretchy move, such as the bottom nav's pill: the leading edge
  /// arrives at [stretchLeadingEnd] of the run, and the trailing edge
  /// leaves at [stretchTrailingStart].
  static const double stretchLeadingEnd = 0.7;
  static const double stretchTrailingStart = 0.3;

  /// The spring a pressed button grows and settles on. Flutter's defaults
  /// (half a second, no bounce) match SwiftUI's smooth spring.
  static final SpringDescription pressSpring =
      SpringDescription.withDurationAndBounce();

  /// How far a small button, such as a circle or a pill, grows while held.
  static const double pressGrow = 1.15;

  /// How far a full-width button grows while held. Gentler, so it stays
  /// inside the screen.
  static const double pressGrowWide = 1.04;

  /// Share of a state cue's duration kept when Reduce Motion is on.
  static const double reducedCueFactor = 0.3;
}

/// Durations adjusted for the user's Reduce Motion setting.
@immutable
class MotionScale {
  const new({required this.reduced});

  /// True when the platform asks for animations to be skipped.
  final bool reduced;

  /// Decorative motion: skipped entirely under Reduce Motion.
  Duration of(Duration base) => reduced ? Duration.zero : base;

  /// State cues (an error shake, a focus change): shortened, not removed,
  /// so the change stays noticeable under Reduce Motion.
  Duration cue(Duration base) =>
      reduced ? base * AppMotion.reducedCueFactor : base;
}

extension MotionContext on BuildContext {
  /// Reduced when either platform asks: Android's "Remove animations"
  /// (`disableAnimations`) or iOS's "Reduce Motion" (`reduceMotion`), which
  /// Flutter reports separately.
  MotionScale get motion => MotionScale(
    reduced:
        (MediaQuery.maybeDisableAnimationsOf(this) ?? false) ||
        (MediaQuery.maybeReduceMotionOf(this) ?? false),
  );
}

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

  /// A card's art fills over [AppMotion.slow] once the card has entered.
  static Duration artDelay(int index) =>
      AppMotion.stagger * index + AppMotion.slow;
  static const Duration artFill = AppMotion.slow;

  /// One attention pulse on a complete challenge's Earn button, then a
  /// rest. It runs [earnPulseCycles] times each time the tab opens.
  static const Duration earnPulsePeriod = AppMotion.attentionPulse;
  static const int earnPulseCycles = 3;
  static final Animatable<double> earnPulse = TweenSequence<double>([
    TweenSequenceItem(tween: ConstantTween<double>(1), weight: 2),
    TweenSequenceItem(
      tween: Tween<double>(
        begin: 1,
        end: AppMotion.attentionScale,
      ).chain(CurveTween(curve: AppMotion.standard)),
      weight: 1,
    ),
    TweenSequenceItem(
      tween: Tween<double>(
        begin: AppMotion.attentionScale,
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
