import 'package:donuts/core/format/number_format.dart';
import 'package:donuts/core/l10n/l10n.dart';
import 'package:donuts/core/theme/app_dimens.dart';
import 'package:donuts/core/theme/theme_context.dart';
import 'package:donuts/core/widgets/badges/discount_badge.dart';
import 'package:donuts/core/widgets/images/network_image.dart';
import 'package:donuts/features/product/domain/vo/product_detail_vo.dart';
import 'package:donuts/features/product/presentation/product_dimens.dart';
import 'package:donuts/features/product/presentation/widgets/new_badge_widget.dart';
import 'package:material_ui/material_ui.dart';

/// The white card with the code, badges, name, unit price and the Hero
/// image. Its bottom padding leaves room for the stepper that overlaps it.
class ProductCardView extends StatelessWidget {
  const new({required this.product, required this.heroTag, super.key});

  final ProductDetailVO product;
  final Object heroTag;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final text = context.text;
    final discount = product.discountPercent;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.surface,
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
            Padding(
              padding: const EdgeInsets.only(top: AppSpacing.xxl),
              child: FractionallySizedBox(
                widthFactor: ProductDimens.imageWidthFactor,
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Hero(
                    tag: heroTag,
                    child: AppNetworkImage(
                      url: product.imageUrl,
                      asset: product.imageAsset,
                      fit: BoxFit.contain,
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
