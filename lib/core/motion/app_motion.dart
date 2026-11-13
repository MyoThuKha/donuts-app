import 'package:material_ui/material_ui.dart';

/// Every duration and curve the app animates with. Widgets read durations
/// through [MotionScale] (`context.motion`) so Reduce Motion is respected.
abstract final class AppMotion {
  static const Duration fast = Duration(milliseconds: 150);
  static const Duration medium = Duration(milliseconds: 300);
  static const Duration slow = Duration(milliseconds: 500);
  static const Duration showcase = Duration(milliseconds: 1200);
  static const Duration stagger = Duration(milliseconds: 60);

  static const Curve standard = Curves.easeOutCubic;
  static const Curve emphasized = Curves.easeInOutCubicEmphasized;
  static const Curve pop = Curves.easeOutBack;

  /// The spring sheets slide on. Flutter's defaults (half a second, no
  /// bounce) match an iOS sheet's smooth spring.
  static final SpringDescription sheetSpring =
      SpringDescription.withDurationAndBounce();

  /// Scale a pressed control shrinks to before springing back.
  static const double pressScale = 0.96;

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
