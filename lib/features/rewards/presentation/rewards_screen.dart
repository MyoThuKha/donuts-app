import 'package:donuts/core/di/locator.dart';
import 'package:donuts/core/l10n/l10n.dart';
import 'package:donuts/core/motion/app_motion.dart';
import 'package:donuts/core/state/section_state.dart';
import 'package:donuts/core/sync/presentation/pull_to_refresh.dart';
import 'package:donuts/core/theme/app_dimens.dart';
import 'package:donuts/core/theme/theme_context.dart';
import 'package:donuts/core/widgets/feedback/donut_refresh_indicator.dart';
import 'package:donuts/core/widgets/feedback/section_empty_state.dart';
import 'package:donuts/core/widgets/feedback/section_error_state.dart';
import 'package:donuts/core/widgets/feedback/skeleton.dart';
import 'package:donuts/features/rewards/presentation/blocs/rewards_cubit.dart';
import 'package:donuts/features/rewards/presentation/blocs/rewards_state.dart';
import 'package:donuts/features/rewards/presentation/rewards_dimens.dart';
import 'package:donuts/features/rewards/presentation/rewards_motion.dart';
import 'package:donuts/features/rewards/presentation/views/challenge_list_view.dart';
import 'package:donuts/features/rewards/presentation/views/gift_list_view.dart';
import 'package:donuts/features/rewards/presentation/views/points_ring_view.dart';
import 'package:donuts/features/rewards/presentation/views/rewards_header_view.dart';
import 'package:donuts/features/rewards/presentation/views/rewards_tabs_view.dart';
import 'package:donuts/features/rewards/presentation/views/tier_ladder_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';

/// Clamping like Home: a pull shows the donut without dragging the page
/// down. Always scrollable, so a short list can still be pulled.
const ScrollPhysics _pullable = AlwaysScrollableScrollPhysics(
  parent: ClampingScrollPhysics(),
);

/// Rewards (screen 10): the tier ladder, the points ring and the
/// challenge and gift cards, all read from the local database.
class RewardsScreen extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<RewardsCubit>()..start(),
      child: const _RewardsPage(),
    );
  }
}

class _RewardsPage extends StatefulWidget {
  const new();

  @override
  State<_RewardsPage> createState() => _RewardsPageState();
}

class _RewardsPageState extends State<_RewardsPage>
    with TickerProviderStateMixin {
  /// Drives the ring, count, shields, ladder line and badge together.
  late final AnimationController _entrance = AnimationController(
    vsync: this,
    duration: RewardsMotion.entrance,
  );
  bool _entered = false;

  /// Drives the tab pills and the swipeable lists. The cubit's tab follows
  /// it, so a tap and a swipe both end up in the same state.
  late final TabController _tabs = TabController(
    length: RewardsTab.values.length,
    vsync: this,
  )..addListener(_onTabChanged);

  void _onTabChanged() {
    final tab = RewardsTab.values[_tabs.index];
    final cubit = context.read<RewardsCubit>();
    if (cubit.state.tab != tab) cubit.selectTab(tab);
  }

  void _selectTab(RewardsTab tab) => _tabs.animateTo(
    tab.index,
    duration: context.motion.of(AppMotion.medium),
    curve: AppMotion.standard,
  );

  /// Bumped on each replay. The card lists are keyed by it, so they mount
  /// again and their stagger, art fill and Earn pulse play once more.
  int _run = 0;

  /// Whether the Rewards tab is the one showing. The shell keeps this page
  /// alive in an indexed stack and wraps each tab in a [TickerMode], so the
  /// value flips to true each time the user comes back.
  bool _onScreen = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final onScreen = TickerMode.valuesOf(context).enabled;
    final cameBack = onScreen && !_onScreen;
    _onScreen = onScreen;
    if (cameBack && _entered) {
      _run++;
      _playEntrance();
    }
  }

  void _onMember(BuildContext context, RewardsState state) {
    if (state.member is! SectionReady || _entered) return;
    _entered = true;
    _playEntrance();
  }

  void _playEntrance() {
    if (context.motion.reduced) {
      _entrance.value = 1;
    } else {
      _entrance.forward(from: 0).ignore();
    }
  }

  @override
  void dispose() {
    _tabs.dispose();
    _entrance.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RewardsCubit, RewardsState>(
      listenWhen: (a, b) => a.member != b.member,
      listener: _onMember,
      builder: (context, state) => ColoredBox(
        color: context.colors.canvas,
        // The header and tabs scroll away together, and the lists below
        // them page sideways in a TabBarView.
        child: DonutRefreshIndicator(
          nested: true,
          edgeOffset: MediaQuery.paddingOf(context).top,
          onRefresh: () => _refresh(context),
          child: NestedScrollView(
            physics: _pullable,
            headerSliverBuilder: (context, _) => [
              SliverToBoxAdapter(child: _top(context, state)),
              SliverToBoxAdapter(
                child: RewardsTabsView(
                  controller: _tabs,
                  onSelected: _selectTab,
                ),
              ),
            ],
            body: _body(state),
          ),
        ),
      ),
    );
  }

  /// Undoes any Earn, so the points and challenges read as stored, and
  /// refreshes the catalog like Home's pull.
  Future<void> _refresh(BuildContext context) {
    context.read<RewardsCubit>().resetClaims();
    return refreshCatalogFromPull(context);
  }

  /// The white upper half: the header, then the ladder and ring. While the
  /// member loads they show their empty shells, from which the entrance
  /// sweeps.
  Widget _top(BuildContext context, RewardsState state) {
    final member = state.memberOrNull;
    return ColoredBox(
      color: context.colors.surface,
      child: Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.paddingOf(context).top + AppSpacing.l,
          bottom: AppSpacing.xxl,
        ),
        child: Column(
          spacing: AppSpacing.xxxl,
          children: [
            RewardsHeaderView(
              rewardsCount: member?.rewardsCount,
              badge: _entrance.drive(CurveTween(curve: RewardsMotion.badgePop)),
            ),
            switch (state.member) {
              SectionLoading() || SectionReady() => Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: AppSpacing.pageGutter,
                        right: AppSpacing.s,
                      ),
                      child: TierLadderView(
                        member: member,
                        entrance: _entrance,
                      ),
                    ),
                  ),
                  PointsRingView(member: member, entrance: _entrance),
                ],
              ),
              SectionEmpty() => SectionEmptyState(
                message: context.l10n.rewardsEmpty,
              ),
              SectionFailed() => SectionErrorState(
                message: context.l10n.rewardsError,
                onRetry: () =>
                    context.read<RewardsCubit>().retry(RewardsPart.member),
              ),
            },
          ],
        ),
      ),
    );
  }

  Widget _body(RewardsState state) => TabBarView(
    controller: _tabs,
    children: [
      for (final tab in RewardsTab.values)
        _TabList(
          // Keyed by the replay count, so coming back to the Rewards tab
          // mounts the cards again and their entrance replays.
          key: ValueKey((tab, _run)),
          state: state,
          tab: tab,
        ),
    ],
  );
}

/// One tab's cards in their own scroll view, so the TabBarView can page
/// between them. They enter staggered each time the page mounts.
class _TabList extends StatelessWidget {
  const new({required this.state, required this.tab, super.key});

  final RewardsState state;
  final RewardsTab tab;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: _pullable,
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
