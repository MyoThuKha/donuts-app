import 'package:donuts/core/motion/stagger.dart';
import 'package:donuts/core/theme/app_dimens.dart';
import 'package:donuts/features/rewards/domain/vo/challenge_vo.dart';
import 'package:donuts/features/rewards/presentation/items/challenge_card_item.dart';
import 'package:material_ui/material_ui.dart';

/// The "Eat more earn more" cards, entering one after another.
class ChallengeListView extends StatelessWidget {
  const new({required this.challenges, this.onEarnPressed, super.key});

  final List<ChallengeVO> challenges;
  final ValueChanged<String>? onEarnPressed;

  @override
  Widget build(BuildContext context) {
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
              onEarnPressed: onEarnPressed == null
                  ? null
                  : () => onEarnPressed!(challenge.id),
            ),
          ),
      ],
    );
  }
}
