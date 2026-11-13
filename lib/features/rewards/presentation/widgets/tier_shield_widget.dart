import 'package:donuts/core/theme/theme_context.dart';
import 'package:donuts/core/widgets/images/network_image.dart';
import 'package:donuts/features/rewards/domain/vo/tier_vo.dart';
import 'package:donuts/features/rewards/presentation/rewards_dimens.dart';
import 'package:material_ui/material_ui.dart';

/// A tier's badge, cached from the network with the bundled image as the
/// fallback. It scales in with [pop], and with [glow] it gets a soft accent
/// halo. Without an image, or while [tier] is null, it shows a plain circle.
class TierShieldWidget extends StatelessWidget {
  const new({required this.tier, required this.pop, this.glow, super.key});

  final TierVO? tier;
  final Animation<double> pop;
  final Animation<double>? glow;

  @override
  Widget build(BuildContext context) {
    final tier = this.tier;
    final shield = SizedBox.fromSize(
      size: RewardsDimens.shield,
      child: Semantics(
        label: tier?.name,
        image: tier != null,
        child: AppNetworkImage(
          url: tier?.imageUrl,
          asset: tier?.imageAsset,
          fit: BoxFit.contain,
          placeholderShape: const CircleBorder(),
          cacheWidth:
              (RewardsDimens.shield.width *
                      MediaQuery.devicePixelRatioOf(context))
                  .round(),
        ),
      ),
    );
    final glow = this.glow;
    return ScaleTransition(
      scale: pop,
      child: glow == null ? shield : _Glow(glow: glow, child: shield),
    );
  }
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
