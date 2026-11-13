import 'package:donuts/core/motion/stagger.dart';
import 'package:donuts/core/theme/theme_context.dart';
import 'package:donuts/core/widgets/images/tier_backdrop.dart';
import 'package:donuts/features/home/presentation/blocs/home_cubit.dart';
import 'package:donuts/features/home/presentation/blocs/section_state.dart';
import 'package:donuts/features/home/presentation/home_dimens.dart';
import 'package:donuts/features/home/presentation/views/banner_carousel_view.dart';
import 'package:donuts/features/home/presentation/views/home_header_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';

/// The top of Home: the member header and the banners on the backdrop of
/// the member's tier. The panel's rounded bottom edge cuts the banners off,
/// and a thin white rim runs along it.
class MemberPanelView extends StatelessWidget {
  const new({super.key});

  static const BorderRadius _corners = BorderRadius.vertical(
    bottom: Radius.circular(HomeDimens.panelRadius),
  );

  @override
  Widget build(BuildContext context) {
    // The white box sits one rim lower than the panel, so it shows only
    // under the bottom edge and thins out up the curved corners.
    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.colors.surface,
        borderRadius: _corners,
      ),
      child: const Padding(
        padding: EdgeInsets.only(bottom: HomeDimens.panelRim),
        child: ClipRRect(
          borderRadius: _corners,
          child: Stack(
            children: [
              Positioned.fill(child: _TierBackdrop()),
              Column(
                children: [
                  StaggeredEntrance(index: 0, child: HomeHeaderView()),
                  StaggeredEntrance(index: 1, child: BannerCarouselView()),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// The backdrop of the member's current tier. The nav's blue shows while
/// the member loads.
class _TierBackdrop extends StatelessWidget {
  const new();

  @override
  Widget build(BuildContext context) {
    final tierId = context.select<HomeCubit, String?>(
      (c) => switch (c.state.member) {
        SectionReady(:final data) => data.tierProgress.current?.id,
        _ => null,
      },
    );
    return TierBackdrop(tierId: tierId, color: context.colors.primary);
  }
}
