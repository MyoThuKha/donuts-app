import 'package:donuts/core/theme/app_dimens.dart';
import 'package:donuts/core/theme/theme_context.dart';
import 'package:donuts/core/widgets/images/network_image.dart';
import 'package:donuts/features/home/domain/types/banner_style.dart';
import 'package:donuts/features/home/domain/vo/banner_vo.dart';
import 'package:donuts/features/home/presentation/home_dimens.dart';
import 'package:material_ui/material_ui.dart';

/// One carousel card: the tag in a stadium, the title, and the photo
/// rising from the bottom edge.
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
          child: Stack(
            fit: StackFit.expand,
            children: [_photo(context), _text(context)],
          ),
        ),
      ),
    );
  }

  Widget _photo(BuildContext context) => Align(
    alignment: Alignment.bottomCenter,
    child: FractionallySizedBox(
      widthFactor: HomeDimens.bannerImageFactor.width,
      heightFactor: HomeDimens.bannerImageFactor.height,
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(AppRadii.tile),
        ),
        child: AppNetworkImage(url: banner.imageUrl, asset: banner.imageAsset),
      ),
    ),
  );

  Widget _text(BuildContext context) {
    final colors = context.colors;
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.m),
      child: Column(
        spacing: AppSpacing.xs,
        children: [
          DecoratedBox(
            decoration: ShapeDecoration(
              color: colors.highlight,
              shape: const StadiumBorder(),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.s,
                vertical: AppSpacing.xs / 2,
              ),
              child: Text(
                banner.tag,
                style: context.text.caption.copyWith(color: colors.onPrimary),
              ),
            ),
          ),
          Text(
            banner.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: context.text.sectionTitle.copyWith(color: colors.onPrimary),
          ),
        ],
      ),
    );
  }
}
