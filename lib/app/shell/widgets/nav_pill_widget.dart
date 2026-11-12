import 'package:donuts/core/theme/theme_context.dart';
import 'package:material_ui/material_ui.dart';

/// The accent stadium that marks the active tab.
class NavPillWidget extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: ShapeDecoration(
        color: context.colors.accent,
        shape: StadiumBorder(
          side: BorderSide(color: context.colors.onPrimary, width: 1.5),
        ),
      ),
    );
  }
}
