import 'package:donuts/core/motion/app_motion.dart';
import 'package:donuts/core/theme/app_dimens.dart';
import 'package:donuts/core/theme/theme_context.dart';
import 'package:donuts/features/rewards/presentation/rewards_dimens.dart';
import 'package:donuts/features/rewards/presentation/rewards_motion.dart';
import 'package:material_ui/material_ui.dart';

/// The stadium on a challenge or gift card. It shrinks on press and does
/// nothing else, as the brief asks.
///
/// [active] paints it `primary`, otherwise `disabled`. With [pulse] it
/// swells now and then to draw the eye, each time its tab opens, until the
/// user presses it once.
class EarnButton extends StatefulWidget {
  const new({
    required this.active,
    required this.label,
    this.pulse = false,
    super.key,
  });

  final bool active;
  final String label;
  final bool pulse;

  @override
  State<EarnButton> createState() => _EarnButtonState();
}

class _EarnButtonState extends State<EarnButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pulse = AnimationController(
    vsync: this,
    duration: RewardsMotion.earnPulsePeriod,
  );
  late final Animation<double> _scale = _pulse.drive(RewardsMotion.earnPulse);
  bool _pressed = false;
  bool _pressedOnce = false;
  bool _visible = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final visible = TickerMode.valuesOf(context).enabled;
    if (visible && !_visible) _startPulse();
    _visible = visible;
  }

  @override
  void didUpdateWidget(EarnButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.pulse && !oldWidget.pulse) _startPulse();
    if (!widget.pulse) _stopPulse();
  }

  void _startPulse() {
    if (!widget.pulse || _pressedOnce || context.motion.reduced) return;
    _pulse.value = 0;
    _pulse.repeat(count: RewardsMotion.earnPulseCycles);
  }

  void _stopPulse() => _pulse
    ..stop()
    ..value = 0;

  void _setPressed(bool pressed) {
    if (pressed) {
      _pressedOnce = true;
      _stopPulse();
    }
    if (pressed != _pressed) setState(() => _pressed = pressed);
  }

  @override
  void dispose() {
    _pulse.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      enabled: widget.active,
      label: widget.label,
      excludeSemantics: true,
      onTap: _noAction,
      child: GestureDetector(
        onTapDown: (_) => _setPressed(true),
        onTapUp: (_) => _setPressed(false),
        onTapCancel: () => _setPressed(false),
        onTap: _noAction,
        child: ScaleTransition(
          scale: _scale,
          child: AnimatedScale(
            scale: _pressed ? AppMotion.pressScale : 1,
            duration: context.motion.of(AppMotion.fast),
            curve: AppMotion.standard,
            child: _body(context),
          ),
        ),
      ),
    );
  }

  /// Rewards have no backend; pressing gives feedback only.
  static void _noAction() {}

  Widget _body(BuildContext context) {
    final colors = context.colors;
    return Container(
      constraints: const BoxConstraints(
        minWidth: RewardsDimens.earnMinWidth,
        minHeight: RewardsDimens.earnHeight,
      ),
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.l),
      alignment: Alignment.center,
      decoration: ShapeDecoration(
        color: widget.active ? colors.primary : colors.disabled,
        shape: const StadiumBorder(),
      ),
      child: Text(
        widget.label.toUpperCase(),
        maxLines: 1,
        style: context.text.button,
      ),
    );
  }
}
