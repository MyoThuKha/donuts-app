/// A banner's background colour, named by theme token rather than hex.
enum BannerStyle {
  indigo,
  sky;

  /// Reads the catalog's `style` text. Anything unknown falls back to
  /// [sky], so a new style on the server never breaks the carousel.
  static BannerStyle parse(String name) =>
      values.where((s) => s.name == name).firstOrNull ?? sky;
}
