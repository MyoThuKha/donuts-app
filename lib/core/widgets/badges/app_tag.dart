import 'package:donuts/core/format/number_format.dart';
import 'package:donuts/core/theme/app_dimens.dart';
import 'package:donuts/core/theme/theme_context.dart';
import 'package:material_ui/material_ui.dart';

enum _TagKind { highlight, small, plain, count }

/// The app's one tag: a short label in a pill. Every tag-like label uses
/// it, in one of four looks:
/// - [AppTag.new]: bold white on the highlight orange, with a white rim, as
///   on "50% off" and "New".
/// - [AppTag.small]: the same colours, smaller, as on a banner's "New shop".
/// - [AppTag.plain]: grey text on white, as on the points-to-next-tier chip.
/// - [AppTag.count]: a bold number in a white circle, as on the bell and the
///   Rewards pill.
class AppTag extends StatelessWidget {
  const new({
    required this.label,
    this.cornerRadius,
    this.rim = true,
    super.key,
  }) : _kind = _TagKind.highlight,
       diameter = null;

  const new small({required this.label, super.key})
    : _kind = _TagKind.small,
      cornerRadius = null,
      rim = true,
      diameter = null;

  const new plain({required this.label, super.key})
    : _kind = _TagKind.plain,
      cornerRadius = null,
      rim = false,
      diameter = null;

  /// [count] grouped ("1,200"), at least [diameter] wide and tall, so a
  /// single digit sits in a circle.
  new count({required int count, required double this.diameter, super.key})
    : label = formatGrouped(count),
      _kind = _TagKind.count,
      cornerRadius = null,
      rim = false;

  final String label;

  /// Null for fully round ends.
  final double? cornerRadius;

  /// The thin white outline the design draws around orange tags.
  final bool rim;

  /// A count tag's smallest width and height. Null for the other tags.
  final double? diameter;

  final _TagKind _kind;

  static const EdgeInsets _padding = EdgeInsets.symmetric(
    horizontal: AppSpacing.m,
    vertical: AppSpacing.s,
  );

  /// The default tag's height at the current text size: one label line plus
  /// the padding. A pill's corner radius is half of it.
  static double heightOf(BuildContext context) {
    final style = context.text.badge;
    final line =
        MediaQuery.textScalerOf(context).scale(style.fontSize!) *
        (style.height ?? 1);
    return line + _padding.vertical;
  }

  EdgeInsets get _insets => switch (_kind) {
    _TagKind.highlight => _padding,
    _TagKind.small => const EdgeInsets.symmetric(
      horizontal: AppSpacing.s,
      vertical: AppSpacing.xs,
    ),
    _TagKind.plain => const EdgeInsets.symmetric(
      horizontal: AppSpacing.m,
      vertical: AppSpacing.s,
    ),
    _TagKind.count => const EdgeInsets.symmetric(horizontal: AppSpacing.xs),
  };

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final text = context.text;
    final (fill, style) = switch (_kind) {
      _TagKind.highlight => (colors.highlight, text.badge),
      _TagKind.small => (
        colors.highlight,
        text.caption.copyWith(color: colors.onPrimary),
      ),
      _TagKind.plain => (
        colors.surface,
        text.caption.copyWith(color: colors.inkMuted),
      ),
      _TagKind.count => (
        colors.surface,
        text.label.copyWith(color: colors.ink, fontWeight: FontWeight.w800),
      ),
    };
    final side = rim
        ? BorderSide(color: colors.surface, width: AppSizes.rim)
        : BorderSide.none;
    final cornerRadius = this.cornerRadius;
    final ShapeBorder shape = cornerRadius == null
        ? StadiumBorder(side: side)
        : RoundedRectangleBorder(
            side: side,
            borderRadius: BorderRadius.circular(cornerRadius),
          );
    final diameter = this.diameter ?? 0;
    return DecoratedBox(
      decoration: ShapeDecoration(color: fill, shape: shape),
      child: ConstrainedBox(
        constraints: BoxConstraints(minWidth: diameter, minHeight: diameter),
        child: Padding(
          padding: _insets,
          child: Center(
            widthFactor: 1,
            heightFactor: 1,
            child: Text(label, style: style),
          ),
        ),
      ),
    );
  }
}
