import 'package:donuts/core/theme/theme_context.dart';
import 'package:donuts/core/widgets/effects/eased_gradient.dart';
import 'package:material_ui/material_ui.dart';

/// Fades [child] out toward its bottom edge by masking its alpha.
///
/// The child dissolves into whatever is painted behind it. A colour
/// overlay only hides the child where the overlay matches the backdrop,
/// so it leaves a band wherever the two differ. The ramp is eased, so the
/// fade has no visible start line.
class ProgressiveFade extends StatelessWidget {
  const new({required this.child, this.start = 0.5, this.end = 1, super.key})
    : assert(
        start >= 0 && start < end && end <= 1,
        'Need 0 <= start < end <= 1',
      );

  /// Where the fade begins, as a share of the child's height from the top.
  final double start;

  /// Where the child is fully transparent.
  final double end;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    // dstIn keeps only the mask's alpha, so any opaque token works here.
    final shown = context.colors.surface;
    final hidden = shown.withValues(alpha: 0);
    return ShaderMask(
      blendMode: BlendMode.dstIn,
      shaderCallback: easedVerticalGradient([(start, shown), (end, hidden)])
          .createShader,
      child: child,
    );
  }
}
