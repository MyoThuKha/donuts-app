import 'package:donuts/core/di/locator.dart';
import 'package:donuts/core/l10n/l10n.dart';
import 'package:donuts/core/router/app_routes.dart';
import 'package:donuts/core/state/section_state.dart';
import 'package:donuts/core/theme/app_dimens.dart';
import 'package:donuts/core/theme/theme_context.dart';
import 'package:donuts/core/widgets/buttons/back_button.dart';
import 'package:donuts/core/widgets/buttons/primary_button.dart';
import 'package:donuts/core/widgets/feedback/app_snack_bar.dart';
import 'package:donuts/core/widgets/feedback/page_state_view.dart';
import 'package:donuts/core/widgets/feedback/skeleton.dart';
import 'package:donuts/features/cart/domain/vo/cart_vo.dart';
import 'package:donuts/features/cart/presentation/blocs/cart_cubit.dart';
import 'package:donuts/features/cart/presentation/blocs/cart_state.dart';
import 'package:donuts/features/cart/presentation/cart_dimens.dart';
import 'package:donuts/features/cart/presentation/items/cart_item_tile.dart';
import 'package:donuts/features/cart/presentation/views/checkout_bar_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:material_ui/material_ui.dart';

/// The cart: each item with a stepper, newest change first, and Checkout
/// with the total. Every change is written to the local database, and the
/// list follows it.
class CartScreen extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => getIt<CartCubit>()..start(),
    child: const _CartPage(),
  );
}

class _CartPage extends StatelessWidget {
  const new();

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<CartCubit, CartState>(
          listenWhen: (previous, current) =>
              current.lastRemoved != null &&
              !identical(previous.lastRemoved, current.lastRemoved),
          listener: _showRemoved,
        ),
        BlocListener<CartCubit, CartState>(
          listenWhen: (previous, current) =>
              current.failedWrites > previous.failedWrites,
          listener: (context, _) => context.showMessage(
            context.l10n.cartChangeFailed,
            tone: AppSnackBarTone.error,
          ),
        ),
      ],
      child: Scaffold(
        backgroundColor: context.colors.canvas,
        // In the bottom bar slot, so snackbars show above it.
        bottomNavigationBar: const _CheckoutBar(),
        body: CustomScrollView(
          slivers: [
            const _Header(),
            BlocBuilder<CartCubit, CartState>(
              buildWhen: (previous, current) => previous.cart != current.cart,
              builder: (context, state) => _body(state.cart),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _body(SectionState<CartVO> cart) => switch (cart) {
    SectionReady(:final data) => _Items(cart: data),
    SectionLoading() => const _Skeleton(),
    // The page states lay out with a LayoutBuilder, which can't report the
    // intrinsic height hasScrollBody: false needs.
    SectionEmpty() => const SliverFillRemaining(child: _Empty()),
    SectionFailed() => const SliverFillRemaining(child: _Failed()),
  };

  void _showRemoved(BuildContext context, CartState state) {
    final removed = state.lastRemoved;
    if (removed == null) return;
    final l10n = context.l10n;
    final cubit = context.read<CartCubit>();
    context.showMessage(
      l10n.cartRemoved(removed.name),
      action: AppSnackBarAction(
        label: l10n.cartUndo,
        onPressed: cubit.undoRemove,
      ),
    );
  }
}

/// The back button, then the title. It runs under the status bar and pads
/// itself below it.
class _Header extends StatelessWidget {
  const new();

  /// A cart opened on its own has nothing to pop, so it goes to Settings.
  void _back(BuildContext context) =>
      context.canPop() ? context.pop() : context.go(AppRoutes.settings);

  @override
  Widget build(BuildContext context) => SliverPadding(
    padding: EdgeInsets.fromLTRB(
      AppSpacing.l,
      MediaQuery.paddingOf(context).top,
      AppSpacing.pageGutter,
      AppSpacing.xl,
    ),
    sliver: SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: AppSpacing.l,
        children: [
          AppBackButton(onPressed: () => _back(context)),
          Padding(
            padding: const EdgeInsets.only(
              left: AppSpacing.pageGutter - AppSpacing.l,
            ),
            child: Text(context.l10n.cartTitle, style: context.text.display),
          ),
        ],
      ),
    ),
  );
}

class _Items extends StatelessWidget {
  const new({required this.cart});

  final CartVO cart;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CartCubit>();
    return SliverPadding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.pageGutter,
        0,
        AppSpacing.pageGutter,
        AppSpacing.xl,
      ),
      sliver: SliverList.separated(
        itemCount: cart.items.length,
        separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.l),
        itemBuilder: (context, index) {
          final item = cart.items[index];
          return CartItemTile(
            key: ValueKey('cart-item-${item.productId}'),
            item: item,
            onIncrement: () => cubit.increment(item.productId),
            onDecrement: () => cubit.decrement(item.productId),
          );
        },
      ),
    );
  }
}

/// Placeholder tiles while the cart loads.
class _Skeleton extends StatelessWidget {
  const new();

  @override
  Widget build(BuildContext context) => SliverPadding(
    padding: const EdgeInsets.symmetric(horizontal: AppSpacing.pageGutter),
    sliver: SliverToBoxAdapter(
      child: SkeletonGroup(
        child: Column(
          // Stretch: a skeleton without a width takes its width from here.
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: AppSpacing.l,
          children: [
            for (var i = 0; i < CartDimens.skeletonTiles; i++)
              const Skeleton(
                height: CartDimens.skeletonTileHeight,
                radius: BorderRadius.all(Radius.circular(AppRadii.card)),
              ),
          ],
        ),
      ),
    ),
  );
}

class _Empty extends StatelessWidget {
  const new();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return PageStateView(
      icon: LucideIcons.shoppingCart,
      iconColor: context.colors.primary,
      title: l10n.cartEmptyTitle,
      message: l10n.cartEmptyMessage,
      action: AppPrimaryButton(
        label: l10n.cartBrowse,
        onPressed: () => context.go(AppRoutes.home),
      ),
    );
  }
}

class _Failed extends StatelessWidget {
  const new();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return PageStateView(
      icon: LucideIcons.cloudAlert,
      iconColor: context.colors.danger,
      title: l10n.cartErrorTitle,
      message: l10n.cartErrorMessage,
      action: AppPrimaryButton(
        label: l10n.cartRetry,
        onPressed: context.read<CartCubit>().retry,
      ),
    );
  }
}

/// Shown only while the cart has items.
class _CheckoutBar extends StatelessWidget {
  const new();

  @override
  Widget build(BuildContext context) {
    final cart = context.select<CartCubit, SectionState<CartVO>>(
      (cubit) => cubit.state.cart,
    );
    return switch (cart) {
      SectionReady(:final data) => CheckoutBarView(totalMmk: data.totalMmk),
      _ => const SizedBox.shrink(),
    };
  }
}
