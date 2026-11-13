import 'package:donuts/core/format/number_format.dart';
import 'package:donuts/core/l10n/l10n.dart';
import 'package:donuts/core/theme/app_dimens.dart';
import 'package:donuts/core/theme/theme_context.dart';
import 'package:donuts/core/widgets/badges/app_tag.dart';
import 'package:donuts/core/widgets/feedback/section_error_state.dart';
import 'package:donuts/core/widgets/feedback/skeleton.dart';
import 'package:donuts/core/widgets/images/profile_avatar.dart';
import 'package:donuts/features/auth/presentation/session/blocs/session_cubit.dart';
import 'package:donuts/features/auth/presentation/session/blocs/session_state.dart';
import 'package:donuts/features/auth/presentation/session/user_initials.dart';
import 'package:donuts/features/home/presentation/blocs/home_cubit.dart';
import 'package:donuts/features/home/presentation/blocs/home_state.dart';
import 'package:donuts/features/home/presentation/blocs/section_state.dart';
import 'package:donuts/features/home/presentation/home_dimens.dart';
import 'package:donuts/features/home/presentation/widgets/notification_bell_widget.dart';
import 'package:donuts/features/rewards/domain/vo/member_summary.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';

/// The member header: photo, the signed-in user's first name, tier, points
/// to the next tier and the notification bell.
class HomeHeaderView extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final member = context.select<HomeCubit, SectionState<MemberSummary>>(
      (c) => c.state.member,
    );
    final summary = switch (member) {
      SectionReady(:final data) => data,
      _ => null,
    };
    return Padding(
      // No right padding: the bell tag runs off the right edge. Everything
      // under it keeps the gutter.
      padding: EdgeInsets.fromLTRB(
        AppSpacing.pageGutter,
        MediaQuery.paddingOf(context).top + AppSpacing.l,
        0,
        AppSpacing.l,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: AppSpacing.m,
        children: [
          _identityRow(context, member, summary),
          for (final item in _standing(context, member, summary))
            Padding(
              padding: const EdgeInsets.only(right: AppSpacing.pageGutter),
              child: item,
            ),
        ],
      ),
    );
  }

  Widget _identityRow(
    BuildContext context,
    SectionState<MemberSummary> member,
    MemberSummary? summary,
  ) => Row(
    spacing: AppSpacing.m,
    children: [
      _Avatar(member: member, summary: summary),
      Expanded(
        child: _NameAndTier(member: member, summary: summary),
      ),
      NotificationBellWidget(count: summary?.notificationCount),
    ],
  );

  List<Widget> _standing(
    BuildContext context,
    SectionState<MemberSummary> member,
    MemberSummary? summary,
  ) => switch (member) {
    SectionLoading() => const [
      SkeletonGroup(
        child: Skeleton(
          width: HomeDimens.skeletonTitleWidth * 2,
          height: HomeDimens.chipHeight,
        ),
      ),
    ],
    SectionFailed() => [
      SectionErrorState(
        message: context.l10n.homeSectionError,
        onRetry: () => context.read<HomeCubit>().retry(HomeSectionId.member),
      ),
    ],
    SectionEmpty() => const [],
    SectionReady() => [_PointsChip(summary: summary!)],
  };
}

class _Avatar extends StatelessWidget {
  const new({required this.member, required this.summary});

  final SectionState<MemberSummary> member;
  final MemberSummary? summary;

  @override
  Widget build(BuildContext context) {
    final initials = context.select<SessionCubit, String>(
      (c) => switch (c.state) {
        SessionSignedIn(:final user) => user.initials,
        SessionSignedOut() => '',
      },
    );
    if (member is SectionLoading) {
      return const SkeletonGroup(
        child: Skeleton(
          width: HomeDimens.avatar,
          height: HomeDimens.avatar,
          radius: BorderRadius.all(Radius.circular(HomeDimens.avatar)),
        ),
      );
    }
    return ProfileAvatar(
      imageUrl: summary?.avatarUrl,
      asset: summary?.avatarAsset,
      size: HomeDimens.avatar,
      initials: initials,
    );
  }
}

class _NameAndTier extends StatelessWidget {
  const new({required this.member, required this.summary});

  final SectionState<MemberSummary> member;
  final MemberSummary? summary;

  @override
  Widget build(BuildContext context) {
    final firstName = context.select<SessionCubit, String>(
      (c) => switch (c.state) {
        SessionSignedIn(:final user) => user.firstName,
        SessionSignedOut() => '',
      },
    );
    final tier = summary?.tierProgress.current;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppSpacing.xs,
      children: [
        Text(
          firstName,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: context.text.display,
        ),
        if (member is SectionLoading)
          const SkeletonGroup(
            child: Skeleton(
              width: HomeDimens.skeletonTitleWidth,
              height: HomeDimens.skeletonLine,
            ),
          ),
        if (tier != null)
          Text(
            context.l10n.homeMemberTier(tier.name),
            style: context.text.body,
          ),
      ],
    );
  }
}

class _PointsChip extends StatelessWidget {
  const new({required this.summary});

  final MemberSummary summary;

  @override
  Widget build(BuildContext context) {
    final progress = summary.tierProgress;
    final next = progress.next;
    final pointsToNext = progress.pointsToNext;
    final l10n = context.l10n;
    final label = next == null || pointsToNext == null
        ? l10n.homeTopTier
        : l10n.homePointsToNextTier(formatGrouped(pointsToNext), next.name);
    return AppTag.plain(label: label);
  }
}
