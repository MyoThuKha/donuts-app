import 'package:donuts/core/l10n/l10n.dart';
import 'package:donuts/core/theme/app_dimens.dart';
import 'package:donuts/core/theme/theme_context.dart';
import 'package:donuts/core/widgets/buttons/primary_button.dart';
import 'package:donuts/core/widgets/sheets/sheet_extension.dart';
import 'package:material_ui/material_ui.dart';

/// Stands in for features the code test leaves out: social sign-in, terms.
Future<void> showPlaceholderSheet(
  BuildContext context, {
  required String message,
}) =>
    _PlaceholderSheet(message: message)
        .sheet(context, title: context.l10n.comingSoonTitle);

class _PlaceholderSheet extends StatelessWidget {
  const new({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    // The sheet route adds the title, padding and safe area.
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: AppSpacing.xxl,
      children: [
        Text(message, style: context.text.body),
        AppPrimaryButton(
          label: context.l10n.close,
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }
}
