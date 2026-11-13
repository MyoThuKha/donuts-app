import 'package:material_ui/material_ui.dart';

/// Every duration and curve the app animates with. Widgets read durations
/// through [MotionScale] (`context.motion`) so Reduce Motion is respected.
abstract final class AppMotion {
  static const Duration fast = Duration(milliseconds: 150);
  static const Duration medium = Duration(milliseconds: 300);
  static const Duration slow = Duration(milliseconds: 500);
  static const Duration showcase = Duration(milliseconds: 1200);
  static const Duration stagger = Duration(milliseconds: 60);

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
