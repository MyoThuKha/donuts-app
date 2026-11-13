import 'package:donuts/core/di/locator.dart';
import 'package:donuts/core/motion/app_motion.dart';
import 'package:donuts/core/motion/stagger.dart';
import 'package:donuts/core/network/connectivity_cubit.dart';
import 'package:donuts/core/sync/presentation/pull_to_refresh.dart';
import 'package:donuts/core/theme/app_dimens.dart';
import 'package:donuts/core/theme/theme_context.dart';
import 'package:donuts/core/widgets/feedback/donut_refresh_indicator.dart';
import 'package:donuts/core/widgets/feedback/offline_banner.dart';
import 'package:donuts/features/home/presentation/blocs/home_cubit.dart';
import 'package:donuts/features/home/presentation/views/member_panel_view.dart';
import 'package:donuts/features/home/presentation/views/product_sections_view.dart';
import 'package:donuts/features/home/presentation/views/shops_band_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';

/// Home (screen 8). Every section reads the local database through
/// [HomeCubit], so it renders offline.
class HomeScreen extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => getIt<HomeCubit>()..start(),
    child: const _HomePage(),
  );
}

class _HomePage extends StatelessWidget {
  const new();

  /// Stagger order: header, banners, then the product rows, then shops.
  static const int _firstSectionIndex = 2;
  static const int _shopsIndex = 5;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final inset = MediaQuery.paddingOf(context).top;

    return BlocSelector<ConnectivityCubit, ConnectivityStatus, bool>(
      selector: (status) => status == ConnectivityStatus.offline,
      builder: (context, offline) => ColoredBox(
        color: colors.canvas,
        child: Column(
          children: [
            _Offline(visible: offline, topInset: inset),
            Expanded(
              child: MediaQuery.removePadding(
                context: context,
                removeTop: offline,
                child: DonutRefreshIndicator(
                  edgeOffset: offline ? 0 : inset,
                  onRefresh: () => _refresh(context),
                  child: CustomScrollView(
                    // Clamping: a pull shows the donut over the header
                    // without dragging the page down and opening a gap.
                    physics: const AlwaysScrollableScrollPhysics(
                      parent: ClampingScrollPhysics(),
                    ),
                    slivers: _slivers(context),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Undoes any Earn, so the header shows the stored points again, and
  /// refreshes the catalog.
  Future<void> _refresh(BuildContext context) {
    context.read<HomeCubit>().resetRewardClaims();
    return refreshCatalogFromPull(context);
  }

  List<Widget> _slivers(BuildContext context) {
    // Home runs under the nav, so the bottom padding already covers the
    // nav and the home indicator.
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

/// The offline banner at the top of the screen. It opens a strip of its own
/// height, plus the status bar's, so it pushes Home down instead of covering
/// the header, and folds away when the app is back online.
class _Offline extends StatelessWidget {
  const new({required this.visible, required this.topInset});

  final bool visible;
  final double topInset;

  @override
  Widget build(BuildContext context) => ClipRect(
    child: AnimatedAlign(
      alignment: Alignment.topCenter,
      heightFactor: visible ? 1 : 0,
      duration: context.motion.of(AppMotion.medium),
      curve: AppMotion.standard,
      child: ColoredBox(
        color: context.colors.inkMuted,
        child: Padding(
          padding: EdgeInsets.only(top: topInset),
          child: OfflineBanner(visible: visible),
        ),
      ),
    ),
  );
}
