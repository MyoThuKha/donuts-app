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
    required this.authMiddle,
    required this.authWash,
    required this.settingsHeader,
    required this.disabled,
    required this.tierLine,
    required this.tierSilver,
    required this.tierGold,
    required this.tierPlatinum,
    required this.tierRingStart,
    required this.tierRingEnd,
    required this.danger,
    required this.scrim,
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
    authMiddle: v[13],
    authWash: v[14],
    settingsHeader: v[15],
    disabled: v[16],
    tierLine: v[17],
    tierSilver: v[18],
    tierGold: v[19],
    tierPlatinum: v[20],
    tierRingStart: v[21],
    tierRingEnd: v[22],
    danger: v[23],
    scrim: v[24],
  );

  static const DonutsColors light = DonutsColors(
    primary: Color(0xFF58CFEC),
    onPrimary: Color(0xFFFFFFFF),
    accent: Color(0xFFEE589E),
    highlight: Color(0xFFFF7F1F),
    bannerIndigo: Color(0xFF5E5AA7),
    success: Color(0xFF9FC566),
    ink: Color(0xFF1D2931),
    inkMuted: Color(0xFF343D44),
    inkSubtle: Color(0xFF89939D),
    surface: Color(0xFFFFFFFF),
    canvas: Color(0xFFEEF0F1),
    authTop: Color(0xFFFCEAF1),
    authBottom: Color(0xFFFEEEF4),
    authMiddle: Color(0xFFFEF9FB),
    authWash: Color(0xFFFCEFF3),
    settingsHeader: Color(0xFFBFE6F2),
    disabled: Color(0xFFEBEBEB),
    tierLine: Color(0xFF878787),
    tierSilver: Color(0xFFBFC3C7),
    tierGold: Color(0xFFE9D27A),
    tierPlatinum: Color(0xFFBFE3F2),
    tierRingStart: Color(0xFFFBE2CB),
    tierRingEnd: Color(0xFFE5924B),
    danger: Color(0xFFD9534F),
    scrim: Color(0x8A000000),
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

  /// The sign-up steps run pink at [authTop], near-white at [authMiddle]
  /// and pink again at [authBottom], behind the footer.
  final Color authTop;
  final Color authBottom;
  final Color authMiddle;

  /// The flat pink behind Onboarding and Welcome.
  final Color authWash;

  /// The light blue behind the Settings header.
  final Color settingsHeader;
  final Color disabled;
  final Color tierLine;
  final Color tierSilver;
  final Color tierGold;
  final Color tierPlatinum;

  /// The ring around Home's avatar runs from [tierRingStart] at 12 o'clock
  /// to [tierRingEnd] at its tip.
  final Color tierRingStart;
  final Color tierRingEnd;

  /// Validation and error messages. Not in the client designs; chosen so
  /// errors don't read as accent-pink links.
  final Color danger;

  /// Dims the screen behind a sheet. Not in the client designs.
  final Color scrim;

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
    authMiddle,
    authWash,
    settingsHeader,
    disabled,
    tierLine,
    tierSilver,
    tierGold,
    tierPlatinum,
    tierRingStart,
    tierRingEnd,
    danger,
    scrim,
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
