import 'package:donuts/core/router/app_routes.dart';
import 'package:donuts/core/theme/app_dimens.dart';
import 'package:donuts/core/theme/theme_context.dart';
import 'package:donuts/core/widgets/badges/discount_badge.dart';
import 'package:donuts/core/widgets/images/network_image.dart';
import 'package:donuts/core/widgets/images/product_hero_tag.dart';
import 'package:donuts/features/home/domain/vo/home_product_vo.dart';
import 'package:donuts/features/home/presentation/widgets/press_scale_widget.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

/// One product in a Home row. Tapping it opens Product detail, and the
/// image flies there through a Hero scoped to [sectionId].
class ProductTileItem extends StatelessWidget {
  const new({
    required this.product,
    required this.sectionId,
    required this.imageSize,
    super.key,
  });

  final HomeProductVO product;
  final String sectionId;
  final Size imageSize;

  Object get _heroTag => productHeroTag(product.id, scope: sectionId);

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: product.name,
      excludeSemantics: true,
      child: PressScaleWidget(
        onTap: () =>
            context.push(AppRoutes.productDetail(product.id), extra: _heroTag),
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
    final pixelRatio = MediaQuery.devicePixelRatioOf(context);
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppRadii.tile),
      child: ColoredBox(
        color: context.colors.surface,
        child: SizedBox.fromSize(
          size: imageSize,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Hero(
                tag: _heroTag,
                child: AppNetworkImage(
                  url: product.imageUrl,
                  asset: product.imageAsset,
                  cacheWidth: (imageSize.width * pixelRatio).round(),
                ),
              ),
              if (discount != null)
                Positioned(
                  right: AppSpacing.s,
                  bottom: AppSpacing.s,
                  child: DiscountBadge(percent: discount),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
