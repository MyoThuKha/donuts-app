import 'package:donuts/core/motion/app_motion.dart';
import 'package:donuts/core/theme/app_dimens.dart';
import 'package:donuts/core/theme/theme_context.dart';
import 'package:material_ui/material_ui.dart';

/// Runs one shimmer clock for every [Skeleton] below it, so a section's
/// placeholder lines shimmer in step. Under Reduce Motion there is no
/// clock and the skeletons stay still.
class SkeletonGroup extends StatefulWidget {
  const new({required this.child, super.key});

  final Widget child;

  /// One sweep of the shimmer across a skeleton.
  static const Duration period = AppMotion.showcase;

  @override
  State<SkeletonGroup> createState() => _SkeletonGroupState();
}

class _SkeletonGroupState extends State<SkeletonGroup>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: SkeletonGroup.period,
  );

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (context.motion.reduced) {
      _controller.stop();
    } else if (!_controller.isAnimating) {
      _controller.repeat();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => _SkeletonClock(
    animation: context.motion.reduced ? null : _controller,
    child: widget.child,
  );
}

class _SkeletonClock extends InheritedWidget {
  const new({required this.animation, required super.child});

  final Animation<double>? animation;

  static Animation<double>? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<_SkeletonClock>()?.animation;

  @override
  bool updateShouldNotify(_SkeletonClock oldWidget) =>
      animation != oldWidget.animation;
}

/// A placeholder box shown while a section loads. Inside a [SkeletonGroup]
/// a highlight sweeps across it; elsewhere it is a still box.
class Skeleton extends StatelessWidget {
  const new({this.width, this.height, this.radius, super.key});

  final double? width;
  final double? height;

  /// Defaults to the tile radius.
  final BorderRadius? radius;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final box = SizedBox(
      width: width,
      height: height,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: colors.disabled,
          borderRadius:
              radius ?? const BorderRadius.all(Radius.circular(AppRadii.tile)),
        ),
      ),
    );
    final animation = _SkeletonClock.of(context);
    if (animation == null) return box;
    return AnimatedBuilder(
      animation: animation,
      child: box,
      builder: (context, child) => ShaderMask(
        blendMode: BlendMode.srcATop,
        shaderCallback: (bounds) => _shimmer(
          colors.disabled,
          colors.surface,
          animation.value,
        ).createShader(bounds),
        child: child,
      ),
    );
  }

  static LinearGradient _shimmer(Color base, Color shine, double t) =>
      LinearGradient(
        colors: [base, shine, base],
        stops: const [0.35, 0.5, 0.65],
        transform: _SlideGradient(t * 2 - 1),
      );
}

/// Shifts a gradient horizontally by [shift] widths.
class _SlideGradient extends GradientTransform {
  const new(this.shift);

  final double shift;

  @override
  Matrix4 transform(Rect bounds, {TextDirection? textDirection}) =>
      Matrix4.translationValues(bounds.width * shift, 0, 0);
}
