import 'package:donuts/core/format/number_format.dart';
import 'package:donuts/core/l10n/l10n.dart';
import 'package:donuts/core/widgets/images/network_image.dart';
import 'package:donuts/features/rewards/domain/vo/gift_vo.dart';
import 'package:donuts/features/rewards/presentation/rewards_dimens.dart';
import 'package:donuts/features/rewards/presentation/widgets/earn_button_widget.dart';
import 'package:donuts/features/rewards/presentation/widgets/reward_card_widget.dart';
import 'package:material_ui/material_ui.dart';

/// A gift card. Redeem is active when the member has [affordable] points.
class GiftCardItem extends StatelessWidget {
  const new({required this.gift, required this.affordable, super.key});

  final GiftVO gift;
  final bool affordable;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return RewardCard(
      art: AppNetworkImage(
        url: null,
        asset: gift.imageAsset,
        fit: BoxFit.contain,
        cacheWidth:
            (RewardsDimens.cardArt * MediaQuery.devicePixelRatioOf(context))
                .round(),
      ),
      title: gift.title,
      details: [
        RewardCardAction(
          button: EarnButton(active: affordable, label: l10n.rewardsRedeem),
          points: l10n.rewardsPoints(formatGrouped(gift.costPoints)),
        ),
      ],
    );
  }
}
