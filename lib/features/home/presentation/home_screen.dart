import 'package:donuts/core/di/locator.dart';
import 'package:donuts/core/motion/stagger.dart';
import 'package:donuts/core/network/connectivity_cubit.dart';
import 'package:donuts/core/theme/app_dimens.dart';
import 'package:donuts/core/theme/theme_context.dart';
import 'package:donuts/core/widgets/feedback/offline_banner.dart';
import 'package:donuts/features/home/presentation/blocs/home_cubit.dart';
import 'package:donuts/features/home/presentation/views/banner_carousel_view.dart';
import 'package:donuts/features/home/presentation/views/home_header_view.dart';
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
    return ColoredBox(
      color: context.colors.canvas,
      child: Stack(
        children: [
          CustomScrollView(slivers: _slivers(context)),
          const Positioned(top: 0, left: 0, right: 0, child: _Offline()),
        ],
      ),
    );
  }

  List<Widget> _slivers(BuildContext context) {
    final navClearance =
        AppSizes.navBar + MediaQuery.paddingOf(context).bottom + AppSpacing.xxl;
    return [
      SliverToBoxAdapter(
        child: ColoredBox(
          color: context.colors.memberHeader,
          child: const StaggeredEntrance(index: 0, child: HomeHeaderView()),
        ),
      ),
      const SliverToBoxAdapter(
        child: StaggeredEntrance(index: 1, child: BannerCarouselView()),
      ),
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

class _Offline extends StatelessWidget {
  const new();

  @override
  Widget build(BuildContext context) => SafeArea(
    bottom: false,
    child: BlocSelector<ConnectivityCubit, ConnectivityStatus, bool>(
      selector: (status) => status == ConnectivityStatus.offline,
      builder: (context, offline) => OfflineBanner(visible: offline),
    ),
  );
}
