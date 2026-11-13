import 'package:donuts/core/di/locator.dart';
import 'package:donuts/core/l10n/l10n.dart';
import 'package:donuts/core/motion/stagger.dart';
import 'package:donuts/core/sync/presentation/pull_to_refresh.dart';
import 'package:donuts/core/sync/presentation/seed_cubit.dart';
import 'package:donuts/core/theme/app_dimens.dart';
import 'package:donuts/core/theme/theme_context.dart';
import 'package:donuts/core/widgets/buttons/primary_button.dart';
import 'package:donuts/core/widgets/feedback/donut_refresh_indicator.dart';
import 'package:donuts/core/widgets/feedback/offline_banner_frame.dart';
import 'package:donuts/core/widgets/feedback/page_state_view.dart';
import 'package:donuts/features/home/presentation/blocs/home_cubit.dart';
import 'package:donuts/features/home/presentation/views/member_panel_view.dart';
import 'package:donuts/features/home/presentation/views/product_sections_view.dart';
import 'package:donuts/features/home/presentation/views/shops_band_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:material_ui/material_ui.dart';

/// Home (screen 8). Every section reads the local database through
/// [HomeCubit], so it renders offline.
class HomeScreen extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => getIt<HomeCubit>()..start(),
    child: BlocSelector<SeedCubit, SeedStatus, bool>(
      // Seeding only runs on screen during a retry after a failure.
      selector: (status) =>
          status == SeedStatus.failed || status == SeedStatus.seeding,
      builder: (context, seedFailed) =>
          seedFailed ? const _SeedFailed() : const _HomePage(),
    ),
  );
}

/// Shown when the bundled data never made it into the database, so every
/// section would be empty. Try again seeds once more; Home's streams then
/// pick up the data on their own.
class _SeedFailed extends StatelessWidget {
  const new();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final seed = context.watch<SeedCubit>();
    return ColoredBox(
      color: context.colors.canvas,
      child: PageStateView(
        icon: LucideIcons.databaseX,
        iconColor: context.colors.danger,
        title: l10n.homeSeedError,
        message: l10n.homeSeedErrorHint,
        action: AppPrimaryButton(
          label: l10n.homeRetry,
          loading: seed.state == SeedStatus.seeding,
          onPressed: seed.seed,
        ),
      ),
    );
  }
}

class _HomePage extends StatelessWidget {
  const new();

  /// Stagger order: header, banners, then the product rows, then shops.
  static const int _firstSectionIndex = 2;
  static const int _shopsIndex = 5;

  @override
  Widget build(BuildContext context) => ColoredBox(
    color: context.colors.canvas,
    child: OfflineBannerFrame(
      // Inside the frame, so the top padding is zero while the banner
      // already clears the status bar.
      child: Builder(
        builder: (context) => DonutRefreshIndicator(
          edgeOffset: MediaQuery.paddingOf(context).top,
          onRefresh: () => refreshCatalogFromPull(context),
          child: CustomScrollView(
            // Clamping: a pull shows the donut over the header without
            // dragging the page down and opening a gap.
            physics: const AlwaysScrollableScrollPhysics(
              parent: ClampingScrollPhysics(),
            ),
            slivers: _slivers(context),
          ),
        ),
      ),
    ),
  );

  List<Widget> _slivers(BuildContext context) {
    // Home runs under the nav, so the bottom padding already covers the
    // nav's height.
    final navClearance = MediaQuery.paddingOf(context).bottom + AppSpacing.xxxl;
    return [
      const SliverToBoxAdapter(child: MemberPanelView()),
      const ProductSectionsView(firstIndex: _firstSectionIndex),
      SliverPadding(
        padding: const EdgeInsets.only(top: AppSpacing.xxxl),
        sliver: SliverToBoxAdapter(
          child: StaggeredEntrance(
            index: _shopsIndex,
            child: ShopsBandView(bottomInset: navClearance),
          ),
        ),
      ),
    ];
  }
}
