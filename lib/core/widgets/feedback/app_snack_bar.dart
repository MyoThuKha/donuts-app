import 'package:donuts/core/motion/app_motion.dart';
import 'package:donuts/core/theme/app_dimens.dart';
import 'package:donuts/core/theme/app_shadows.dart';
import 'package:donuts/core/theme/donuts_colors.dart';
import 'package:donuts/core/theme/theme_context.dart';
import 'package:donuts/core/widgets/buttons/text_button.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:material_ui/material_ui.dart';

/// What a snackbar reports. It sets the colour and icon of the badge in
/// front of the message.
enum AppSnackBarTone {
  /// Neutral news, such as a feature that is coming soon.
  info,

  /// Something the user asked for worked, such as adding to the cart.
  success,

  /// Something failed.
  error;

  IconData get icon => switch (this) {
    info => LucideIcons.info,
    success => LucideIcons.check,
    error => LucideIcons.x,
  };

  Color color(DonutsColors colors) => switch (this) {
    info => colors.primary,
    success => colors.success,
    error => colors.danger,
  };
}

/// The app's snackbar. Every screen shows messages through here, so their
/// look can change in one place.
///
/// It floats: a fixed snackbar slides out from under the bottom nav, which
/// the Scaffold paints on top of it. The theme leaves Material's own box
/// clear, and [AppSnackBarPill] draws the white pill in its place.
SnackBar appSnackBar(
  String message, {
  AppSnackBarTone tone = AppSnackBarTone.info,
  AppSnackBarAction? action,
}) => SnackBar(
  content: AppSnackBarPill(message: message, tone: tone, action: action),
  behavior: SnackBarBehavior.floating,
  padding: EdgeInsets.zero,
  margin: const EdgeInsets.fromLTRB(
    AppSpacing.pageGutter,
    0,
    AppSpacing.pageGutter,
    AppSpacing.m,
  ),
  // The pill's shadow spills past Material's box.
  clipBehavior: Clip.none,
);

/// A button at the end of a snackbar, such as Undo. Tapping it closes the
/// snackbar, then runs [onPressed].
final class AppSnackBarAction {
  const new({required this.label, required this.onPressed});

  final String label;
  final VoidCallback onPressed;
}

/// The white pill a snackbar shows: a coloured badge for its [tone], the
/// message, then the [action] if there is one. It hugs its text and centres
/// itself, and springs up as it appears.
class AppSnackBarPill extends StatelessWidget {
  const new({
    required this.message,
    this.tone = AppSnackBarTone.info,
    this.action,
    super.key,
  });

  final String message;
  final AppSnackBarTone tone;
  final AppSnackBarAction? action;

  /// The scale and drop the pill springs up from.
  static const double _enterScale = 0.85;
  static const double _enterDrop = AppSpacing.l;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Center(
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0, end: 1),
        duration: context.motion.of(AppMotion.medium),
        curve: AppMotion.pop,
        builder: (context, t, child) => Transform.translate(
          offset: Offset(0, (1 - t) * _enterDrop),
          child: Transform.scale(
            scale: _enterScale + (1 - _enterScale) * t,
            child: child,
          ),
        ),
        child: DecoratedBox(
          decoration: ShapeDecoration(
            color: colors.surface,
            shape: const StadiumBorder(),
            shadows: AppShadows.floating(colors),
          ),
          child: ConstrainedBox(
            constraints: const BoxConstraints(minHeight: AppSizes.snackBar),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.m,
                AppSpacing.m,
                AppSpacing.xl,
                AppSpacing.m,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                spacing: AppSpacing.m,
                children: [
                  _ToneBadge(tone: tone),
                  Flexible(child: Text(message, style: context.text.label)),
                  if (action case final action?) _ActionButton(action: action),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  const new({required this.action});

  final AppSnackBarAction action;

  @override
  Widget build(BuildContext context) => AppTextButton(
    label: action.label,
    onPressed: () {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      action.onPressed();
    },
  );
}

/// The filled circle in front of the message, in the [tone]'s colour.
class _ToneBadge extends StatelessWidget {
  const new({required this.tone});

  final AppSnackBarTone tone;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return ExcludeSemantics(
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: tone.color(colors),
          shape: BoxShape.circle,
        ),
        child: SizedBox.square(
          dimension: AppSizes.circleButton,
          child: Icon(
            tone.icon,
            size: AppSizes.circleButtonIcon,
            color: colors.onPrimary,
          ),
        ),
      ),
    );
  }
}

/// Shows the app's snackbar on a messenger the caller already holds, such
/// as one read before an `await`.
extension AppSnackBarMessenger on ScaffoldMessengerState {
  /// Shows [message], replacing any snackbar already on screen.
  void showMessage(
    String message, {
    AppSnackBarTone tone = AppSnackBarTone.info,
    AppSnackBarAction? action,
  }) => this
    ..hideCurrentSnackBar()
    ..showSnackBar(appSnackBar(message, tone: tone, action: action));
}

/// Shows the app's snackbar from a widget's context.
extension AppSnackBarContext on BuildContext {
  /// Shows [message], replacing any snackbar already on screen.
  void showMessage(
    String message, {
    AppSnackBarTone tone = AppSnackBarTone.info,
    AppSnackBarAction? action,
  }) =>
      ScaffoldMessenger.of(this)
          .showMessage(message, tone: tone, action: action);
}
