import 'package:donuts/core/l10n/l10n.dart';
import 'package:donuts/core/theme/app_dimens.dart';
import 'package:donuts/core/theme/theme_context.dart';
import 'package:donuts/core/widgets/feedback/skeleton.dart';
import 'package:donuts/features/product/presentation/product_dimens.dart';
import 'package:material_ui/material_ui.dart';

/// "What's this?" with a green dot, a thin divider, then the description.
class ProductDescriptionView extends StatelessWidget {
  const new({required this.description, super.key});

  /// Null while the product loads. Skeleton lines stand in for it.
  final String? description;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final text = context.text;
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: AppSpacing.m,
        children: [
          SizedBox(
            width: ProductDimens.whatsThisColumnWidth,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: AppSpacing.xs,
              children: [
                DecoratedBox(
                  decoration: ShapeDecoration(
                    color: colors.success,
                    shape: const CircleBorder(),
                  ),
                  child: const SizedBox.square(
                    dimension: ProductDimens.whatsThisDot,
                  ),
                ),
                Text(context.l10n.productWhatsThis, style: text.label),
              ],
            ),
          ),
          ColoredBox(
            color: colors.disabled,
            child: const SizedBox(width: ProductDimens.dividerThickness),
          ),
          Expanded(
            child: switch (description) {
              final description? => Text(
                description,
                style: text.bodySmall.copyWith(color: colors.inkMuted),
              ),
              null => const _DescriptionSkeleton(),
            },
          ),
        ],
      ),
    );
  }
}

class _DescriptionSkeleton extends StatelessWidget {
  const new();

  @override
  Widget build(BuildContext context) => SkeletonGroup(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppSpacing.s,
      children: [
        for (var i = 0; i < ProductDimens.skeletonDescriptionLines; i++)
          FractionallySizedBox(
            widthFactor: i == ProductDimens.skeletonDescriptionLines - 1
                ? ProductDimens.skeletonLastLineFactor
                : 1,
            child: const Skeleton(height: ProductDimens.skeletonSmallLine),
          ),
      ],
    ),
  );
}
