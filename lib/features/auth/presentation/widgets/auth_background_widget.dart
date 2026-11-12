import 'package:donuts/core/theme/theme_context.dart';
import 'package:material_ui/material_ui.dart';

/// The soft pink-to-white wash behind onboarding, the sign-up steps and
/// Welcome. [reversed] runs it white-to-pink, as Welcome does.
class AuthBackgroundWidget extends StatelessWidget {
  const new({required this.child, this.reversed = false, super.key});

  final Widget child;
  final bool reversed;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final stops = [colors.authTop, colors.authBottom];
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: reversed ? stops.reversed.toList() : stops,
        ),
      ),
      child: child,
    );
  }
}
