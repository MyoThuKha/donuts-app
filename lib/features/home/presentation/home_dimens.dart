import 'package:donuts/features/home/domain/vo/home_section_vo.dart';
import 'package:material_ui/material_ui.dart';

/// Layout numbers only Home uses, measured from the design (±2 pt).
abstract final class HomeDimens {
  static const double avatar = 52;
  static const double bellIcon = 18;
  static const double bellBadge = 18;
  static const double chipHeight = 24;
  static const double seeAllButton = 28;
  static const double seeAllIcon = 16;
  static const double flameIcon = 20;

  static const double bannerHeight = 168;
  static const double bannerViewportFraction = 0.8;

  /// Share of the banner's width and height its photo takes.
  static const Size bannerImageFactor = Size(0.66, 0.42);
  static const Duration carouselInterval = Duration(seconds: 4);

  static const double shopCardWidth = 236;
  static const double shopImageHeight = 120;

  /// Skeleton line sizes while a section loads.
  static const double skeletonTitleWidth = 140;
  static const double skeletonLine = 16;
  static const int skeletonTiles = 3;

  /// Image size of one tile, by row: wide photos for seasonal boxes, tall
  /// cards for Popular, squares elsewhere.
  static Size tileImage(HomeSectionKind kind) => switch (kind) {
    HomeSectionKind.seasonal => const Size(236, 156),
    HomeSectionKind.popular => const Size(156, 200),
    HomeSectionKind.orderAgain || HomeSectionKind.other => const Size(156, 156),
  };
}
