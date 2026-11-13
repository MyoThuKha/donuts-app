import 'package:donuts/core/motion/app_motion.dart';
import 'package:material_ui/material_ui.dart';

/// The platform's page transition, or a cross-fade under Reduce Motion,
/// which is what iOS itself swaps its slides for. Opacity changes aren't
/// motion, so the new page still arrives without sliding across.
class MotionAwarePageTransitionsBuilder extends PageTransitionsBuilder {
  const new();

  /// Material's own defaults: Cupertino's slide and back swipe on iOS, the
  /// predictive back transition on Android.
  static const PageTransitionsTheme _platform = PageTransitionsTheme();

  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    if (context.motion.reduced) {
      return FadeTransition(opacity: animation, child: child);
    }
    return _platform.buildTransitions(
      route,
      context,
      animation,
      secondaryAnimation,
      child,
    );
  }
}

/// Page transitions for the app theme that respect Reduce Motion.
const PageTransitionsTheme motionAwarePageTransitions = PageTransitionsTheme(
  builders: {
    TargetPlatform.android: MotionAwarePageTransitionsBuilder(),
    TargetPlatform.iOS: MotionAwarePageTransitionsBuilder(),
  },
);
