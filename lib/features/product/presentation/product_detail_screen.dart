import 'package:donuts/core/l10n/l10n.dart';
import 'package:donuts/core/theme/app_dimens.dart';
import 'package:donuts/core/theme/theme_context.dart';
import 'package:donuts/core/widgets/images/product_hero_tag.dart';
import 'package:material_ui/material_ui.dart';

/// Product detail (screen 9). A stub until branch 5 builds it.
class ProductDetailScreen extends StatelessWidget {
  const new({required this.productId, this.heroTag, super.key});

  final String productId;

  /// The Hero tag of the tile that opened this screen. Null means the
  /// plain `productHeroTag(productId)`.
  final Object? heroTag;

  static const double _imageSize = 160;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.colors.canvas,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Hero(
              tag: heroTag ?? productHeroTag(productId),
              child: const SizedBox.square(dimension: _imageSize),
            ),
            Padding(
              padding: const EdgeInsets.all(AppSpacing.pageGutter),
              child: Text(
                context.l10n.placeholderComingSoon(productId),
                style: context.text.sectionTitle,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
