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
    required this.tabActive,
    required this.body,
    required this.bodySmall,
    required this.label,
    required this.button,
    required this.caption,
    required this.points,
    required this.pointsLabel,
    required this.badge,
  });

  factory fromColors(DonutsColors c) => DonutsText(
    display: rounded(_style(28, FontWeight.w800, c.ink, height: 1.2)),
    title: rounded(_style(26, FontWeight.w700, c.ink, height: 1.2)),
    headline: rounded(_style(22, FontWeight.w800, c.ink, height: 1.2)),
    sectionTitle: rounded(_style(18, FontWeight.w700, c.ink)),
    tabActive: rounded(_style(18, FontWeight.w700, c.onPrimary)),
    body: _style(15, FontWeight.w400, c.inkMuted),
    bodySmall: _style(13, FontWeight.w500, c.inkMuted),
    label: _style(14, FontWeight.w700, c.ink),
    button: rounded(
      _style(14, FontWeight.w800, c.onPrimary, letterSpacing: 1.2),
    ),
    caption: _style(11, FontWeight.w400, c.inkSubtle),
    points: rounded(_style(34, FontWeight.w800, c.accent)),
    pointsLabel: _style(14, FontWeight.w700, c.accent),
    badge: _style(13, FontWeight.w700, c.onPrimary, height: 1),
  );

  /// Schibsted Grotesk, declared in pubspec: body text, labels and buttons.
  static const String fontFamily = 'SchibstedGrotesk';

  /// The design's rounded heading face.
  static const String roundedFamily = 'Nunito';

  /// [style] in Nunito, declared in pubspec at weights 500 to 800.
  static TextStyle rounded(TextStyle style) =>
      style.copyWith(fontFamily: roundedFamily);

  final TextStyle display;
  final TextStyle title;
  final TextStyle headline;
  final TextStyle sectionTitle;

  /// [sectionTitle] on a `primary` fill, such as the selected Rewards tab.
  /// Lerp from [sectionTitle] to animate a selection.
  final TextStyle tabActive;
  final TextStyle body;
  final TextStyle bodySmall;
  final TextStyle label;
  final TextStyle button;
  final TextStyle caption;
  final TextStyle points;

  /// The [label]-sized line that names a [points] value, in the same
  /// `accent`.
  final TextStyle pointsLabel;

  /// Badge labels such as "50% off". The line is exactly the font's size,
  /// so the badge's height comes from its padding.
  final TextStyle badge;

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
      tabActive: mix(tabActive, other.tabActive),
      body: mix(body, other.body),
      bodySmall: mix(bodySmall, other.bodySmall),
      label: mix(label, other.label),
      button: mix(button, other.button),
      caption: mix(caption, other.caption),
      points: mix(points, other.points),
      pointsLabel: mix(pointsLabel, other.pointsLabel),
      badge: mix(badge, other.badge),
    );
  }
}
