import 'dart:math' as math;

import 'package:donuts/core/l10n/l10n.dart';
import 'package:donuts/core/theme/app_dimens.dart';
import 'package:donuts/core/theme/theme_context.dart';
import 'package:donuts/core/widgets/sheets/sheet_extension.dart';
import 'package:donuts/features/auth/domain/vo/user_vo.dart';
import 'package:donuts/features/settings/presentation/views/profile_detail_view.dart';
import 'package:donuts/features/settings/presentation/widgets/initials_avatar_widget.dart';
import 'package:material_ui/material_ui.dart';

/// The light blue band at the top of Settings, as a sliver: the member's
/// initials, name and phone number, and EDIT, which opens Profile Detail.
///
/// It runs up under the status bar and stretches when the page is pulled
/// down, so the blue never comes apart from the top. The blue is its own
/// layer, ready to take a cover image later.
class SettingsHeaderView extends StatelessWidget {
  const new({required this.user, super.key});

  final UserVO user;

  static const double avatarSize = 58;

  /// Gap above and below the avatar row.
  static const double _verticalInset = AppSpacing.huge;

  /// The name and phone lines' height at the current text scale, so the
  /// band grows with large text instead of clipping it.
  static double _textHeight(BuildContext context) {
    final scaler = MediaQuery.textScalerOf(context);
    final text = context.text;
    double line(TextStyle style, double fallbackHeight) =>
        scaler.scale(style.fontSize!) * (style.height ?? fallbackHeight);
    return line(text.title, 1.2) + AppSpacing.xs + line(text.body, 1.4);
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final contentHeight =
        math.max(avatarSize, _textHeight(context)) + 2 * _verticalInset;
    return SliverAppBar(
      automaticallyImplyLeading: false,
      toolbarHeight: 0,
      expandedHeight: contentHeight,
      stretch: true,
      backgroundColor: colors.settingsHeader,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      flexibleSpace: Stack(
        fit: StackFit.expand,
        children: [
          // Zooms with the stretch (FlexibleSpaceBar's default).
          FlexibleSpaceBar(
            background: ColoredBox(color: colors.settingsHeader),
          ),
          // Pinned to the bottom of the band, so a stretch grows the blue
          // above the row instead of moving the row.
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              height: contentHeight,
              child: _HeaderRow(user: user),
            ),
          ),
        ],
      ),
    );
  }
}

class _HeaderRow extends StatelessWidget {
  const new({required this.user});

  final UserVO user;

  @override
  Widget build(BuildContext context) {
    final text = context.text;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.authGutter),
      child: Row(
        spacing: AppSpacing.l,
        children: [
          InitialsAvatarWidget(user: user, size: SettingsHeaderView.avatarSize),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: AppSpacing.xs,
              children: [
                // One line here; Profile Detail shows the whole name.
                Text(
                  user.displayName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: text.title,
                ),
                Text(user.phone, style: text.body),
              ],
            ),
          ),
          TextButton(
            onPressed: () => ProfileDetailView(user: user)
                .sheet<void>(context, title: context.l10n.profileDetailTitle),
            child: Text(
              context.l10n.settingsEdit.toUpperCase(),
              style: text.button.copyWith(color: context.colors.accent),
            ),
          ),
        ],
      ),
    );
  }
}
