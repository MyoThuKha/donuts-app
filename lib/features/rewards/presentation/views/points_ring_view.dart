import 'package:donuts/core/l10n/l10n.dart';
import 'package:donuts/core/motion/app_motion.dart';
import 'package:donuts/core/theme/app_dimens.dart';
import 'package:donuts/core/theme/theme_context.dart';
import 'package:donuts/features/rewards/domain/vo/member_summary.dart';
import 'package:donuts/features/rewards/presentation/painters/points_ring_painter.dart';
import 'package:donuts/features/rewards/presentation/rewards_dimens.dart';
import 'package:donuts/features/rewards/presentation/rewards_motion.dart';
import 'package:donuts/features/rewards/presentation/widgets/count_up_text_widget.dart';
import 'package:material_ui/material_ui.dart';

/// The points ring, running past the right edge of the screen. It sweeps
/// to the member's tier progress while the total counts up. Without a
/// [member] it shows the bare track.
class PointsRingView extends StatelessWidget {
  const new({required this.member, required this.entrance, super.key});

  final MemberSummary? member;

  /// How far the ring's lit middle runs from the accent toward white.
  static const double _highlightMix = 0.38;
  final Animation<double> entrance;

  @override
  Widget build(BuildContext context) {
    final member = this.member;
    final sweep = entrance.drive(CurveTween(curve: RewardsMotion.ringSweep));
    return SizedBox(
      width: RewardsDimens.ringDiameter - RewardsDimens.ringBleed,
      height: RewardsDimens.ringDiameter,
      child: OverflowBox(
        alignment: Alignment.centerLeft,
        minWidth: RewardsDimens.ringDiameter,
        maxWidth: RewardsDimens.ringDiameter,
        child: Stack(
          fit: StackFit.expand,
          children: [
            if (member == null)
              RepaintBoundary(
                child: CustomPaint(
                  painter: _painter(context, const AlwaysStoppedAnimation(0)),
                ),
              )
            else
              // A later change in progress, such as after Earn, sweeps on
              // from where the ring stood.
              TweenAnimationBuilder<double>(
                tween: Tween(end: member.tierProgress.progress),
                duration: context.motion.of(AppMotion.slow),
                curve: AppMotion.standard,
                builder: (context, progress, _) => RepaintBoundary(
                  child: CustomPaint(
                    painter: _painter(
                      context,
                      sweep.drive(Tween(begin: 0, end: progress)),
                    ),
                  ),
                ),
              ),
            if (member != null) _total(context, member.totalPoints, sweep),
          ],
        ),
      ),
    );
  }

  PointsRingPainter _painter(BuildContext context, Animation<double> value) {
    final colors = context.colors;
    return PointsRingPainter(
      progress: value,
      track: colors.canvas,
      fill: colors.accent,
      highlight: Color.lerp(colors.accent, colors.surface, _highlightMix),
      stroke: RewardsDimens.ringStroke,
      sprinkle: colors.surface,
    );
  }

  Widget _total(BuildContext context, int total, Animation<double> sweep) {
    return Padding(
      padding: const EdgeInsets.all(RewardsDimens.ringStroke + AppSpacing.s),
      child: Center(
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                context.l10n.rewardsTotalPoints,
                style: context.text.pointsLabel,
              ),
              CountUpText(
                progress: sweep,
                value: total,
                style: context.text.points,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
