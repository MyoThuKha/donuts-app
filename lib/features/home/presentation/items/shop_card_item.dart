import 'package:donuts/core/l10n/l10n.dart';
import 'package:donuts/core/theme/app_dimens.dart';
import 'package:donuts/core/theme/theme_context.dart';
import 'package:donuts/core/widgets/images/network_image.dart';
import 'package:donuts/features/home/domain/vo/shop_vo.dart';
import 'package:donuts/features/home/presentation/home_dimens.dart';
import 'package:donuts/features/home/presentation/widgets/press_scale_widget.dart';
import 'package:material_ui/material_ui.dart';

/// A nearby shop: photo, name, address and an Order online link that
/// gives press feedback only.
class ShopCardItem extends StatelessWidget {
  const new({required this.shop, super.key});

  final ShopVO shop;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final text = context.text;
    return SizedBox(
      width: HomeDimens.shopCardWidth,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(AppRadii.card),
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.m),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: AppSpacing.xs,
            children: [
              _photo(context),
              Text(
                shop.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: text.label,
              ),
              Text(
                shop.address,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: text.bodySmall,
              ),
              _orderOnline(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _photo(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: AppSpacing.xs),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(AppRadii.tile),
      child: SizedBox(
        height: HomeDimens.shopImageHeight,
        width: double.infinity,
        child: AppNetworkImage(
          url: shop.imageUrl,
          asset: shop.imageAsset,
          cacheWidth:
              (HomeDimens.shopCardWidth *
                      MediaQuery.devicePixelRatioOf(context))
                  .round(),
        ),
      ),
    ),
  );

  Widget _orderOnline(BuildContext context) => Semantics(
    button: true,
    child: PressScaleWidget(
      child: Text(
        context.l10n.homeOrderOnline,
        style: context.text.label.copyWith(color: context.colors.accent),
      ),
    ),
  );
}
