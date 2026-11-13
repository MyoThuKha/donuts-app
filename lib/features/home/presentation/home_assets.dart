/// Bundled images only Home uses.
abstract final class HomeAssets {
  /// The member panel's backdrop for a tier: a tinted wash with that tier's
  /// hexagon on the right. Null for no tier or a tier without its own art,
  /// where the panel shows its plain colour.
  static String? headerBackdrop(String? tierId) => switch (tierId) {
    'silver' => 'assets/images/home_header_silver.jpg',
    'gold' => 'assets/images/home_header_gold.jpg',
    'platinum' => 'assets/images/home_header_platinum.jpg',
    _ => null,
  };

  /// The sky, trees and grass behind the shops band. The grass runs along
  /// the bottom, under the nav.
  static const String shopsBackdrop = 'assets/images/home_shops_backdrop.jpg';
}
