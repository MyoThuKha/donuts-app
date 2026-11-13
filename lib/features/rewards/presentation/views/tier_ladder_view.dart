import 'package:donuts/core/format/number_format.dart';
import 'package:donuts/core/l10n/l10n.dart';
import 'package:donuts/core/motion/app_motion.dart';
import 'package:donuts/features/rewards/domain/vo/member_summary.dart';
import 'package:donuts/features/rewards/presentation/items/tier_row_item.dart';
import 'package:material_ui/material_ui.dart';

/// Silver, Gold and Platinum, top to bottom. The shields pop in order, the
/// current one glows, and the line below it fills towards the next tier.
/// Without a [member] it shows grey rungs while loading.
class TierLadderView extends StatelessWidget {
  const new({required this.member, required this.entrance, super.key});

  final MemberSummary? member;
  final Animation<double> entrance;

  static const int _loadingRungs = 3;

  @override
  Widget build(BuildContext context) {
    final member = this.member;
    if (member == null) return _loading();
    final tiers = member.tiers;
    final current = member.tierProgress.current;
    final currentIndex = current == null ? -1 : tiers.indexOf(current);
    return Column(
      children: [
        for (final (i, tier) in tiers.indexed)
          TierRowItem(
            tier: tier,
            caption: _caption(context, member, i - currentIndex),
            pop: entrance.drive(CurveTween(curve: RewardsMotion.shieldPop(i))),
            glow: i == currentIndex
                ? entrance.drive(CurveTween(curve: RewardsMotion.glow(i)))
                : null,
            lineFill: i == tiers.length - 1
                ? null
                : _lineFill(_lineTarget(member, i, currentIndex)),
          ),
      ],
    );
  }

  /// Lines above the current tier are full, the one below it shows the
  /// progress to the next tier, and the rest are empty.
  double _lineTarget(MemberSummary member, int index, int currentIndex) {
    if (index < currentIndex) return 1;
    if (index == currentIndex) return member.tierProgress.progress;
    return 0;
  }

  Animation<double> _lineFill(double target) => entrance
      .drive(CurveTween(curve: RewardsMotion.lineFill))
      .drive(Tween(begin: 0, end: target));

  /// [step] is the tier's place relative to the current one.
  String _caption(BuildContext context, MemberSummary member, int step) {
    final l10n = context.l10n;
    final progress = member.tierProgress;
    return switch (step) {
      < 0 => l10n.rewardsTierReached,
      0 => l10n.rewardsTierCurrent,
      1 => l10n.rewardsTierRemaining(
        formatGrouped(progress.pointsToNext ?? 0),
        progress.next?.name ?? '',
      ),
      _ => l10n.rewardsTierUpcoming,
    };
  }

  Widget _loading() {
    const shown = AlwaysStoppedAnimation<double>(1);
    const empty = AlwaysStoppedAnimation<double>(0);
    return Column(
      children: [
        for (var i = 0; i < _loadingRungs; i++)
          TierRowItem(
            tier: null,
            caption: null,
            pop: shown,
            lineFill: i == _loadingRungs - 1 ? null : empty,
          ),
      ],
    );
  }
}
