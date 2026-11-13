import 'dart:ui';

/// Spacing scale and page gutters, in logical pixels.
abstract final class AppSpacing {
  static const double xs = 4;
  static const double s = 8;
  static const double m = 12;
  static const double l = 16;
  static const double xl = 20;
  static const double xxl = 24;
  static const double xxxl = 32;
  static const double huge = 40;

  /// Side padding on onboarding and registration pages.
  static const double authGutter = 32;

  /// Side padding on Home, Product detail and Rewards.
  static const double pageGutter = 20;
}

/// Corner radii. Buttons and pills use stadium shapes instead.
abstract final class AppRadii {
  /// Small labels such as "New".
  static const double badge = 6;
  static const double field = 8;
  static const double tile = 12;
  static const double card = 20;
  static const double nav = 32;

  /// The corner radius of a container that holds a shape of radius [inner]
  /// [inset] in from its corner, so the two curves share a centre.
  static double enclosing(double inner, double inset) => inner + inset;
}

/// Fixed component sizes.
abstract final class AppSizes {
  /// Minimum tap target for icon and text buttons.
  static const double button = 48;

  /// Height of the filled stadium buttons, as the design draws them.
  static const double filledButton = 52;
  static const double field = 56;
  static const Size otpBox = Size(48, 52);

  /// The bottom nav panel's height above the home indicator.
  static const double navBar = 80;
  static const double imageErrorIcon = 24;

  /// The thin white outline around badges that sit on photos.
  static const double rim = 1.5;

  /// The visible circle of a filled circle button and its icon. Its tap
  /// area is [button] square.
  static const double circleButton = 28;
  static const double circleButtonIcon = 16;
}
