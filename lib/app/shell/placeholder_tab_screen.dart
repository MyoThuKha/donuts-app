import 'package:donuts/core/l10n/l10n.dart';
import 'package:donuts/core/theme/app_dimens.dart';
import 'package:donuts/core/theme/theme_context.dart';
import 'package:material_ui/material_ui.dart';

/// Stand-in for a tab the code test doesn't ask to build.
class PlaceholderTabScreen extends StatelessWidget {
  const new({required this.title, super.key});

  final String title;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: context.colors.canvas,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.pageGutter),
          child: Text(
            context.l10n.placeholderComingSoon(title),
            style: context.text.sectionTitle,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
