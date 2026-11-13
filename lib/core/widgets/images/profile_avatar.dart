import 'package:donuts/core/theme/theme_context.dart';
import 'package:donuts/core/widgets/images/network_image.dart';
import 'package:material_ui/material_ui.dart';

/// The member's photo in a circle with a white rim, [size] across. Home's
/// header and the Settings header both use it.
///
/// While the photo loads, and when there is none or it fails, it shows
/// [initials] on the pink accent.
class ProfileAvatar extends StatelessWidget {
  const new({
    required this.imageUrl,
    required this.size,
    this.initials = '',
    super.key,
  });

  final String? imageUrl;
  final double size;
  final String initials;

  static const double _rimShare = 0.035;
  static const double _letterShare = 0.4;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    // Container insets the photo by the rim, so the rim stays visible.
    return Container(
      width: size,
      height: size,
      decoration: ShapeDecoration(
        color: colors.accent,
        shape: CircleBorder(
          side: BorderSide(color: colors.surface, width: size * _rimShare),
        ),
      ),
      child: ClipOval(
        child: AppNetworkImage(
          url: imageUrl,
          cacheWidth: (size * MediaQuery.devicePixelRatioOf(context)).round(),
          fallback: _Initials(initials: initials, size: size * _letterShare),
        ),
      ),
    );
  }
}

class _Initials extends StatelessWidget {
  const new({required this.initials, required this.size});

  final String initials;
  final double size;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return ExcludeSemantics(
      child: ColoredBox(
        color: colors.accent,
        child: Center(
          child: Text(
            initials,
            style: context.text.headline.copyWith(
              color: colors.onPrimary,
              fontSize: size,
            ),
          ),
        ),
      ),
    );
  }
}
