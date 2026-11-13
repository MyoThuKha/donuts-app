import 'package:donuts/core/theme/theme_context.dart';
import 'package:donuts/core/widgets/effects/eased_gradient.dart';
import 'package:material_ui/material_ui.dart';

/// Which pink wash sits behind an auth screen.
enum AuthBackdrop {
  /// Flat pink, behind Onboarding and Welcome.
  wash,

  /// Pink at the top, near-white through the middle and pink again behind
  /// the footer, as on the sign-up steps.
  steps,
}

/// The pink background behind onboarding, the sign-up steps and Welcome.
class AuthBackgroundWidget extends StatelessWidget {
  const new({
    required this.child,
    this.backdrop = AuthBackdrop.steps,
    super.key,
  });

  final Widget child;
  final AuthBackdrop backdrop;

  /// Where the steps backdrop is lightest, as a share of the screen height.
  static const double _middleStop = 0.68;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final decoration = switch (backdrop) {
      AuthBackdrop.wash => BoxDecoration(color: colors.authWash),
      AuthBackdrop.steps => BoxDecoration(
        gradient: easedVerticalGradient([
          (0, colors.authTop),
          (_middleStop, colors.authMiddle),
          (1, colors.authBottom),
        ]),
      ),
    };
    return DecoratedBox(decoration: decoration, child: child);
  }
}
