import 'package:donuts/core/theme/theme_context.dart';
import 'package:donuts/features/auth/domain/vo/user_vo.dart';
import 'package:material_ui/material_ui.dart';

/// A pink circle with the member's initials, until members have photos.
class InitialsAvatarWidget extends StatelessWidget {
  const new({required this.user, required this.size, super.key});

  final UserVO user;
  final double size;

  static const double _rimShare = 0.035;
  static const double _letterShare = 0.4;

  /// The first letter of the first name and, if there is one, of the last
  /// name. `characters` keeps a Myanmar letter and its marks together.
  String get _initials => [user.firstName, ?user.lastName]
      .where((part) => part.trim().isNotEmpty)
      .map((part) => part.trim().characters.first.toUpperCase())
      .join();

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return ExcludeSemantics(
      child: Container(
        width: size,
        height: size,
        alignment: Alignment.center,
        decoration: ShapeDecoration(
          color: colors.accent,
          shape: CircleBorder(
            side: BorderSide(color: colors.surface, width: size * _rimShare),
          ),
        ),
        child: Text(
          _initials,
          style: context.text.headline.copyWith(
            color: colors.onPrimary,
            fontSize: size * _letterShare,
          ),
        ),
      ),
    );
  }
}
