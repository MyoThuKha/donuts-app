import 'package:donuts/core/l10n/l10n.dart';
import 'package:donuts/core/motion/stagger.dart';
import 'package:donuts/core/theme/app_dimens.dart';
import 'package:donuts/core/theme/theme_context.dart';
import 'package:donuts/features/rewards/domain/vo/challenge_vo.dart';
import 'package:donuts/features/rewards/presentation/items/challenge_card_item.dart';
import 'package:material_ui/material_ui.dart';

/// The "Eat more earn more" cards, entering one after another.
class ChallengeListView extends StatelessWidget {
  const new({
    required this.challenges,
    this.acknowledged = const {},
    this.onEarnPressed,
    super.key,
  });

  final List<ChallengeVO> challenges;

  /// Ids of challenges whose Earn was already pressed.
  final Set<String> acknowledged;
  final ValueChanged<String>? onEarnPressed;

  @override
  Widget build(BuildContext context) {
    if (challenges.isEmpty) {
      return Text(context.l10n.rewardsEmpty, style: context.text.body);
    }
    return Column(
      spacing: AppSpacing.l,
      children: [
        for (final (i, challenge) in challenges.indexed)
          StaggeredEntrance(
            key: ValueKey(challenge.id),
            index: i,
            child: ChallengeCardItem(
              challenge: challenge,
              index: i,
              acknowledged: acknowledged.contains(challenge.id),
              onEarnPressed: onEarnPressed == null
                  ? null
                  : () => onEarnPressed!(challenge.id),
            ),
          ),
      ],
    );
  }
}
