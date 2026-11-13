import 'package:donuts/core/theme/app_dimens.dart';
import 'package:donuts/core/theme/theme_context.dart';
import 'package:donuts/core/widgets/badges/app_tag.dart';
import 'package:donuts/core/widgets/images/network_image.dart';
import 'package:donuts/features/home/domain/types/banner_style.dart';
import 'package:donuts/features/home/domain/vo/banner_vo.dart';
import 'package:donuts/features/home/presentation/home_dimens.dart';
import 'package:material_ui/material_ui.dart';

/// One carousel card: the tag in a stadium, the title, and the photo
/// rising from the bottom edge.
///
/// The text keeps the reader's text size. When large text needs more room
/// than the space above the photo, the photo gives up height rather than
/// sitting under the title.
class BannerItem extends StatelessWidget {
  const new({required this.banner, super.key});

  final BannerVO banner;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return MergeSemantics(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppRadii.card),
        child: ColoredBox(
          color: switch (banner.style) {
            BannerStyle.indigo => colors.bannerIndigo,
            BannerStyle.sky => colors.primary,
          },
          child: LayoutBuilder(
            builder: (context, card) => Column(
              spacing: AppSpacing.s,
              children: [
                _text(context),
                Expanded(child: _photo(context, card.maxHeight)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Bottom-aligned, at most its design share of [cardHeight], and shorter
  /// when the text above needs the room.
  Widget _photo(BuildContext context, double cardHeight) => Align(
    alignment: Alignment.bottomCenter,
    child: ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: cardHeight * HomeDimens.bannerImageFactor.height,
      ),
      child: FractionallySizedBox(
        widthFactor: HomeDimens.bannerImageFactor.width,
        heightFactor: 1,
        child: ClipRRect(
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(AppRadii.tile),
          ),
          child: LayoutBuilder(
            builder: (context, constraints) => AppNetworkImage(
              url: banner.imageUrl,
              asset: banner.imageAsset,
              cacheWidth:
                  (constraints.maxWidth *
                          MediaQuery.devicePixelRatioOf(context))
                      .round(),
            ),
          ),
        ),
      ),
    ),
  );

  Widget _text(BuildContext context) {
    final colors = context.colors;
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.m,
        AppSpacing.m,
        AppSpacing.m,
        0,
      ),
      child: Column(
        spacing: AppSpacing.xs,
        children: [
          AppTag.small(label: banner.tag),
          Text(
            banner.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: context.text.headline.copyWith(color: colors.onPrimary),
          ),
        ],
      ),
    );
  }
}
