import 'package:donuts/core/motion/app_motion.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

/// How far, in logical pixels, a step slides while it fades.
const double _slideDistance = 30;

/// A horizontal shared-axis transition between registration steps: the new
/// step slides in from the right and fades in while the old one slides left
/// and fades out, reversed on back. It runs for the page default (300 ms,
/// the same as [AppMotion.medium]). Reduce Motion shows the step at once.
Page<void> stepTransitionPage({required LocalKey key, required Widget child}) {
  return CustomTransitionPage<void>(
    key: key,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      if (MediaQuery.disableAnimationsOf(context)) return child;
      return _SharedAxis(
        animation: animation,
        secondaryAnimation: secondaryAnimation,
        child: child,
      );
    },
  );
}

class _SharedAxis extends StatelessWidget {
  const new({
    required this.animation,
    required this.secondaryAnimation,
    required this.child,
  });

  final Animation<double> animation;
  final Animation<double> secondaryAnimation;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final incoming = animation.drive(CurveTween(curve: AppMotion.emphasized));
    final outgoing = secondaryAnimation.drive(
      CurveTween(curve: AppMotion.emphasized),
    );
    return AnimatedBuilder(
      animation: Listenable.merge([incoming, outgoing]),
      builder: (context, child) {
        final dx =
            (1 - incoming.value) * _slideDistance -
            outgoing.value * _slideDistance;
        final opacity = incoming.value * (1 - outgoing.value);
        return Opacity(
          opacity: opacity,
          child: Transform.translate(offset: Offset(dx, 0), child: child),
        );
      },
      child: child,
    );
  }
}
