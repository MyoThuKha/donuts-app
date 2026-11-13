import 'package:donuts/core/motion/stagger.dart';
import 'package:donuts/core/theme/app_dimens.dart';
import 'package:donuts/core/widgets/effects/progressive_fade.dart';
import 'package:donuts/features/auth/presentation/auth_assets.dart';
import 'package:material_ui/material_ui.dart';

/// A rounded tile holding a donut photo. Its rect is in fractions of the
/// view's size.
typedef WelcomeTile = ({Rect rect, String image});

/// The four donut tiles from design screen 7. The right column bleeds off
/// the edge and sits lower, as drawn.
const List<WelcomeTile> welcomeTiles = [
  (rect: Rect.fromLTRB(0, 0, 0.54, 0.46), image: AuthAssets.purpleDonut),
  (rect: Rect.fromLTRB(0.6, 0.08, 1.08, 0.52), image: AuthAssets.stripedDonut),
  (rect: Rect.fromLTRB(0, 0.5, 0.54, 0.96), image: AuthAssets.sprinkledDonut),
  (rect: Rect.fromLTRB(0.6, 0.56, 1.08, 1), image: AuthAssets.chocolateDonut),
];

class WelcomeTilesView extends StatelessWidget {
  const new({super.key});

  /// How far, in tile widths, each tile slides in from its side.
  static const double _slide = 0.4;

  /// Where the fade starts, as a share of the view's height.
  static const double _fadeStart = 0.62;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = constraints.biggest;
        // The lower tiles dissolve into the pink above the title.
        return ProgressiveFade(
          start: _fadeStart,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              for (final (i, tile) in welcomeTiles.indexed)
                Positioned.fromRect(
                  rect: Rect.fromLTRB(
                    tile.rect.left * size.width,
                    tile.rect.top * size.height,
                    tile.rect.right * size.width,
                    tile.rect.bottom * size.height,
                  ),
                  child: StaggeredEntrance(
                    index: i,
                    from: Offset(i.isEven ? -_slide : _slide, 0),
                    child: WelcomeTileItem(tile: tile),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}

class WelcomeTileItem extends StatelessWidget {
  const new({required this.tile, super.key});

  /// How far the photo is enlarged inside the tile, so the donut fills it
  /// as in the design.
  static const double zoom = 1.8;

  final WelcomeTile tile;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppRadii.card),
      child: Transform.scale(
        scale: zoom,
        child: Image.asset(
          tile.image,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
          excludeFromSemantics: true,
        ),
      ),
    );
  }
}
