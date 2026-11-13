import 'package:donuts/core/format/number_format.dart';
import 'package:donuts/core/l10n/l10n.dart';
import 'package:donuts/core/theme/app_dimens.dart';
import 'package:donuts/core/theme/theme_context.dart';
import 'package:donuts/core/widgets/badges/discount_badge.dart';
import 'package:donuts/core/widgets/feedback/skeleton.dart';
import 'package:donuts/core/widgets/images/product_hero_image.dart';
import 'package:donuts/features/product/domain/vo/product_detail_vo.dart';
import 'package:donuts/features/product/presentation/product_dimens.dart';
import 'package:donuts/features/product/presentation/widgets/new_badge_widget.dart';
import 'package:material_ui/material_ui.dart';

/// The white card with the code, badges, name, unit price and the Hero
/// image. Its bottom padding leaves room for the stepper that overlaps it.
///
/// While the product loads it shows skeleton lines with the Hero already in
/// place, so the tile's image has somewhere to fly to on the first frame.
class ProductCardView extends StatelessWidget {
  const new({required this.product, required this.heroTag, super.key});

  /// Null while loading.
  final ProductDetailVO? product;
  final Object heroTag;

  @override
  Widget build(BuildContext context) {
    final product = this.product;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.colors.surface,
        borderRadius: BorderRadius.circular(AppRadii.card),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.xl,
          AppSpacing.xl,
          AppSpacing.xl,
          AppSpacing.xl + ProductDimens.stepperHeight / 2,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (product == null)
              const _HeadingSkeleton()
            else
              _Heading(product: product),
            Padding(
              padding: const EdgeInsets.only(top: AppSpacing.xxl),
              child: FractionallySizedBox(
                widthFactor: ProductDimens.imageWidthFactor,
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Hero(
                    tag: heroTag,
                    flightShuttleBuilder: productHeroShuttle,
                    child: ProductHeroImage(
                      url: product?.imageUrl,
                      asset: product?.imageAsset,
                      pictureRadius: ProductHeroImage.tileRadius(context),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// The code and badges, the name and the unit price.
class _Heading extends StatelessWidget {
  const new({required this.product});

  final ProductDetailVO product;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final text = context.text;
    final discount = product.discountPercent;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          spacing: AppSpacing.s,
          children: [
            Expanded(
              child: Text(
                product.code,
                style: text.caption.copyWith(color: colors.inkSubtle),
              ),
            ),
            if (discount != null) DiscountBadge(percent: discount),
            if (product.isNew) const NewBadgeWidget(),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: AppSpacing.xs),
          child: Text(product.name, style: text.title),
        ),
        Text(
          context.l10n.productPrice(formatGrouped(product.unitPriceMmk)),
          style: text.body.copyWith(
            color: colors.ink,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

/// Placeholder lines for the code, the name and the price.
class _HeadingSkeleton extends StatelessWidget {
  const new();

  @override
  Widget build(BuildContext context) => const SkeletonGroup(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppSpacing.s,
      children: [
        Skeleton(
          width: ProductDimens.skeletonCodeWidth,
          height: ProductDimens.skeletonSmallLine,
        ),
        Skeleton(
          width: ProductDimens.skeletonNameWidth,
          height: ProductDimens.skeletonTitleLine,
        ),
        Skeleton(
          width: ProductDimens.skeletonPriceWidth,
          height: ProductDimens.skeletonLine,
        ),
      ],
    ),
  );
}
