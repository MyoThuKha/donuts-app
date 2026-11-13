import 'package:donuts/core/theme/theme_context.dart';
import 'package:donuts/core/widgets/feedback/section_state_box.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:material_ui/material_ui.dart';

/// Shown in place of a section that has nothing to show.
class SectionEmptyState extends StatelessWidget {
  const new({required this.message, this.gutter = true, super.key});

  final String message;

  /// False when the parent already pads to the page gutter.
  final bool gutter;

  @override
  Widget build(BuildContext context) => SectionStateBox(
    icon: LucideIcons.inbox,
    iconColor: context.colors.inkSubtle,
    message: message,
    messageStyle: context.text.bodySmall,
    gutter: gutter,
  );
}
