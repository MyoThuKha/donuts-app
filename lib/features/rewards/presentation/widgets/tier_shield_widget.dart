import 'package:donuts/core/theme/donuts_colors.dart';
import 'package:donuts/core/theme/theme_context.dart';
import 'package:donuts/features/rewards/domain/vo/tier_vo.dart';
import 'package:donuts/features/rewards/presentation/painters/shield_painter.dart';
import 'package:donuts/features/rewards/presentation/rewards_dimens.dart';
import 'package:material_ui/material_ui.dart';

/// A tier's shield. It scales in with [pop], and with [glow] it gets a soft
/// accent halo. A null [tier] draws a grey stand-in while loading.
class TierShieldWidget extends StatelessWidget {
  const new({required this.tier, required this.pop, this.glow, super.key});

  final TierVO? tier;
  final Animation<double> pop;
  final Animation<double>? glow;

  @override
  Widget build(BuildContext context) {
    final shield = SizedBox.fromSize(
      size: RewardsDimens.shield,
      child: RepaintBoundary(child: CustomPaint(painter: _painter(context))),
    );
    final glow = this.glow;
    return ScaleTransition(
      scale: pop,
      child: glow == null ? shield : _Glow(glow: glow, child: shield),
    );
  }

  ShieldPainter _painter(BuildContext context) {
    final colors = context.colors;
    final tier = this.tier;
    final letter = context.text.label.copyWith(color: colors.tierLine);
    if (tier == null) {
      return ShieldPainter(
        fill: colors.disabled,
        stars: 1,
        letter: '',
        letterStyle: letter.copyWith(color: colors.canvas),
      );
    }
    return ShieldPainter(
      fill: _fill(colors, tier.sortOrder),
      stars: tier.sortOrder + 1,
      letter: tier.name.characters.first.toUpperCase(),
      letterStyle: letter,
    );
  }

  /// Silver, gold, then platinum for every tier above.
  static Color _fill(DonutsColors colors, int sortOrder) => switch (sortOrder) {
    <= 0 => colors.tierSilver,
    1 => colors.tierGold,
    _ => colors.tierPlatinum,
  };
}

class _Glow extends StatelessWidget {
  const new({required this.glow, required this.child});

  final Animation<double> glow;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final accent = context.colors.accent;
    return AnimatedBuilder(
      animation: glow,
      builder: (context, child) => DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(RewardsDimens.shield.width / 2),
          boxShadow: [
            BoxShadow(
              color: accent.withValues(
                alpha: RewardsDimens.glowAlpha * glow.value.clamp(0.0, 1.0),
              ),
              blurRadius: RewardsDimens.glowBlur,
              spreadRadius: RewardsDimens.glowSpread,
            ),
          ],
        ),
        child: child,
      ),
      child: child,
    );
  }
}
