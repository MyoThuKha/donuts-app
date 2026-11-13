import 'package:donuts/core/l10n/l10n.dart';
import 'package:donuts/core/motion/app_motion.dart';
import 'package:donuts/core/theme/app_dimens.dart';
import 'package:donuts/core/theme/theme_context.dart';
import 'package:flutter/physics.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:material_ui/material_ui.dart';

/// A bottom sheet that slides up on [AppMotion.sheetSpring] and can be
/// dragged down to close. Open one with `.sheet(context)` on any widget.
///
/// The spring drives the route itself (through [createSimulation]), so a
/// drag released halfway carries its speed into the close or the snap back.
class AppSheetRoute<T> extends PopupRoute<T> {
  new({required this.child, required this.reduced, this.title, super.settings});

  final Widget child;

  /// Shown at the top left, with a close button on the right.
  final String? title;

  /// Reduce Motion: the sheet appears and leaves without sliding.
  final bool reduced;

  /// Sheet heights per second at release, carried into the spring.
  double _releaseVelocity = 0;

  final GlobalKey _sheetKey = GlobalKey();

  /// A drag past this share of the sheet's height closes it.
  static const double _closeShare = 0.35;

  /// A downward fling faster than this, in points per second, closes it.
  static const double _closeFlingSpeed = 700;

  static const double _radius = 32;

  @override
  Color? get barrierColor => Colors.black54;

  @override
  bool get barrierDismissible => true;

  @override
  String? get barrierLabel => null;

  @override
  Duration get transitionDuration => Duration.zero;

  @override
  Simulation? createSimulation({required bool forward}) {
    if (reduced) return null;
    final velocity = _releaseVelocity;
    _releaseVelocity = 0;
    return SpringSimulation(
      AppMotion.sheetSpring,
      controller!.value,
      forward ? 1 : 0,
      velocity,
      snapToEnd: true,
    );
  }

  double get _sheetHeight =>
      _sheetKey.currentContext?.size?.height ?? double.infinity;

  void _onDragUpdate(DragUpdateDetails details) {
    final delta = details.primaryDelta ?? 0;
    controller!.value = (controller!.value - delta / _sheetHeight).clamp(0, 1);
  }

  void _onDragEnd(DragEndDetails details) {
    final speed = details.primaryVelocity ?? 0;
    final value = controller!.value;
    // Spring velocity is in sheet heights per second, upward positive.
    _releaseVelocity = -speed / _sheetHeight;
    if (speed > _closeFlingSpeed || value < 1 - _closeShare) {
      navigator?.pop();
      return;
    }
    if (reduced) {
      controller!.value = 1;
      return;
    }
    controller!.animateWith(
      SpringSimulation(
        AppMotion.sheetSpring,
        value,
        1,
        _releaseVelocity,
        snapToEnd: true,
      ),
    );
    _releaseVelocity = 0;
  }

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    final colors = context.colors;
    return Align(
      alignment: Alignment.bottomCenter,
      child: GestureDetector(
        onVerticalDragUpdate: _onDragUpdate,
        onVerticalDragEnd: _onDragEnd,
        child: Material(
          key: _sheetKey,
          color: colors.canvas,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(_radius)),
          ),
          clipBehavior: Clip.antiAlias,
          child: SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.authGutter,
                AppSpacing.xxxl,
                AppSpacing.authGutter,
                AppSpacing.xxl,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                spacing: AppSpacing.xxl,
                children: [
                  _SheetHeader(title: title),
                  Flexible(child: child),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) => SlideTransition(
    position: animation.drive(
      Tween(begin: const Offset(0, 1), end: Offset.zero),
    ),
    child: child,
  );
}

class _SheetHeader extends StatelessWidget {
  const new({required this.title});

  final String? title;

  static const double _closeIcon = 28;

  @override
  Widget build(BuildContext context) {
    final title = this.title;
    return Row(
      children: [
        Expanded(
          child: title == null
              ? const SizedBox.shrink()
              : Semantics(
                  header: true,
                  child: Text(title, style: context.text.headline),
                ),
        ),
        IconButton(
          tooltip: context.l10n.close,
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(
            LucideIcons.x,
            size: _closeIcon,
            color: context.colors.ink,
          ),
        ),
      ],
    );
  }
}
