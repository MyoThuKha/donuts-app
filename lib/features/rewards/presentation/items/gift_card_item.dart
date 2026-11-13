import 'package:donuts/core/format/number_format.dart';
import 'package:donuts/core/l10n/l10n.dart';
import 'package:donuts/core/theme/app_dimens.dart';
import 'package:donuts/core/widgets/feedback/app_snack_bar.dart';
import 'package:donuts/core/widgets/images/rounded_network_image.dart';
import 'package:donuts/features/rewards/domain/vo/gift_vo.dart';
import 'package:donuts/features/rewards/presentation/rewards_dimens.dart';
import 'package:donuts/features/rewards/presentation/widgets/earn_button_widget.dart';
import 'package:donuts/features/rewards/presentation/widgets/reward_card_widget.dart';
import 'package:material_ui/material_ui.dart';

/// A gift card. Redeem isn't built yet, so it says so in a snackbar.
///
/// The art shows whole, and a full photo gets [AppRadii.tile] corners. A
/// radius concentric with the card would be 0, since the card's padding
/// equals its radius.
class GiftCardItem extends StatelessWidget {
  const new({required this.gift, super.key});

  final GiftVO gift;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return RewardCard(
      art: RoundedNetworkImage(
        url: gift.imageUrl,
        asset: gift.imageAsset,
        radius: AppRadii.tile,
        placeholderShape: RewardCard.artPlaceholderShape,
        cacheWidth:
            (RewardsDimens.cardArt * MediaQuery.devicePixelRatioOf(context))
                .round(),
      ),
      title: gift.title,
      details: [
        RewardCardAction(
          button: EarnButton(
            active: true,
            label: l10n.rewardsRedeem,
            onPressed: () => context.showMessage(l10n.featureComingSoon),
          ),
          points: l10n.rewardsPoints(formatGrouped(gift.costPoints)),
        ),
      ],
    );
  }
}
