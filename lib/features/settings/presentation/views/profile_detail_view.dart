import 'package:donuts/core/theme/app_dimens.dart';
import 'package:donuts/core/theme/theme_context.dart';
import 'package:donuts/features/auth/domain/vo/user_vo.dart';
import 'package:donuts/features/settings/presentation/widgets/initials_avatar_widget.dart';
import 'package:material_ui/material_ui.dart';

/// The Profile Detail sheet's body: the avatar in a white card, then the
/// member's name and phone number in another.
class ProfileDetailView extends StatelessWidget {
  const new({required this.user, super.key});

  final UserVO user;

  static const double avatarCard = 240;
  static const double avatarSize = 160;
  static const double cardRadius = 32;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final text = context.text;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: AppSpacing.xxl,
      children: [
        Center(
          child: Container(
            width: avatarCard,
            height: avatarCard,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: colors.surface,
              borderRadius: BorderRadius.circular(cardRadius),
            ),
            child: InitialsAvatarWidget(user: user, size: avatarSize),
          ),
        ),
        DecoratedBox(
          decoration: BoxDecoration(
            color: colors.surface,
            borderRadius: BorderRadius.circular(AppRadii.card),
          ),
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.xxl),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: AppSpacing.m,
              children: [
                Text(user.displayName, style: text.title),
                Text(user.phone, style: text.body),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
