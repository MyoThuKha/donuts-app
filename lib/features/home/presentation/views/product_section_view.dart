import 'package:donuts/core/l10n/l10n.dart';
import 'package:donuts/core/state/section_state.dart';
import 'package:donuts/core/theme/app_dimens.dart';
import 'package:donuts/core/theme/theme_context.dart';
import 'package:donuts/core/widgets/buttons/circle_filled_button.dart';
import 'package:donuts/core/widgets/feedback/app_snack_bar.dart';
import 'package:donuts/core/widgets/feedback/section_empty_state.dart';
import 'package:donuts/core/widgets/feedback/section_error_state.dart';
import 'package:donuts/core/widgets/feedback/skeleton.dart';
import 'package:donuts/features/home/domain/vo/home_product_vo.dart';
import 'package:donuts/features/home/domain/vo/home_section_vo.dart';
import 'package:donuts/features/home/presentation/blocs/home_cubit.dart';
import 'package:donuts/features/home/presentation/home_dimens.dart';
import 'package:donuts/features/home/presentation/items/product_tile_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:material_ui/material_ui.dart';

/// Follows the Popular title, as in the design.
const String _popularEmoji = '🔥';

/// One Home row: its title, then its products side by side. The products
/// load, empty and fail on their own, under the title.
class ProductSectionView extends StatelessWidget {
  const new({required this.section, super.key});

  final HomeSectionVO section;

  @override
  Widget build(BuildContext context) {
    final products = context
        .select<HomeCubit, SectionState<List<HomeProductVO>>>(
          (c) => c.state.row(section.id),
        );
    final l10n = context.l10n;
    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.xxl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: AppSpacing.s,
        children: [
          _SectionTitle(section: section),
          switch (products) {
            SectionReady(:final data) => _ProductRow(
              section: section,
              products: data,
            ),
            SectionLoading() => SkeletonGroup(
              child: ProductTilesSkeleton(kind: section.kind),
            ),
            SectionEmpty() => SectionEmptyState(message: l10n.homeSectionEmpty),
            SectionFailed() => SectionErrorState(
              message: l10n.homeSectionError,
              onRetry: () => context.read<HomeCubit>().retryRow(section.id),
            ),
          },
        ],
      ),
    );
  }
}

/// Placeholder tiles for one row, sized like the row's [kind]. Shimmers
/// inside a [SkeletonGroup].
class ProductTilesSkeleton extends StatelessWidget {
  const new({required this.kind, super.key});

  final HomeSectionKind kind;

  @override
  Widget build(BuildContext context) {
    final tile = HomeDimens.tileImage(kind);
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.pageGutter),
      child: Row(
        spacing: AppSpacing.m,
        children: [
          for (var i = 0; i < HomeDimens.skeletonTiles; i++)
            Skeleton(width: tile.width, height: tile.height),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const new({required this.section});

  final HomeSectionVO section;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final title = switch (section.kind) {
      HomeSectionKind.seasonal => l10n.homeSectionSeasonal,
      HomeSectionKind.popular => l10n.homeSectionPopular,
      HomeSectionKind.orderAgain => l10n.homeSectionOrderAgain,
      HomeSectionKind.other => section.titleKey,
    };
    return Padding(
      padding: const EdgeInsets.only(
        left: AppSpacing.pageGutter,
        right: AppSpacing.l,
      ),
      child: Row(
        children: [
          Expanded(
            child: Row(
              spacing: AppSpacing.xs,
              children: [
                Flexible(
                  child: Semantics(
                    header: true,
                    child: Text(title, style: context.text.headline),
                  ),
                ),
                if (section.kind == HomeSectionKind.popular)
                  ExcludeSemantics(
                    child: Text(_popularEmoji, style: context.text.headline),
                  ),
              ],
            ),
          ),
          AppCircleFilledButton(
            icon: LucideIcons.chevronRight,
            semanticLabel: context.l10n.homeSeeAll,
            onPressed: () =>
                context.showMessage(context.l10n.featureComingSoon),
          ),
        ],
      ),
    );
  }
}

class _ProductRow extends StatelessWidget {
  const new({required this.section, required this.products});

  final HomeSectionVO section;
  final List<HomeProductVO> products;

  @override
  Widget build(BuildContext context) {
    final imageSize = HomeDimens.tileImage(section.kind);
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.pageGutter),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: AppSpacing.m,
        children: [
          for (final product in products)
            ProductTileItem(
              product: product,
              sectionId: section.id,
              imageSize: imageSize,
              fillsTile: HomeDimens.fillsTile(section.kind),
            ),
        ],
      ),
    );
  }
}
