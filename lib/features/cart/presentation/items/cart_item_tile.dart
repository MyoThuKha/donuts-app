import 'package:donuts/core/theme/app_dimens.dart';
import 'package:donuts/core/theme/theme_context.dart';
import 'package:donuts/core/widgets/cards/art_card.dart';
import 'package:donuts/core/widgets/images/rounded_network_image.dart';
import 'package:donuts/core/widgets/inputs/quantity_stepper.dart';
import 'package:donuts/core/widgets/text/animated_price_text.dart';
import 'package:donuts/features/cart/domain/cart_rules.dart';
import 'package:donuts/features/cart/domain/vo/cart_item_vo.dart';
import 'package:material_ui/material_ui.dart';

/// One cart item on the gift card's layout: the photo, the name, the line
/// total, then the stepper where a gift has Redeem. At the lowest quantity
/// the minus is a trash button that removes the item.
class CartItemTile extends StatelessWidget {
  const new({
    required this.item,
    required this.onIncrement,
    required this.onDecrement,
    super.key,
  });

  final CartItemVO item;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  @override
  Widget build(BuildContext context) {
    return ArtCard(
      art: RoundedNetworkImage(
        url: item.imageUrl,
        asset: item.imageAsset,
        radius: AppRadii.tile,
        placeholderShape: ArtCard.artPlaceholderShape,
        cacheWidth: (ArtCard.artSize * MediaQuery.devicePixelRatioOf(context))
            .round(),
      ),
      title: item.name,
      details: [
        AnimatedPriceText(priceMmk: item.lineTotal, style: context.text.body),
        QuantityStepper(
          quantity: item.quantity,
          minusRemoves: item.quantity <= CartRules.minQuantity,
          onDecrement: onDecrement,
          onIncrement: item.quantity < CartRules.maxQuantity
              ? onIncrement
              : null,
        ),
      ],
    );
  }
}
