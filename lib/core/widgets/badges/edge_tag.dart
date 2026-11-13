import 'package:material_ui/material_ui.dart';

/// A tag that runs off the right edge of the screen: round on the left,
/// square on the right, as the design draws the Home bell and the Rewards
/// pill. Place it flush with the edge.
class EdgeTag extends StatelessWidget {
  const new({
    required this.color,
    required this.height,
    required this.child,
    this.rim,
    this.padding = EdgeInsets.zero,
    super.key,
  });

  final Color color;
  final double height;
  final Widget child;

  /// A thin outline on the rounded side, where the tag sits on a coloured
  /// background. Null draws none.
  final Color? rim;

  final EdgeInsetsGeometry padding;

  static const double _rimWidth = 1.5;

  @override
  Widget build(BuildContext context) {
    final rim = this.rim;
    return DecoratedBox(
      decoration: ShapeDecoration(
        color: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.horizontal(
            left: Radius.circular(height / 2),
          ),
          side: rim == null
              ? BorderSide.none
              : BorderSide(color: rim, width: _rimWidth),
        ),
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: height),
        child: Padding(
          padding: padding,
          child: Row(mainAxisSize: MainAxisSize.min, children: [child]),
        ),
      ),
    );
  }
}
