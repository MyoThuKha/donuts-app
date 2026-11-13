import 'package:donuts/core/theme/app_dimens.dart';
import 'package:donuts/core/theme/theme_context.dart';
import 'package:donuts/features/rewards/domain/vo/tier_vo.dart';
import 'package:donuts/features/rewards/presentation/painters/tier_line_painter.dart';
import 'package:donuts/features/rewards/presentation/rewards_dimens.dart';
import 'package:donuts/features/rewards/presentation/widgets/tier_shield_widget.dart';
import 'package:material_ui/material_ui.dart';

/// One rung of the tier ladder: the shield, the line down to the next
/// shield (unless [lineFill] is null), and the tier's name and [caption].
/// A null [tier] is a grey loading row.
class TierRowItem extends StatelessWidget {
  const new({
    required this.tier,
    required this.caption,
    required this.pop,
    required this.lineFill,
    this.glow,
    super.key,
  });

  final TierVO? tier;
  final String? caption;
  final Animation<double> pop;
  final Animation<double>? glow;

  /// Null on the last rung, which has no line below it.
  final Animation<double>? lineFill;

  @override
  Widget build(BuildContext context) {
    final lineFill = this.lineFill;
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: AppSpacing.l,
        children: [
          Column(
            children: [
              TierShieldWidget(tier: tier, pop: pop, glow: glow),
              if (lineFill != null) Expanded(child: _line(context, lineFill)),
            ],
          ),
          Expanded(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: lineFill == null
                    ? 0
                    : RewardsDimens.tierRowMinHeight,
              ),
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: lineFill == null ? 0 : AppSpacing.xl,
                ),
                child: _labels(context),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _line(BuildContext context, Animation<double> fill) {
    final colors = context.colors;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
      child: SizedBox(
        width: RewardsDimens.tierLineWidth,
        child: RepaintBoundary(
          child: CustomPaint(
            painter: TierLinePainter(
              fill: fill,
              track: colors.canvas,
              filled: colors.tierLine,
            ),
          ),
        ),
      ),
    );
  }

  Widget _labels(BuildContext context) {
    final tier = this.tier;
    final caption = this.caption;
    if (tier == null) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppSpacing.xs,
      children: [
        Text(tier.name, style: context.text.label),
        if (caption != null) Text(caption, style: context.text.caption),
      ],
    );
  }
}
