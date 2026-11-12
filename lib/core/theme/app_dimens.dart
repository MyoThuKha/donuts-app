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
  static const double field = 8;
  static const double tile = 12;
  static const double card = 20;
  static const double nav = 32;
}

/// Fixed component sizes.
abstract final class AppSizes {
  static const double button = 48;
  static const double field = 56;
  static const Size otpBox = Size(48, 52);

  /// The bottom nav panel's height above the home indicator.
  static const double navBar = 80;
  static const double imageErrorIcon = 24;
}
