/// Layout numbers used only by Product detail.
abstract final class ProductDimens {
  /// The product image's width as a share of the card's.
  static const double imageWidthFactor = 0.6;

  static const double whatsThisDot = 10;
  static const double whatsThisColumnWidth = 64;
  static const double dividerThickness = 1;

  /// Skeleton lines while the product loads, each about the height of the
  /// text it stands in for.
  static const double skeletonSmallLine = 12;
  static const double skeletonLine = 16;
  static const double skeletonTitleLine = 24;
  static const double skeletonCodeWidth = 96;
  static const double skeletonNameWidth = 180;
  static const double skeletonPriceWidth = 112;

  /// The description's placeholder: full lines, then a shorter last one.
  static const int skeletonDescriptionLines = 3;
  static const double skeletonLastLineFactor = 0.6;
}
