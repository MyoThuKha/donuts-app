import 'package:donuts/core/l10n/l10n.dart';
import 'package:donuts/core/theme/app_dimens.dart';
import 'package:donuts/core/theme/theme_context.dart';
import 'package:donuts/core/widgets/feedback/section_empty_state.dart';
import 'package:donuts/features/home/domain/vo/home_section_vo.dart';
import 'package:donuts/features/home/presentation/home_dimens.dart';
import 'package:donuts/features/home/presentation/items/product_tile_item.dart';
import 'package:donuts/features/home/presentation/widgets/see_all_button_widget.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:material_ui/material_ui.dart';

/// One Home row: its title, then its products side by side.
class ProductSectionView extends StatelessWidget {
  const new({required this.section, super.key});

  final HomeSectionVO section;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.xxl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: AppSpacing.s,
        children: [
          _SectionTitle(section: section),
          if (section.products.isEmpty)
            SectionEmptyState(message: context.l10n.homeSectionEmpty)
          else
            _ProductRow(section: section),
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
        spacing: AppSpacing.xs,
        children: [
          Flexible(
            child: Semantics(
              header: true,
              child: Text(title, style: context.text.sectionTitle),
            ),
          ),
          if (section.kind == HomeSectionKind.popular)
            ExcludeSemantics(
              child: Icon(
                LucideIcons.flame,
                size: HomeDimens.flameIcon,
                color: context.colors.highlight,
              ),
            ),
          const Spacer(),
          const SeeAllButtonWidget(),
        ],
      ),
    );
  }
}

class _ProductRow extends StatelessWidget {
  const new({required this.section});

  final HomeSectionVO section;

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
          for (final product in section.products)
            ProductTileItem(
              product: product,
              sectionId: section.id,
              imageSize: imageSize,
            ),
        ],
      ),
    );
  }
}
