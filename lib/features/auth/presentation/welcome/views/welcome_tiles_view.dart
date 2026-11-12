import 'package:donuts/core/theme/app_dimens.dart';
import 'package:donuts/core/theme/donuts_colors.dart';
import 'package:donuts/core/theme/theme_context.dart';
import 'package:donuts/core/widgets/images/donut_placeholder.dart';
import 'package:material_ui/material_ui.dart';

/// A tinted tile holding a donut. Its rect is in fractions of the view's size.
typedef WelcomeTile = ({
  Rect rect,
  Color Function(DonutsColors c) tint,
  Color Function(DonutsColors c) glaze,
});

/// Tile tint strength over the page background.
const double _tintAlpha = 0.45;

/// The four donut tiles from design screen 7. The right column bleeds off
/// the edge and sits lower, as drawn.
final List<WelcomeTile> welcomeTiles = [
  (
    rect: const Rect.fromLTRB(0, 0, 0.54, 0.46),
    tint: (c) => c.primary,
    glaze: (c) => c.bannerIndigo,
  ),
  (
    rect: const Rect.fromLTRB(0.6, 0.08, 1.08, 0.52),
    tint: (c) => c.accent,
    glaze: (c) => c.inkMuted,
  ),
  (
    rect: const Rect.fromLTRB(0, 0.5, 0.54, 0.96),
    tint: (c) => c.highlight,
    glaze: (c) => c.accent,
  ),
  (
    rect: const Rect.fromLTRB(0.6, 0.56, 1.08, 1),
    tint: (c) => c.highlight,
    glaze: (c) => c.inkMuted,
  ),
];

class WelcomeTilesView extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = constraints.biggest;
        return Stack(
          clipBehavior: Clip.none,
          children: [
            for (final tile in welcomeTiles)
              Positioned.fromRect(
                rect: Rect.fromLTRB(
                  tile.rect.left * size.width,
                  tile.rect.top * size.height,
                  tile.rect.right * size.width,
                  tile.rect.bottom * size.height,
                ),
                child: WelcomeTileItem(tile: tile),
              ),
          ],
        );
      },
    );
  }
}

class WelcomeTileItem extends StatelessWidget {
  const new({required this.tile, super.key});

  /// Share of the tile's shorter side the donut fills.
  static const double donutShare = 0.78;

  final WelcomeTile tile;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: tile.tint(colors).withValues(alpha: _tintAlpha),
        borderRadius: BorderRadius.circular(AppRadii.card),
      ),
      child: FractionallySizedBox(
        widthFactor: donutShare,
        heightFactor: donutShare,
        child: DonutPlaceholder(glaze: tile.glaze(colors)),
      ),
    );
  }
}
