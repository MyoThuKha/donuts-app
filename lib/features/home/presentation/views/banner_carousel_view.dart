import 'dart:async';

import 'package:donuts/core/l10n/l10n.dart';
import 'package:donuts/core/motion/app_motion.dart';
import 'package:donuts/core/theme/app_dimens.dart';
import 'package:donuts/core/theme/theme_context.dart';
import 'package:donuts/core/widgets/feedback/section_empty_state.dart';
import 'package:donuts/core/widgets/feedback/section_error_state.dart';
import 'package:donuts/core/widgets/feedback/skeleton.dart';
import 'package:donuts/features/home/domain/vo/banner_vo.dart';
import 'package:donuts/features/home/presentation/blocs/home_cubit.dart';
import 'package:donuts/features/home/presentation/blocs/home_state.dart';
import 'package:donuts/features/home/presentation/blocs/section_state.dart';
import 'package:donuts/features/home/presentation/home_dimens.dart';
import 'package:donuts/features/home/presentation/items/banner_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';

/// The banner carousel. Its top half sits on the header colour, so the
/// cards straddle the header's edge as in the design.
class BannerCarouselView extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final banners = context.select<HomeCubit, SectionState<List<BannerVO>>>(
      (c) => c.state.banners,
    );
    final l10n = context.l10n;
    return switch (banners) {
      SectionLoading() => const _Band(
        child: SkeletonGroup(child: _CardSlot(child: Skeleton())),
      ),
      SectionReady(:final data) => _Band(child: _Pager(banners: data)),
      SectionEmpty() => SectionEmptyState(message: l10n.homeSectionEmpty),
      SectionFailed() => SectionErrorState(
        message: l10n.homeSectionError,
        onRetry: () => context.read<HomeCubit>().retry(HomeSectionId.banners),
      ),
    };
  }
}

/// The two-tone strip behind the cards.
class _Band extends StatelessWidget {
  const new({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [colors.memberHeader, colors.memberHeader, colors.canvas],
          stops: const [0, 0.5, 0.5],
        ),
      ),
      child: SizedBox(height: HomeDimens.bannerHeight, child: child),
    );
  }
}

/// Places one card where the carousel's first page sits.
class _CardSlot extends StatelessWidget {
  const new({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) => FractionallySizedBox(
    alignment: Alignment.centerLeft,
    widthFactor: HomeDimens.bannerViewportFraction,
    child: Padding(
      padding: const EdgeInsets.only(left: AppSpacing.pageGutter),
      child: child,
    ),
  );
}

/// Pages through the banners, moving on every
/// [HomeDimens.carouselInterval]. A finger on the carousel pauses it until
/// one interval after release, and Reduce Motion turns it off.
class _Pager extends StatefulWidget {
  const new({required this.banners});

  final List<BannerVO> banners;

  @override
  State<_Pager> createState() => _PagerState();
}

class _PagerState extends State<_Pager> {
  final PageController _controller = PageController(
    viewportFraction: HomeDimens.bannerViewportFraction,
  );
  Timer? _timer;
  bool _held = false;
  bool _reduced = false;
  int _page = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _reduced = context.motion.reduced;
    _schedule();
  }

  @override
  void didUpdateWidget(_Pager oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.banners.length != widget.banners.length) _schedule();
  }

  void _schedule() {
    _timer?.cancel();
    if (_reduced || _held || widget.banners.length < 2) return;
    _timer = Timer(HomeDimens.carouselInterval, _advance);
  }

  void _advance() {
    if (!mounted || !_controller.hasClients) return;
    _controller.animateToPage(
      (_page + 1) % widget.banners.length,
      duration: AppMotion.slow,
      curve: AppMotion.emphasized,
    );
    _schedule();
  }

  void _hold(bool held) {
    _held = held;
    _schedule();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (_) => _hold(true),
      onPointerUp: (_) => _hold(false),
      onPointerCancel: (_) => _hold(false),
      child: PageView.builder(
        controller: _controller,
        padEnds: false,
        itemCount: widget.banners.length,
        onPageChanged: (page) => _page = page,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.only(left: AppSpacing.pageGutter),
          child: BannerItem(banner: widget.banners[index]),
        ),
      ),
    );
  }
}
