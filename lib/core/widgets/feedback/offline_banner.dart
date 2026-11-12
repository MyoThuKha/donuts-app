import 'package:donuts/core/l10n/l10n.dart';
import 'package:donuts/core/motion/app_motion.dart';
import 'package:donuts/core/theme/app_dimens.dart';
import 'package:donuts/core/theme/theme_context.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:material_ui/material_ui.dart';

/// A small strip that slides down while the app is offline. Screen
/// readers announce it when it appears.
class OfflineBanner extends StatelessWidget {
  const new({required this.visible, super.key});

  final bool visible;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return ClipRect(
      child: AnimatedSlide(
        offset: visible ? Offset.zero : const Offset(0, -1),
        duration: context.motion.of(AppMotion.medium),
        curve: AppMotion.standard,
        child: ExcludeSemantics(
          excluding: !visible,
          child: Semantics(
            liveRegion: true,
            child: ColoredBox(
              color: colors.inkMuted,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.pageGutter,
                  vertical: AppSpacing.s,
                ),
                child: Row(
                  spacing: AppSpacing.s,
                  children: [
                    Icon(
                      LucideIcons.wifiOff,
                      size: AppSpacing.l,
                      color: colors.onPrimary,
                    ),
                    Expanded(
                      child: Text(
                        context.l10n.homeOffline,
                        style: context.text.caption.copyWith(
                          color: colors.onPrimary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
