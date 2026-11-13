import 'dart:async';
import 'dart:math' as math;

import 'package:donuts/core/l10n/l10n.dart';
import 'package:donuts/core/motion/app_motion.dart';
import 'package:donuts/core/theme/app_dimens.dart';
import 'package:donuts/core/theme/app_shadows.dart';
import 'package:donuts/core/theme/theme_context.dart';
import 'package:flutter/services.dart';
import 'package:material_ui/material_ui.dart';

/// Pull-to-refresh in the J'Donuts style
class DonutRefreshIndicator extends StatefulWidget {
  const new({
    required this.onRefresh,
    required this.child,
    this.edgeOffset = 0,
    super.key,
  });

  final Future<void> Function() onRefresh;
  final Widget child;
  final double edgeOffset;

  /// How far the user pulls before a release refreshes.
  static const double triggerDistance = 100;
  static const double restOffset = AppSpacing.l;

  @override
  State<DonutRefreshIndicator> createState() => _DonutRefreshIndicatorState();
}

enum _Mode { idle, drag, armed, refresh, done }

class _DonutRefreshIndicatorState extends State<DonutRefreshIndicator>
    with TickerProviderStateMixin {
  late final AnimationController _pull = AnimationController(
    vsync: this,
    upperBound: _maxPull,
  );

  /// 0 for the circle, 1 for the pill with its label.
  late final AnimationController _expand = AnimationController(vsync: this);

  /// The donut's loading spin, one turn per cycle.
  late final AnimationController _spin = AnimationController(
    vsync: this,
    duration: AppMotion.showcase,
  );

  /// 0 while the indicator shows, 1 once it has faded out after a refresh.
  late final AnimationController _exit = AnimationController(vsync: this);

  late final Listenable _frame = Listenable.merge([
    _pull,
    _expand,
    _spin,
    _exit,
  ]);

  _Mode _mode = _Mode.idle;

  /// The finger's travel since the pull began, before resistance.
  double _dragOffset = 0;

  static const double _maxPull = 1.5;

  /// Share of the travel past the trigger point that still moves the
  /// indicator, so it slows down the further it goes.
  static const double _overPullResistance = 0.4;

  /// The circle's scale when it first comes out from the edge.
  static const double _enterScale = 0.5;

  /// The scale it shrinks to as it fades out.
  static const double _exitScale = 0.6;

  /// How long the open pill stays before it can fold away.
  static const Duration _labelHold = AppMotion.medium;

  /// How far the donut turns over a full pull.
  static const double _turnsPerPull = 0.5;

  bool get _dragging => _mode == _Mode.drag || _mode == _Mode.armed;

  @override
  void dispose() {
    _pull.dispose();
    _expand.dispose();
    _spin.dispose();
    _exit.dispose();
    super.dispose();
  }

  bool _handleScroll(ScrollNotification notification) {
    if (notification.depth != 0 ||
        notification.metrics.axisDirection != AxisDirection.down) {
      return false;
    }
    switch (notification) {
      case ScrollStartNotification(dragDetails: != null)
          when _mode == _Mode.idle && notification.metrics.extentBefore == 0:
        _startDrag();
      case ScrollUpdateNotification() when _dragging:
        if (notification.metrics.extentBefore > 0) {
          _cancel();
        } else {
          _dragBy(-notification.scrollDelta!);
          // Bouncing physics: the release shows as the first update
          // without a drag.
          if (_mode == _Mode.armed && notification.dragDetails == null) {
            unawaited(_refresh());
          }
        }
      case OverscrollNotification() when _dragging:
        _dragBy(-notification.overscroll);
      case ScrollEndNotification() when _dragging:
        if (_mode == _Mode.armed) {
          unawaited(_refresh());
        } else {
          _cancel();
        }
      default:
        break;
    }
    return false;
  }

  /// Hides the platform's glow or stretch while the donut is out.
  bool _handleOverscrollIndicator(OverscrollIndicatorNotification n) {
    if (n.depth != 0 || !n.leading || !_dragging) return false;
    n.disallowIndicator();
    return true;
  }

  void _startDrag() {
    // A pull that catches the circle on its way back picks it up there.
    _pull.stop();
    _dragOffset =
        math.min(_pull.value, 1) * DonutRefreshIndicator.triggerDistance;
    _mode = _Mode.drag;
  }

  void _dragBy(double delta) {
    _dragOffset = math.max(_dragOffset + delta, 0);
    final travel = _dragOffset / DonutRefreshIndicator.triggerDistance;
    _pull.value = travel <= 1 ? travel : 1 + (travel - 1) * _overPullResistance;
    if (_mode == _Mode.drag && travel >= 1) {
      _mode = _Mode.armed;
      unawaited(HapticFeedback.lightImpact());
    } else if (_mode == _Mode.armed && travel < 1) {
      _mode = _Mode.drag;
    }
  }

  void _cancel() {
    _mode = _Mode.idle;
    _pull.animateTo(
      0,
      duration: context.motion.of(AppMotion.medium),
      curve: AppMotion.standard,
    );
  }

  Future<void> _refresh() async {
    final motion = context.motion;
    setState(() => _mode = _Mode.refresh);
    _pull.animateTo(
      1,
      duration: motion.cue(AppMotion.medium),
      curve: AppMotion.standard,
    );
    final expanded = _expand.animateTo(
      1,
      duration: motion.cue(AppMotion.slow),
      curve: AppMotion.emphasized,
    );
    if (!motion.reduced) _spin.repeat();
    try {
      // A fast refresh still lets the pill open and the label be read
      // before it folds away.
      await Future.wait([
        widget.onRefresh(),
        expanded.then((_) => Future<void>.delayed(_labelHold)),
      ]);
    } finally {
      if (mounted) await _finish();
    }
  }

  /// Folds the pill back into the circle, fades it out and resets.
  Future<void> _finish() async {
    final motion = context.motion;
    setState(() => _mode = _Mode.done);
    _spin.stop();
    await _expand.animateTo(
      0,
      duration: motion.cue(AppMotion.medium),
      curve: AppMotion.standard,
    );
    if (!mounted) return;
    await _exit.animateTo(
      1,
      duration: motion.of(AppMotion.fast),
      curve: Curves.easeIn,
    );
    if (!mounted) return;
    _pull.value = 0;
    _spin.value = 0;
    _exit.value = 0;
    _dragOffset = 0;
    setState(() => _mode = _Mode.idle);
  }

  @override
  Widget build(BuildContext context) =>
      NotificationListener<OverscrollIndicatorNotification>(
        onNotification: _handleOverscrollIndicator,
        child: NotificationListener<ScrollNotification>(
          onNotification: _handleScroll,
          child: Stack(
            children: [
              widget.child,
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: IgnorePointer(
                  child: ExcludeSemantics(
                    excluding: _mode != _Mode.refresh,
                    child: Semantics(
                      liveRegion: true,
                      child: AnimatedBuilder(
                        animation: _frame,
                        builder: _buildIndicator,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  Widget _buildIndicator(BuildContext context, Widget? _) {
    final pull = _pull.value;
    if (pull == 0) return const SizedBox.shrink();

    final shown = math.min<double>(pull, 1);
    final hiddenTop = widget.edgeOffset - AppSizes.refreshIndicator;
    final restTop = widget.edgeOffset + DonutRefreshIndicator.restOffset;
    final overPull =
        math.max(pull - 1, 0) * DonutRefreshIndicator.triggerDistance;
    final top = hiddenTop + (restTop - hiddenTop) * shown + overPull;

    final exit = _exit.value;
    final scale =
        (_enterScale + (1 - _enterScale) * shown) *
        (1 - (1 - _exitScale) * exit);
    final opacity = math.min<double>(shown * 2, 1) * (1 - exit);

    return Align(
      alignment: Alignment.topCenter,
      child: Transform.translate(
        offset: Offset(0, top),
        child: Transform.scale(
          scale: scale,
          child: Opacity(
            opacity: opacity,
            child: _DonutPill(
              expand: _expand.value,
              turns: pull * _turnsPerPull + _spin.value,
            ),
          ),
        ),
      ),
    );
  }
}

/// The white circle with the donut. At [expand] 1 it is a pill with the
/// loading label to the donut's right.
class _DonutPill extends StatelessWidget {
  const new({required this.expand, required this.turns});

  final double expand;
  final double turns;

  static const String _donut = 'assets/images/reward_donut.png';

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final donutPixels =
        (AppSizes.refreshDonut * MediaQuery.devicePixelRatioOf(context))
            .round();

    return DecoratedBox(
      decoration: ShapeDecoration(
        color: colors.surface,
        shape: const StadiumBorder(),
        shadows: AppShadows.floating(colors),
      ),
      child: SizedBox(
        height: AppSizes.refreshIndicator,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox.square(
              dimension: AppSizes.refreshIndicator,
              child: Center(
                child: Transform.rotate(
                  angle: turns * 2 * math.pi,
                  child: Image.asset(
                    _donut,
                    width: AppSizes.refreshDonut,
                    height: AppSizes.refreshDonut,
                    cacheWidth: donutPixels,
                    excludeFromSemantics: true,
                  ),
                ),
              ),
            ),
            if (expand > 0)
              ClipRect(
                child: Align(
                  alignment: Alignment.centerLeft,
                  widthFactor: expand,
                  child: Opacity(
                    opacity: expand,
                    child: Padding(
                      padding: const EdgeInsets.only(right: AppSpacing.xl),
                      child: Text(
                        context.l10n.refreshLoading,
                        style: context.text.label,
                        maxLines: 1,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
