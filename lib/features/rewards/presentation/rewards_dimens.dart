import 'dart:ui';

/// Sizes used only on the Rewards screen, measured from the design.
abstract final class RewardsDimens {
  static const double ringDiameter = 216;
  static const double ringStroke = 44;

  /// How far the ring runs past the right edge of the screen.
  static const double ringBleed = 28;

  static const Size shield = Size(30, 36);
  static const double tierLineWidth = 3;

  /// Height of a tier row before the line runs on to the next shield.
  static const double tierRowMinHeight = 92;

  static const double glowBlur = 16;
  static const double glowSpread = 2;
  static const double glowAlpha = 0.45;

  static const double pillHeight = 36;
  static const double badgeSize = 22;

  static const double tabHeight = 48;

  /// The white outline around each tab pill.
  static const double tabRim = 3;

  static const double cardArt = 96;
  static const double coffeeStroke = 8;
  static const double coffeeCupInset = 18;

  static const double earnMinWidth = 72;
  static const double earnHeight = 44;
  static const double pulseScale = 1.06;
}
