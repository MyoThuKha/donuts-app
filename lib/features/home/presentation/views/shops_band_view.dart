import 'dart:math' as math;

import 'package:donuts/core/l10n/l10n.dart';
import 'package:donuts/core/theme/app_dimens.dart';
import 'package:donuts/core/theme/theme_context.dart';
import 'package:donuts/core/widgets/buttons/pill_button.dart';
import 'package:donuts/core/widgets/feedback/app_snack_bar.dart';
import 'package:donuts/core/widgets/feedback/section_empty_state.dart';
import 'package:donuts/core/widgets/feedback/section_error_state.dart';
import 'package:donuts/core/widgets/feedback/skeleton.dart';
import 'package:donuts/features/home/domain/vo/shop_vo.dart';
import 'package:donuts/features/home/presentation/blocs/home_cubit.dart';
import 'package:donuts/features/home/presentation/blocs/home_state.dart';
import 'package:donuts/features/home/presentation/blocs/section_state.dart';
import 'package:donuts/features/home/presentation/home_assets.dart';
import 'package:donuts/features/home/presentation/home_dimens.dart';
import 'package:donuts/features/home/presentation/items/shop_card_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';

/// The band at the bottom of Home, on a sky-and-garden scene: how many
/// shops are near, an Explore now button and the shop cards. It runs under
/// the floating nav, so [bottomInset] keeps the cards clear of it.
class ShopsBandView extends StatelessWidget {
  const new({required this.bottomInset, super.key});

  final double bottomInset;

  @override
  Widget build(BuildContext context) {
    final shops = context.select<HomeCubit, SectionState<List<ShopVO>>>(
      (c) => c.state.shops,
    );
    final l10n = context.l10n;
    // Home runs under the nav, so the bottom padding is the nav plus the
    // home indicator. The scene ends where the nav's pink band starts, so
    // the grass shows beside and above the nav's top half.
    final sceneBottom = math
        .max(0, MediaQuery.paddingOf(context).bottom - AppSizes.navBar / 2)
        .toDouble();
    return ColoredBox(
      // The sky colour shows until the scene decodes.
      color: context.colors.primary,
      child: Stack(
        children: [
          Positioned.fill(
            bottom: sceneBottom,
            child: const DecoratedBox(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(HomeAssets.shopsBackdrop),
                  fit: BoxFit.cover,
                  // Crops the sky, never the grass.
                  alignment: Alignment.bottomCenter,
                ),
              ),
            ),
          ),
          _content(shops, l10n, context),
        ],
      ),
    );
  }

  Widget _content(
    SectionState<List<ShopVO>> shops,
    AppLocalizations l10n,
    BuildContext context,
  ) => Padding(
    padding: EdgeInsets.only(top: AppSpacing.xxl, bottom: bottomInset),
    child: switch (shops) {
      SectionReady(:final data) => _Shops(shops: data),
      SectionLoading() => const _ShopsSkeleton(),
      SectionEmpty() => SectionEmptyState(message: l10n.homeSectionEmpty),
      SectionFailed() => SectionErrorState(
        message: l10n.homeSectionError,
        onRetry: () => context.read<HomeCubit>().retry(HomeSectionId.shops),
      ),
    },
  );
}

class _Shops extends StatelessWidget {
  const new({required this.shops});

  final List<ShopVO> shops;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppSpacing.l,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.pageGutter,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: AppSpacing.m,
            children: [
              Text(
                context.l10n.homeShopsTitle(shops.length),
                style: context.text.headline.copyWith(color: colors.onPrimary),
              ),
              AppPillButton(
                label: context.l10n.homeExploreNow,
                onPressed: () =>
                    context.showMessage(context.l10n.featureComingSoon),
              ),
            ],
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.pageGutter,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: AppSpacing.m,
            children: [for (final shop in shops) ShopCardItem(shop: shop)],
          ),
        ),
      ],
    );
  }
}

class _ShopsSkeleton extends StatelessWidget {
  const new();

  @override
  Widget build(BuildContext context) => SkeletonGroup(
    child: Padding(
      padding: const EdgeInsets.only(left: AppSpacing.pageGutter),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: AppSpacing.l,
        children: [
          const Skeleton(
            width: HomeDimens.skeletonTitleWidth * 2,
            height: HomeDimens.skeletonLine,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const NeverScrollableScrollPhysics(),
            child: Row(
              spacing: AppSpacing.m,
              children: [
                for (var i = 0; i < HomeDimens.skeletonTiles; i++)
                  const Skeleton(
                    width: HomeDimens.shopCardWidth,
                    height: HomeDimens.shopImageHeight * 2,
                    radius: BorderRadius.all(Radius.circular(AppRadii.card)),
                  ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
