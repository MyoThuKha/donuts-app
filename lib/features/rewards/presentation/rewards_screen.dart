import 'package:donuts/core/di/locator.dart';
import 'package:donuts/core/l10n/l10n.dart';
import 'package:donuts/core/motion/app_motion.dart';
import 'package:donuts/core/theme/app_dimens.dart';
import 'package:donuts/core/theme/theme_context.dart';
import 'package:donuts/core/widgets/buttons/primary_button.dart';
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

/// Rewards (screen 10): the tier ladder, the points ring and the
/// challenge and gift cards, all read from the local database.
class RewardsScreen extends StatelessWidget {
  const new({super.key});

  /// The white strip behind the status bar that scrolled content passes
  /// under.
  static const Key statusBarKey = ValueKey('rewards-status-bar');

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
    with SingleTickerProviderStateMixin {
  /// Drives the ring, count, shields, ladder line and badge together.
  late final AnimationController _entrance = AnimationController(
    vsync: this,
    duration: RewardsMotion.entrance,
  );
  bool _entered = false;

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
    if (cameBack && _entered) _playEntrance();
  }

  void _onStatus(BuildContext context, RewardsState state) {
    if (state.status != RewardsStatus.ready || _entered) return;
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
    _entrance.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RewardsCubit, RewardsState>(
      listenWhen: (a, b) => a.status != b.status,
      listener: _onStatus,
      builder: (context, state) => Stack(
        children: [
          ColoredBox(
            color: context.colors.canvas,
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(child: _top(context, state)),
                ..._body(context, state),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height:
                        MediaQuery.paddingOf(context).bottom + AppSpacing.xl,
                  ),
                ),
              ],
            ),
          ),
          _statusBarStrip(context),
        ],
      ),
    );
  }

  Widget _statusBarStrip(BuildContext context) => Positioned(
    top: 0,
    left: 0,
    right: 0,
    height: MediaQuery.paddingOf(context).top,
    child: ColoredBox(
      key: RewardsScreen.statusBarKey,
      color: context.colors.surface,
      child: const SizedBox.expand(),
    ),
  );

  /// The white upper half: the header, then the ladder and ring.
  Widget _top(BuildContext context, RewardsState state) {
    final member = state.member;
    final showsData =
        state.status == RewardsStatus.ready ||
        state.status == RewardsStatus.loading;
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
            if (showsData)
              Row(
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
          ],
        ),
      ),
    );
  }

  List<Widget> _body(BuildContext context, RewardsState state) {
    final l10n = context.l10n;
    return switch (state.status) {
      RewardsStatus.loading => const [],
      RewardsStatus.empty => [_message(context, l10n.rewardsEmpty)],
      RewardsStatus.failed => [
        _message(
          context,
          l10n.rewardsError,
          retry: context.read<RewardsCubit>().retry,
        ),
      ],
      RewardsStatus.ready => [
        SliverToBoxAdapter(
          child: RewardsTabsView(
            tab: state.tab,
            onSelected: context.read<RewardsCubit>().selectTab,
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.pageGutter,
            AppSpacing.xl,
            AppSpacing.pageGutter,
            0,
          ),
          sliver: SliverToBoxAdapter(child: _CardLists(state: state)),
        ),
      ],
    };
  }

  Widget _message(BuildContext context, String text, {VoidCallback? retry}) {
    return SliverPadding(
      padding: const EdgeInsets.all(AppSpacing.pageGutter),
      sliver: SliverToBoxAdapter(
        child: Column(
          spacing: AppSpacing.l,
          children: [
            Text(text, style: context.text.body, textAlign: TextAlign.center),
            if (retry != null)
              AppPrimaryButton(
                label: context.l10n.rewardsRetry,
                onPressed: retry,
              ),
          ],
        ),
      ),
    );
  }
}

/// Switches between the challenge and gift cards, sliding the new list in
/// from the side of the tab that was picked.
class _CardLists extends StatelessWidget {
  const new({required this.state});

  final RewardsState state;

  @override
  Widget build(BuildContext context) {
    final current = ValueKey(state.tab);
    final towardsGifts = state.tab == RewardsTab.gifts;
    return AnimatedSwitcher(
      duration: context.motion.of(RewardsMotion.tabSwitch),
      switchInCurve: AppMotion.standard,
      switchOutCurve: AppMotion.standard,
      layoutBuilder: (child, previous) => Stack(
        alignment: Alignment.topCenter,
        children: [...previous, ?child],
      ),
      transitionBuilder: (child, animation) {
        final incoming = child.key == current;
        final side = incoming == towardsGifts ? 1.0 : -1.0;
        return FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: animation.drive(
              Tween(
                begin: Offset(side * RewardsDimens.tabSlide, 0),
                end: Offset.zero,
              ),
            ),
            child: child,
          ),
        );
      },
      child: KeyedSubtree(key: current, child: _list()),
    );
  }

  Widget _list() => switch (state.tab) {
    RewardsTab.challenges => ChallengeListView(challenges: state.challenges),
    RewardsTab.gifts => GiftListView(
      gifts: state.gifts,
      totalPoints: state.member?.totalPoints ?? 0,
    ),
  };
}
