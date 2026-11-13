import 'package:donuts/core/l10n/l10n.dart';
import 'package:donuts/core/theme/app_dimens.dart';
import 'package:donuts/core/theme/theme_context.dart';
import 'package:donuts/features/rewards/presentation/widgets/rewards_pill_widget.dart';
import 'package:material_ui/material_ui.dart';

/// The title, with the Rewards pill once the member's [rewardsCount] is
/// known.
class RewardsHeaderView extends StatelessWidget {
  const new({required this.rewardsCount, required this.badge, super.key});

  final int? rewardsCount;
  final Animation<double> badge;

  @override
  Widget build(BuildContext context) {
    final count = rewardsCount;
    return Row(
      spacing: AppSpacing.m,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: AppSpacing.pageGutter),
            child: Semantics(
              header: true,
              child: Text(
                context.l10n.rewardsTitle,
                style: context.text.display,
              ),
            ),
          ),
        ),
        if (count != null) RewardsPill(count: count, badge: badge),
      ],
    );
  }
}
