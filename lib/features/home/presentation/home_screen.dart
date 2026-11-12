import 'package:donuts/core/l10n/l10n.dart';
import 'package:donuts/core/theme/app_dimens.dart';
import 'package:donuts/core/theme/theme_context.dart';
import 'package:material_ui/material_ui.dart';

/// Home (screen 8). A stub until branch 4 builds it.
class HomeScreen extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: context.colors.canvas,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.pageGutter),
          child: Text(
            context.l10n.placeholderComingSoon(context.l10n.tabHome),
            style: context.text.sectionTitle,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
