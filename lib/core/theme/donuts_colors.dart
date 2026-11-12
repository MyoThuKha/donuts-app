import 'package:material_ui/material_ui.dart';

/// J'Donuts colour tokens, sampled from the client designs.
@immutable
class DonutsColors extends ThemeExtension<DonutsColors> {
  const new({
    required this.primary,
    required this.onPrimary,
    required this.accent,
    required this.highlight,
    required this.bannerIndigo,
    required this.success,
    required this.ink,
    required this.inkMuted,
    required this.inkSubtle,
    required this.surface,
    required this.canvas,
    required this.authTop,
    required this.authBottom,
    required this.memberHeader,
    required this.disabled,
    required this.tierLine,
    required this.tierSilver,
    required this.tierGold,
    required this.tierPlatinum,
    required this.danger,
  });

  factory _fromValues(List<Color> v) => DonutsColors(
    primary: v[0],
    onPrimary: v[1],
    accent: v[2],
    highlight: v[3],
    bannerIndigo: v[4],
    success: v[5],
    ink: v[6],
    inkMuted: v[7],
    inkSubtle: v[8],
    surface: v[9],
    canvas: v[10],
    authTop: v[11],
    authBottom: v[12],
    memberHeader: v[13],
    disabled: v[14],
    tierLine: v[15],
    tierSilver: v[16],
    tierGold: v[17],
    tierPlatinum: v[18],
    danger: v[19],
  );

  static const DonutsColors light = DonutsColors(
    primary: Color(0xFF88D4EC),
    onPrimary: Color(0xFFFFFFFF),
    accent: Color(0xFFE87BAC),
    highlight: Color(0xFFF3984B),
    bannerIndigo: Color(0xFF7070B0),
    success: Color(0xFF9FC566),
    ink: Color(0xFF1D2931),
    inkMuted: Color(0xFF343D44),
    inkSubtle: Color(0xFF89939D),
    surface: Color(0xFFFFFFFF),
    canvas: Color(0xFFF1F3F3),
    authTop: Color(0xFFFBF1F5),
    authBottom: Color(0xFFFFFFFF),
    memberHeader: Color(0xFFFCF0E4),
    disabled: Color(0xFFEBEBEB),
    tierLine: Color(0xFF878787),
    tierSilver: Color(0xFFBFC3C7),
    tierGold: Color(0xFFE9D27A),
    tierPlatinum: Color(0xFFBFE3F2),
    danger: Color(0xFFD9534F),
  );

  final Color primary;
  final Color onPrimary;
  final Color accent;
  final Color highlight;
  final Color bannerIndigo;
  final Color success;
  final Color ink;
  final Color inkMuted;
  final Color inkSubtle;
  final Color surface;
  final Color canvas;
  final Color authTop;
  final Color authBottom;
  final Color memberHeader;
  final Color disabled;
  final Color tierLine;
  final Color tierSilver;
  final Color tierGold;
  final Color tierPlatinum;

  /// Validation and error messages. Not in the client designs; chosen so
  /// errors don't read as accent-pink links.
  final Color danger;

  List<Color> get _values => [
    primary,
    onPrimary,
    accent,
    highlight,
    bannerIndigo,
    success,
    ink,
    inkMuted,
    inkSubtle,
    surface,
    canvas,
    authTop,
    authBottom,
    memberHeader,
    disabled,
    tierLine,
    tierSilver,
    tierGold,
    tierPlatinum,
    danger,
  ];

  /// The design has a single light palette, so tokens are never overridden
  /// one by one. Returns this palette unchanged.
  @override
  DonutsColors copyWith() => this;

  @override
  DonutsColors lerp(DonutsColors? other, double t) {
    if (other == null) return this;
    final from = _values;
    final to = other._values;
    return DonutsColors._fromValues([
      for (var i = 0; i < from.length; i++) Color.lerp(from[i], to[i], t)!,
    ]);
  }
}
