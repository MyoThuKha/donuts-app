import 'package:donuts/features/home/domain/vo/home_section_vo.dart';
import 'package:material_ui/material_ui.dart';

/// Layout numbers only Home uses, measured from the design (±2 pt).
abstract final class HomeDimens {
  static const double avatar = 52;

  /// The next-tier ring drawn outside the avatar: its line width and the
  /// gap between it and the photo.
  static const double avatarRingStroke = 5;
  static const double avatarRingGap = 2;

  static const double bellIcon = 18;
  static const double bellTagHeight = 32;
  static const double bellBadge = 18;
  static const double chipHeight = 24;

  static const double bannerHeight = 180;

  /// How much of a banner shows above the panel's bottom edge, which cuts
  /// the rest off.
  static const double bannerVisibleHeight = 168;

  /// The member panel's bottom corners and the white rim along its edge.
  static const double panelRadius = 28;
  static const double panelRim = 1.5;
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
    HomeSectionKind.popular => const Size(156, 232),
    HomeSectionKind.orderAgain || HomeSectionKind.other => const Size(156, 156),
  };

  /// Seasonal boxes are photos that fill their tile. Every other row shows
  /// a cut-out product in the middle of a white card.
  static bool fillsTile(HomeSectionKind kind) =>
      kind == HomeSectionKind.seasonal;

  /// Share of a white product card left blank on each side.
  static const double productInset = 0.15;
}
