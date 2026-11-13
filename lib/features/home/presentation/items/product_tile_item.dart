import 'package:donuts/core/l10n/l10n.dart';
import 'package:donuts/core/router/app_routes.dart';
import 'package:donuts/core/theme/app_dimens.dart';
import 'package:donuts/core/theme/theme_context.dart';
import 'package:donuts/core/widgets/badges/discount_badge.dart';
import 'package:donuts/core/widgets/images/product_hero_image.dart';
import 'package:donuts/core/widgets/images/product_hero_tag.dart';
import 'package:donuts/features/home/domain/vo/home_product_vo.dart';
import 'package:donuts/features/home/presentation/home_dimens.dart';
import 'package:donuts/features/home/presentation/widgets/press_scale_widget.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

/// One product in a Home row: a white card with the product in the middle,
/// or a photo filling the tile when [fillsTile] is set. Tapping it opens
/// Product detail, and the image flies there through a Hero scoped to
/// [sectionId].
class ProductTileItem extends StatelessWidget {
  const new({
    required this.product,
    required this.sectionId,
    required this.imageSize,
    this.fillsTile = false,
    super.key,
  });

  final HomeProductVO product;
  final String sectionId;
  final Size imageSize;

  /// True for a photo that fills the tile (seasonal boxes). False for a
  /// cut-out product, which sits whole in the middle of its card.
  final bool fillsTile;

  /// The discount badge's distance from the tile's bottom-right corner.
  /// [ProductHeroImage.tileRadius] assumes this inset for its curve.
  static const double _badgeInset = AppSpacing.s;

  Object get _heroTag => productHeroTag(product.id, scope: sectionId);

  void _open(BuildContext context) =>
      context.push(AppRoutes.productDetail(product.id), extra: _heroTag);

  /// The tap is on the semantics node too, so screen readers and switch
  /// access can open the product, and the discount is read as its value.
  @override
  Widget build(BuildContext context) {
    final discount = product.discountPercent;
    return Semantics(
      button: true,
      label: product.name,
      value: discount == null ? null : context.l10n.discountOff(discount),
      onTap: () => _open(context),
      excludeSemantics: true,
      child: PressScaleWidget(
        onTap: () => _open(context),
        child: SizedBox(
          width: imageSize.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: AppSpacing.s,
            children: [
              _image(context),
              Text(
                product.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: context.text.label,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _image(BuildContext context) {
    final discount = product.discountPercent;
    final radius = ProductHeroImage.tileRadius(context);
    return SizedBox.fromSize(
      size: imageSize,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Hero(
            tag: _heroTag,
            flightShuttleBuilder: productHeroShuttle,
            child: ProductHeroImage(
              url: product.imageUrl,
              asset: product.imageAsset,
              radius: radius,
              fit: fillsTile ? BoxFit.cover : BoxFit.contain,
              inset: fillsTile ? 0 : HomeDimens.productInset,
            ),
          ),
          if (discount != null)
            Positioned(
              right: _badgeInset,
              bottom: _badgeInset,
              child: DiscountBadge(percent: discount),
            ),
        ],
      ),
    );
  }
}
