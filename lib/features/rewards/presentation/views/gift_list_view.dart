import 'package:donuts/core/l10n/l10n.dart';
import 'package:donuts/core/motion/stagger.dart';
import 'package:donuts/core/theme/app_dimens.dart';
import 'package:donuts/core/theme/theme_context.dart';
import 'package:donuts/features/rewards/domain/vo/gift_vo.dart';
import 'package:donuts/features/rewards/presentation/items/gift_card_item.dart';
import 'package:material_ui/material_ui.dart';

/// The Gift tab's cards.
class GiftListView extends StatelessWidget {
  const new({required this.gifts, super.key});

  final List<GiftVO> gifts;

  @override
  Widget build(BuildContext context) {
    if (gifts.isEmpty) {
      return Text(context.l10n.rewardsEmpty, style: context.text.body);
    }
    return Column(
      spacing: AppSpacing.l,
      children: [
        for (final (i, gift) in gifts.indexed)
          StaggeredEntrance(
            key: ValueKey(gift.id),
            index: i,
            child: GiftCardItem(gift: gift),
          ),
      ],
    );
  }
}
