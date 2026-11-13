import 'dart:math' as math;

import 'package:donuts/core/l10n/l10n.dart';
import 'package:donuts/core/router/app_routes.dart';
import 'package:donuts/core/theme/app_dimens.dart';
import 'package:donuts/core/theme/theme_context.dart';
import 'package:donuts/core/widgets/buttons/pending_tap_guard.dart';
import 'package:donuts/core/widgets/images/profile_avatar.dart';
import 'package:donuts/core/widgets/images/tier_backdrop.dart';
import 'package:donuts/features/auth/domain/vo/user_vo.dart';
import 'package:donuts/features/auth/presentation/session/user_initials.dart';
import 'package:donuts/features/cart/presentation/blocs/cart_count_cubit.dart';
import 'package:donuts/features/cart/presentation/widgets/cart_tag_widget.dart';
import 'package:donuts/features/settings/presentation/blocs/settings_member_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

/// The band at the top of Settings, as a sliver: the member's avatar, name,
/// tier and phone number, and the cart tag that opens the cart. It sits on
/// the backdrop of the member's tier, read from the local database, and
/// shows plain light blue until that loads.
///
/// It runs up under the status bar and stretches when the page is pulled
/// down, so the backdrop never comes apart from the top.
class SettingsHeaderView extends StatelessWidget {
  const new({required this.user, super.key});

  final UserVO user;

  static const double avatarSize = 58;

  /// Gap above and below the avatar row.
  static const double _verticalInset = AppSpacing.huge;

  /// The name, tier and phone lines' height at the current text scale, so
  /// the band grows with large text instead of clipping it. Each line is
  /// measured with its real font.
  static double _textHeight(BuildContext context, {required bool withTier}) {
    final scaler = MediaQuery.textScalerOf(context);
    final text = context.text;
    double line(TextStyle style) {
      final painter = TextPainter(
        text: TextSpan(text: 'Ag', style: style),
        textScaler: scaler,
        textDirection: TextDirection.ltr,
        maxLines: 1,
      )..layout();
      final height = painter.height;
      painter.dispose();
      return height;
    }

    final body = AppSpacing.xs + line(text.body);
    return line(text.title) + body + (withTier ? body : 0);
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final member = context.watch<SettingsMemberCubit>().state;
    final tier = member?.tierProgress.current;
    final textHeight = _textHeight(context, withTier: tier != null);
    final contentHeight = math.max(avatarSize, textHeight) + 2 * _verticalInset;
    return SliverAppBar(
      automaticallyImplyLeading: false,
      toolbarHeight: 0,
      expandedHeight: contentHeight,
      stretch: true,
      backgroundColor: colors.settingsHeader,
      elevation: 0,
      scrolledUnderElevation: 0,
      flexibleSpace: Stack(
        fit: StackFit.expand,
        children: [
          // Zooms with the stretch (FlexibleSpaceBar's default).
          FlexibleSpaceBar(
            background: TierBackdrop(
              tierId: tier?.id,
              color: colors.settingsHeader,
              // The band is shorter than Home's panel, so it shows the
              // lower part of the hexagon.
              alignment: Alignment.bottomRight,
            ),
          ),
          // Pinned to the bottom of the band at its full height, so a
          // stretch grows the blue above the row and a scroll slides the
          // row up under the clip instead of squeezing it.
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: contentHeight,
            child: _HeaderRow(
              user: user,
              avatarUrl: member?.avatarUrl,
              avatarAsset: member?.avatarAsset,
              tierName: tier?.name,
            ),
          ),
          // Level with the top of the avatar, flush with the right edge,
          // where Home puts its bell.
          Positioned(
            right: 0,
            bottom: contentHeight - _verticalInset - AppSizes.edgeTagHeight,
            child: const _CartTag(),
          ),
        ],
      ),
    );
  }
}

/// Ignores taps while the cart it opened is on top, so a double tap opens
/// one cart.
class _CartTag extends StatefulWidget {
  const new();

  @override
  State<_CartTag> createState() => _CartTagState();
}

class _CartTagState extends State<_CartTag> with PendingTapGuard {
  @override
  Widget build(BuildContext context) => CartTagWidget(
    count: context.watch<CartCountCubit>().state,
    onTap: () => runGuarded(() => context.push(AppRoutes.cart)),
  );
}

class _HeaderRow extends StatelessWidget {
  const new({
    required this.user,
    this.avatarUrl,
    this.avatarAsset,
    this.tierName,
  });

  final UserVO user;
  final String? avatarUrl;
  final String? avatarAsset;
  final String? tierName;

  @override
  Widget build(BuildContext context) {
    final text = context.text;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.authGutter),
      child: Row(
        spacing: AppSpacing.l,
        children: [
          ProfileAvatar(
            imageUrl: avatarUrl,
            asset: avatarAsset,
            size: SettingsHeaderView.avatarSize,
            initials: user.initials,
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: AppSpacing.xs,
              children: [
                // One line each, so the band's height holds.
                Text(
                  user.displayName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: text.title,
                ),
                if (tierName case final tier?)
                  Text(
                    context.l10n.homeMemberTier(tier),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: text.body,
                  ),
                Text(user.phone, style: text.body),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
