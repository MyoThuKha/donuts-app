import 'package:donuts/core/l10n/l10n.dart';
import 'package:donuts/core/state/section_state.dart';
import 'package:donuts/core/theme/app_dimens.dart';
import 'package:donuts/core/widgets/feedback/section_empty_state.dart';
import 'package:donuts/core/widgets/feedback/section_error_state.dart';
import 'package:donuts/core/widgets/feedback/skeleton.dart';
import 'package:donuts/features/rewards/presentation/blocs/rewards_cubit.dart';
import 'package:donuts/features/rewards/presentation/blocs/rewards_state.dart';
import 'package:donuts/features/rewards/presentation/rewards_dimens.dart';
import 'package:donuts/features/rewards/presentation/views/challenge_list_view.dart';
import 'package:donuts/features/rewards/presentation/views/gift_list_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';

/// Clamping like Home: a pull shows the donut without dragging the page
/// down. Always scrollable, so a short list can still be pulled.
const ScrollPhysics rewardsPullPhysics = AlwaysScrollableScrollPhysics(
  parent: ClampingScrollPhysics(),
);

/// One tab's cards in their own scroll view, so the TabBarView can page
/// between them. They enter staggered each time the page mounts.
class RewardsTabListView extends StatelessWidget {
  const new({required this.state, required this.tab, super.key});

  final RewardsState state;
  final RewardsTab tab;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: rewardsPullPhysics,
      slivers: [
        SliverPadding(
          padding: EdgeInsets.only(
            top: AppSpacing.xl,
            bottom: MediaQuery.paddingOf(context).bottom + AppSpacing.xl,
          ),
          sliver: SliverToBoxAdapter(child: _content(context)),
        ),
      ],
    );
  }

  Widget _content(BuildContext context) => switch (tab) {
    RewardsTab.challenges => _section(
      context,
      state.challenges,
      RewardsPart.challenges,
      (challenges) => ChallengeListView(
        challenges: challenges,
        onEarnPressed: context.read<RewardsCubit>().earn,
      ),
    ),
    RewardsTab.gifts => _section(
      context,
      state.gifts,
      RewardsPart.gifts,
      (gifts) => GiftListView(gifts: gifts),
    ),
  };

  /// The cards once [section] is ready, else its skeleton, empty or error
  /// state. The empty and error states pad themselves to the gutter.
  Widget _section<T>(
    BuildContext context,
    SectionState<T> section,
    RewardsPart part,
    Widget Function(T data) cards,
  ) {
    final l10n = context.l10n;
    return switch (section) {
      SectionReady(:final data) => _gutter(cards(data)),
      SectionLoading() => _gutter(const _CardsSkeleton()),
      SectionEmpty() => SectionEmptyState(message: l10n.rewardsEmpty),
      SectionFailed() => SectionErrorState(
        message: l10n.rewardsError,
        onRetry: () => context.read<RewardsCubit>().retry(part),
      ),
    };
  }

  static Widget _gutter(Widget child) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: AppSpacing.pageGutter),
    child: child,
  );
}

/// Placeholder cards while a list loads.
class _CardsSkeleton extends StatelessWidget {
  const new();

  @override
  Widget build(BuildContext context) => SkeletonGroup(
    child: Column(
      // Stretch: a skeleton without a width takes its width from here.
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: AppSpacing.l,
      children: [
        for (var i = 0; i < RewardsDimens.skeletonCards; i++)
          const Skeleton(
            height: RewardsDimens.skeletonCardHeight,
            radius: BorderRadius.all(Radius.circular(AppRadii.card)),
          ),
      ],
    ),
  );
}
