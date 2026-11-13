import 'package:donuts/core/l10n/l10n.dart';
import 'package:donuts/core/motion/stagger.dart';
import 'package:donuts/core/state/section_state.dart';
import 'package:donuts/core/theme/app_dimens.dart';
import 'package:donuts/core/widgets/feedback/section_empty_state.dart';
import 'package:donuts/core/widgets/feedback/section_error_state.dart';
import 'package:donuts/core/widgets/feedback/skeleton.dart';
import 'package:donuts/features/home/domain/vo/home_section_vo.dart';
import 'package:donuts/features/home/presentation/blocs/home_cubit.dart';
import 'package:donuts/features/home/presentation/blocs/home_state.dart';
import 'package:donuts/features/home/presentation/home_dimens.dart';
import 'package:donuts/features/home/presentation/views/product_section_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';

/// The product rows as slivers, entering one after another from
/// [firstIndex] on.
class ProductSectionsView extends StatelessWidget {
  const new({required this.firstIndex, super.key});

  final int firstIndex;

  @override
  Widget build(BuildContext context) {
    final sections = context
        .select<HomeCubit, SectionState<List<HomeSectionVO>>>(
          (c) => c.state.sections,
        );
    final l10n = context.l10n;
    return switch (sections) {
      // One box, not a lazy list: a lazy list disposes a row that scrolls
      // away and replays its entrance when it comes back.
      SectionReady(:final data) => SliverToBoxAdapter(
        child: Column(
          children: [
            for (final (i, section) in data.indexed)
              StaggeredEntrance(
                index: firstIndex + i,
                child: ProductSectionView(section: section),
              ),
          ],
        ),
      ),
      SectionLoading() => _box(firstIndex, const _SectionsSkeleton()),
      SectionEmpty() => _box(
        firstIndex,
        SectionEmptyState(message: l10n.homeSectionEmpty),
      ),
      SectionFailed() => _box(
        firstIndex,
        SectionErrorState(
          message: l10n.homeSectionError,
          onRetry: () =>
              context.read<HomeCubit>().retry(HomeSectionId.sections),
        ),
      ),
    };
  }

  static Widget _box(int index, Widget child) => SliverToBoxAdapter(
    child: StaggeredEntrance(index: index, child: child),
  );
}

/// Two rows of placeholder title and tiles, while the rows themselves
/// load.
class _SectionsSkeleton extends StatelessWidget {
  const new();

  @override
  Widget build(BuildContext context) {
    const row = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppSpacing.m,
      children: [
        Padding(
          padding: EdgeInsets.only(left: AppSpacing.pageGutter),
          child: Skeleton(
            width: HomeDimens.skeletonTitleWidth,
            height: HomeDimens.skeletonLine,
          ),
        ),
        ProductTilesSkeleton(kind: HomeSectionKind.orderAgain),
      ],
    );
    return const SkeletonGroup(
      child: Padding(
        padding: EdgeInsets.only(top: AppSpacing.xxl),
        child: Column(spacing: AppSpacing.xxl, children: [row, row]),
      ),
    );
  }
}
