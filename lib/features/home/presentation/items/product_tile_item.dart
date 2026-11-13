import 'package:donuts/core/l10n/l10n.dart';
import 'package:donuts/core/motion/app_motion.dart';
import 'package:donuts/core/router/app_routes.dart';
import 'package:donuts/core/theme/app_dimens.dart';
import 'package:donuts/core/theme/theme_context.dart';
import 'package:donuts/core/widgets/badges/discount_badge.dart';
import 'package:donuts/core/widgets/buttons/pending_tap_guard.dart';
import 'package:donuts/core/widgets/images/product_hero_image.dart';
import 'package:donuts/core/widgets/images/product_hero_tag.dart';
import 'package:donuts/features/home/domain/vo/home_product_vo.dart';
import 'package:donuts/features/home/presentation/home_dimens.dart';
import 'package:donuts/features/home/presentation/widgets/press_scale_widget.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

/// One product in a Home row: a white card with the product in the middle,
/// or a photo filling the tile when [fillsTile] is set. Tapping it opens
/// Product detail, and the image flies there through a Hero scoped to
/// [sectionId].
class ProductTileItem extends StatelessWidget {
  const new({
    required this.product,
    required this.sectionId,
    required this.imageSize,
    this.fillsTile = false,
    super.key,
  });

  final HomeProductVO product;
  final String sectionId;
  final Size imageSize;

  /// True for a photo that fills the tile (seasonal boxes). False for a
  /// cut-out product, which sits whole in the middle of its card.
  final bool fillsTile;

  /// The discount badge's distance from the tile's bottom-right corner.
  /// [ProductHeroImage.tileRadius] assumes this inset for its curve.
  static const double _badgeInset = AppSpacing.s;

  Object get _heroTag => productHeroTag(product.id, scope: sectionId);

  @override
  Widget build(BuildContext context) {
    final discount = product.discountPercent;
    return _OpenProductTap(
      label: product.name,
      value: discount == null ? null : context.l10n.discountOff(discount),
      open: () =>
          context.push(AppRoutes.productDetail(product.id), extra: _heroTag),
      child: SizedBox(
        width: imageSize.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: AppSpacing.s,
          children: [
            _image(context),
            Text(
              product.name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: context.text.label,
            ),
          ],
        ),
      ),
    );
  }

  Widget _image(BuildContext context) {
    final discount = product.discountPercent;
    final radius = ProductHeroImage.tileRadius(context);
    return SizedBox.fromSize(
      size: imageSize,
      child: Stack(
        fit: StackFit.expand,
        children: [
          HeroMode(
            // Reduce Motion skips the flight; the page fades in instead.
            enabled: !context.motion.reduced,
            child: Hero(
              tag: _heroTag,
              flightShuttleBuilder: productHeroShuttle,
              child: ProductHeroImage(
                url: product.imageUrl,
                asset: product.imageAsset,
                radius: radius,
                fit: fillsTile ? BoxFit.cover : BoxFit.contain,
                inset: fillsTile ? 0 : HomeDimens.productInset,
              ),
            ),
          ),
          if (discount != null)
            Positioned(
              right: _badgeInset,
              bottom: _badgeInset,
              child: DiscountBadge(percent: discount),
            ),
        ],
      ),
    );
  }
}

/// The tile's tap, on the gesture and on the semantics node, so screen
/// readers and switch access can open the product and hear the discount as
/// its value. Taps are ignored while the detail page it opened is on top,
/// so a double tap opens one page.
class _OpenProductTap extends StatefulWidget {
  const new({
    required this.label,
    required this.value,
    required this.open,
    required this.child,
  });

  final String label;
  final String? value;
  final Future<void> Function() open;
  final Widget child;

  @override
  State<_OpenProductTap> createState() => _OpenProductTapState();
}

class _OpenProductTapState extends State<_OpenProductTap> with PendingTapGuard {
  void _tap() => runGuarded(widget.open);

  @override
  Widget build(BuildContext context) => Semantics(
    button: true,
    label: widget.label,
    value: widget.value,
    onTap: _tap,
    excludeSemantics: true,
    child: PressScaleWidget(onTap: _tap, child: widget.child),
  );
}
