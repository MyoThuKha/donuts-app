import 'package:donuts/core/l10n/l10n.dart';
import 'package:donuts/core/theme/app_dimens.dart';
import 'package:donuts/core/theme/theme_context.dart';
import 'package:material_ui/material_ui.dart';

/// "Didn't receive the code? resend in 4:58 min", or a Resend button once
/// the countdown ends or entry is locked.
class ResendCountdownWidget extends StatelessWidget {
  const new({
    required this.remaining,
    required this.canResend,
    required this.onResend,
    super.key,
  });

  final Duration remaining;
  final bool canResend;
  final VoidCallback onResend;

  static String format(Duration d) {
    final seconds = d.inSeconds.remainder(Duration.secondsPerMinute);
    return '${d.inMinutes}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final text = context.text;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l10n.didntReceive, style: text.bodySmall),
        const SizedBox(height: AppSpacing.xs),
        if (canResend)
          TextButton(
            onPressed: onResend,
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: const Size(AppSizes.button, AppSizes.button),
              alignment: Alignment.centerLeft,
            ),
            child: Text(
              l10n.resend,
              style: text.label.copyWith(color: context.colors.accent),
            ),
          )
        else
          _countdown(context),
      ],
    );
  }

  /// Highlights only the time inside the localised sentence.
  Widget _countdown(BuildContext context) {
    final time = format(remaining);
    final sentence = context.l10n.resendIn(time);
    final at = sentence.indexOf(time);
    final style = context.text.bodySmall;
    return Text.rich(
      TextSpan(
        style: style,
        children: [
          TextSpan(text: sentence.substring(0, at)),
          TextSpan(
            text: time,
            style: style.copyWith(color: context.colors.accent),
          ),
          TextSpan(text: sentence.substring(at + time.length)),
        ],
      ),
    );
  }
}
