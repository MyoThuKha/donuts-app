import 'package:material_ui/material_ui.dart';

/// Positions [child] horizontally and animates it with a stretch: the edge
/// facing the direction of travel leaves first and the trailing edge catches
/// up, so the child grows mid-flight and settles back to [width].
class StretchyPositionWidget extends ImplicitlyAnimatedWidget {
  const new({
    required this.left,
    required this.width,
    required this.top,
    required this.bottom,
    required this.child,
    required super.duration,
    super.curve,
    super.key,
  });

  /// Share of the run after which the leading edge has arrived.
  static const double leadingEnd = 0.7;

  /// Share of the run before which the trailing edge stays put.
  static const double trailingStart = 0.3;

  final double left;
  final double width;
  final double top;
  final double bottom;
  final Widget child;

  @override
  AnimatedWidgetBaseState<StretchyPositionWidget> createState() =>
      _StretchyPositionState();
}

class _StretchyPositionState
    extends AnimatedWidgetBaseState<StretchyPositionWidget> {
  Tween<double>? _left;
  Tween<double>? _right;

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    _left = visitor(
      _left,
      widget.left,
      (value) => Tween<double>(begin: value as double),
    ) as Tween<double>?;
    _right = visitor(
      _right,
      widget.left + widget.width,
      (value) => Tween<double>(begin: value as double),
    ) as Tween<double>?;
  }

  @override
  Widget build(BuildContext context) {
    final leftTween = _left!;
    final rightTween = _right!;
    final movingRight = (leftTween.end ?? 0) >= (leftTween.begin ?? 0);
    final leading = Interval(
      0,
      StretchyPositionWidget.leadingEnd,
      curve: widget.curve,
    );
    final trailing = Interval(
      StretchyPositionWidget.trailingStart,
      1,
      curve: widget.curve,
    );
    final t = controller.value;
    final left = leftTween.transform(
      (movingRight ? trailing : leading).transform(t),
    );
    final right = rightTween.transform(
      (movingRight ? leading : trailing).transform(t),
    );
    return Positioned(
      left: left,
      width: right - left,
      top: widget.top,
      bottom: widget.bottom,
      child: widget.child,
    );
  }
}
