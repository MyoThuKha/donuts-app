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
    required this.cardTitle,
    required this.body,
    required this.bodySmall,
    required this.label,
    required this.button,
    required this.caption,
    required this.points,
    required this.pointsLabel,
    required this.badge,
    required this.bannerTitle,
    required this.link,
    required this.captionLink,
    required this.highlight,
    required this.error,
  });

  factory fromColors(DonutsColors c) => DonutsText(
    display: rounded(_style(28, FontWeight.w800, c.ink, height: 1.2)),
    title: rounded(_style(26, FontWeight.w700, c.ink, height: 1.2)),
    headline: rounded(_style(22, FontWeight.w800, c.ink, height: 1.2)),
    sectionTitle: rounded(_style(18, FontWeight.w700, c.ink)),
    tabActive: rounded(_style(18, FontWeight.w700, c.onPrimary)),
    cardTitle: _style(16, FontWeight.w800, c.ink),
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
    bannerTitle: rounded(_style(22, FontWeight.w800, c.onPrimary, height: 1.2)),
    link: _style(14, FontWeight.w700, c.accent),
    captionLink: _style(11, FontWeight.w400, c.accent),
    highlight: _style(13, FontWeight.w500, c.accent),
    error: _style(11, FontWeight.w400, c.danger),
  );

  /// Schibsted Grotesk, declared in pubspec: body text, labels and buttons.
  static const String fontFamily = 'SchibstedGrotesk';

  /// The design's rounded heading face.
  static const String roundedFamily = 'Nunito';

  /// Noto Sans Myanmar, declared in pubspec at weights 400 to 800.
  static const String myanmarFamily = 'NotoSansMyanmar';

  /// Families for the letters the main faces lack. Neither face has Myanmar
  /// script, and without a bundled fallback each platform picks its own
  /// font, with only Regular and Bold to match the type scale's weights.
  static const List<String> fallback = [myanmarFamily];

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

  /// The title on a content card, such as a Rewards challenge or gift, in
  /// the plain face like the design's card titles.
  final TextStyle cardTitle;
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

  /// [headline] on a coloured fill, such as a banner or the shops band.
  final TextStyle bannerTitle;

  /// A tappable [label], such as Resend or "Log in instead".
  final TextStyle link;

  /// A link inside [caption] text, such as Terms of Use.
  final TextStyle captionLink;

  /// A run picked out inside [bodySmall] text, such as the resend timer.
  final TextStyle highlight;

  /// A [caption]-sized message under a field or a step, in `danger`.
  final TextStyle error;

  static TextStyle _style(
    double size,
    FontWeight weight,
    Color color, {
    double? height,
    double? letterSpacing,
  }) => TextStyle(
    fontFamily: fontFamily,
    fontFamilyFallback: fallback,
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
      cardTitle: mix(cardTitle, other.cardTitle),
      body: mix(body, other.body),
      bodySmall: mix(bodySmall, other.bodySmall),
      label: mix(label, other.label),
      button: mix(button, other.button),
      caption: mix(caption, other.caption),
      points: mix(points, other.points),
      pointsLabel: mix(pointsLabel, other.pointsLabel),
      badge: mix(badge, other.badge),
      bannerTitle: mix(bannerTitle, other.bannerTitle),
      link: mix(link, other.link),
      captionLink: mix(captionLink, other.captionLink),
      highlight: mix(highlight, other.highlight),
      error: mix(error, other.error),
    );
  }
}
