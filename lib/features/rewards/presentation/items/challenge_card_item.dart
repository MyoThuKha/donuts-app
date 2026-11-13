import 'package:donuts/core/format/number_format.dart';
import 'package:donuts/core/l10n/l10n.dart';
import 'package:donuts/core/motion/app_motion.dart';
import 'package:donuts/core/theme/theme_context.dart';
import 'package:donuts/core/widgets/images/network_image.dart';
import 'package:donuts/features/rewards/domain/types/challenge_kind.dart';
import 'package:donuts/features/rewards/domain/vo/challenge_vo.dart';
import 'package:donuts/features/rewards/presentation/painters/coffee_arc_painter.dart';
import 'package:donuts/features/rewards/presentation/rewards_dimens.dart';
import 'package:donuts/features/rewards/presentation/widgets/donut_quarters_widget.dart';
import 'package:donuts/features/rewards/presentation/widgets/earn_button_widget.dart';
import 'package:donuts/features/rewards/presentation/widgets/reward_card_widget.dart';
import 'package:material_ui/material_ui.dart';

/// A challenge card. Its art fills to the challenge's progress once the
/// card at [index] has entered.
class ChallengeCardItem extends StatefulWidget {
  const new({
    required this.challenge,
    required this.index,
    this.onEarnPressed,
    super.key,
  });

  final ChallengeVO challenge;
  final int index;
  final VoidCallback? onEarnPressed;

  @override
  State<ChallengeCardItem> createState() => _ChallengeCardItemState();
}

class _ChallengeCardItemState extends State<ChallengeCardItem>
    with SingleTickerProviderStateMixin {
  static const int _quarters = 4;

  late final AnimationController _controller = AnimationController(vsync: this);
  late final Animation<double> _fill;
  bool _started = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_started) return;
    _started = true;
    final wait = RewardsMotion.artDelay(widget.index);
    final total = wait + RewardsMotion.artFill;
    _fill = _controller.drive(
      CurveTween(
        curve: Interval(
          wait.inMicroseconds / total.inMicroseconds,
          1,
          curve: AppMotion.standard,
        ),
      ),
    );
    if (context.motion.reduced) {
      _controller.value = 1;
    } else {
      _controller
        ..duration = total
        ..forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// Donuts colour in by whole quarters only.
  double get _target => switch (widget.challenge.kind) {
    ChallengeKind.donutQuarters =>
      (widget.challenge.fraction * _quarters).floor() / _quarters,
    ChallengeKind.coffeeArc => widget.challenge.fraction,
  };

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final challenge = widget.challenge;
    final earnable = challenge.isComplete && !challenge.claimed;
    return RewardCard(
      art: _art(context, _fill.drive(Tween(begin: 0, end: _target))),
      title: challenge.title,
      details: [
        Text(
          l10n.rewardsProgress(challenge.progress, challenge.target),
          style: context.text.body,
        ),
        RewardCardAction(
          button: EarnButton(
            active: earnable,
            pulse: earnable,
            label: challenge.claimed ? l10n.rewardsEarned : l10n.rewardsEarn,
            onPressed: widget.onEarnPressed,
          ),
          points: l10n.rewardsPoints(formatGrouped(challenge.rewardPoints)),
        ),
      ],
    );
  }

  Widget _art(BuildContext context, Animation<double> progress) {
    final cacheWidth =
        (RewardsDimens.cardArt * MediaQuery.devicePixelRatioOf(context))
            .round();
    final url = widget.challenge.imageUrl;
    final asset = widget.challenge.imageAsset;
    return switch (widget.challenge.kind) {
      ChallengeKind.donutQuarters => DonutQuartersWidget(
        progress: progress,
        url: url,
        asset: asset,
        cacheWidth: cacheWidth,
      ),
      ChallengeKind.coffeeArc => _CoffeeArt(
        progress: progress,
        url: url,
        asset: asset,
        cacheWidth: cacheWidth,
      ),
    };
  }
}

class _CoffeeArt extends StatelessWidget {
  const new({
    required this.progress,
    required this.url,
    required this.asset,
    required this.cacheWidth,
  });

  final Animation<double> progress;
  final String? url;
  final String? asset;
  final int cacheWidth;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Stack(
      fit: StackFit.expand,
      children: [
        RepaintBoundary(
          child: CustomPaint(
            painter: CoffeeArcPainter(
              progress: progress,
              track: colors.canvas,
              fill: colors.highlight,
              stroke: RewardsDimens.coffeeStroke,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(RewardsDimens.coffeeCupInset),
          child: AppNetworkImage(
            url: url,
            asset: asset,
            fit: BoxFit.contain,
            // The cup sits inside the round progress ring.
            placeholderShape: const CircleBorder(),
            cacheWidth: cacheWidth,
          ),
        ),
      ],
    );
  }
}
