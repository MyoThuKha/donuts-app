import 'package:donuts/core/theme/donuts_colors.dart';
import 'package:material_ui/material_ui.dart';

/// J'Donuts type scale, measured from the client designs.
@immutable
class DonutsText extends ThemeExtension<DonutsText> {
  const new({
    required this.display,
    required this.title,
    required this.headline,
    required this.sectionTitle,
    required this.body,
    required this.bodySmall,
    required this.label,
    required this.button,
    required this.caption,
    required this.points,
  });

  factory fromColors(DonutsColors c) => DonutsText(
    display: _style(28, FontWeight.w800, c.ink, height: 1.2),
    title: _style(26, FontWeight.w700, c.ink, height: 1.2),
    headline: _style(22, FontWeight.w700, c.ink),
    sectionTitle: _style(18, FontWeight.w700, c.ink),
    body: _style(15, FontWeight.w400, c.inkMuted),
    bodySmall: _style(13, FontWeight.w500, c.inkMuted),
    label: _style(13, FontWeight.w600, c.ink),
    button: _style(14, FontWeight.w800, c.onPrimary, letterSpacing: 1.2),
    caption: _style(11, FontWeight.w400, c.inkSubtle),
    points: _style(34, FontWeight.w800, c.accent),
  );

  static const String fontFamily = 'PlusJakartaSans';

  final TextStyle display;
  final TextStyle title;
  final TextStyle headline;
  final TextStyle sectionTitle;
  final TextStyle body;
  final TextStyle bodySmall;
  final TextStyle label;
  final TextStyle button;
  final TextStyle caption;
  final TextStyle points;

  static TextStyle _style(
    double size,
    FontWeight weight,
    Color color, {
    double? height,
    double? letterSpacing,
  }) => TextStyle(
    fontFamily: fontFamily,
    fontSize: size,
    fontWeight: weight,
    color: color,
    height: height,
    letterSpacing: letterSpacing,
  );

  /// The type scale is fixed by the design. Returns this scale unchanged.
  @override
  DonutsText copyWith() => this;

  @override
  DonutsText lerp(DonutsText? other, double t) {
    if (other == null) return this;
    TextStyle mix(TextStyle a, TextStyle b) => TextStyle.lerp(a, b, t)!;
    return DonutsText(
      display: mix(display, other.display),
      title: mix(title, other.title),
      headline: mix(headline, other.headline),
      sectionTitle: mix(sectionTitle, other.sectionTitle),
      body: mix(body, other.body),
      bodySmall: mix(bodySmall, other.bodySmall),
      label: mix(label, other.label),
      button: mix(button, other.button),
      caption: mix(caption, other.caption),
      points: mix(points, other.points),
    );
  }
}
