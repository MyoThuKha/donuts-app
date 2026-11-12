import 'package:donuts/core/di/locator.dart';
import 'package:donuts/core/l10n/l10n.dart';
import 'package:donuts/core/router/app_routes.dart';
import 'package:donuts/core/theme/app_dimens.dart';
import 'package:donuts/core/theme/theme_context.dart';
import 'package:donuts/core/widgets/buttons/back_button.dart';
import 'package:donuts/core/widgets/images/product_hero_tag.dart';
import 'package:donuts/features/product/domain/product_rules.dart';
import 'package:donuts/features/product/presentation/blocs/product_detail_cubit.dart';
import 'package:donuts/features/product/presentation/blocs/product_detail_state.dart';
import 'package:donuts/features/product/presentation/product_dimens.dart';
import 'package:donuts/features/product/presentation/views/add_to_cart_bar_view.dart';
import 'package:donuts/features/product/presentation/views/product_card_view.dart';
import 'package:donuts/features/product/presentation/views/product_description_view.dart';
import 'package:donuts/features/product/presentation/widgets/quantity_stepper_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

/// Product detail (screen 9).
class ProductDetailScreen extends StatelessWidget {
  const new({required this.productId, this.heroTag, super.key});

  final String productId;

  /// The Hero tag of the tile that opened this screen. Null means the
  /// plain `productHeroTag(productId)`.
  final Object? heroTag;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ProductDetailCubit>(param1: productId)..start(),
      child: _ProductDetailPage(heroTag: heroTag ?? productHeroTag(productId)),
    );
  }
}

class _ProductDetailPage extends StatelessWidget {
  const new({required this.heroTag});

  final Object heroTag;

  /// A deep link opened on its own has nothing to pop, so it goes Home.
  void _back(BuildContext context) =>
      context.canPop() ? context.pop() : context.go(AppRoutes.home);

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProductDetailCubit, ProductDetailState>(
      listenWhen: (previous, current) =>
          previous.addStatus != current.addStatus,
      listener: _showAddResult,
      child: Scaffold(
        backgroundColor: context.colors.canvas,
        // In the bottom bar slot, so the add snackbar shows above it.
        bottomNavigationBar: const _AddToCartBar(),
        body: SafeArea(
          bottom: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.l),
                child: AppBackButton(onPressed: () => _back(context)),
              ),
              Expanded(
                child: BlocBuilder<ProductDetailCubit, ProductDetailState>(
                  buildWhen: (previous, current) =>
                      previous.status != current.status,
                  // Loading and ready share one body, so the Hero built while
                  // loading is the one the product fills in.
                  builder: (context, state) => switch (state.status) {
                    ProductLoadStatus.notFound => const _NotFound(),
                    ProductLoadStatus.loading ||
                    ProductLoadStatus.ready => _ProductBody(heroTag: heroTag),
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showAddResult(BuildContext context, ProductDetailState state) {
    final l10n = context.l10n;
    final message = switch (state.addStatus) {
      CartAddStatus.added => l10n.productAddedToCart(
        state.addedQuantity,
        state.product?.name ?? '',
      ),
      CartAddStatus.failed => l10n.productAddFailed,
      CartAddStatus.idle || CartAddStatus.adding => null,
    };
    if (message == null) return;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }
}

class _ProductBody extends StatelessWidget {
  const new({required this.heroTag});

  final Object heroTag;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ProductDetailCubit>();
    final state = context.watch<ProductDetailCubit>().state;
    final product = state.product;
    final ready = product != null;
    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.all(AppSpacing.pageGutter),
          sliver: SliverList.list(
            children: [
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: ProductDimens.stepperHeight / 2,
                    ),
                    child: ProductCardView(product: product, heroTag: heroTag),
                  ),
                  QuantityStepperWidget(
                    quantity: state.quantity,
                    onDecrement:
                        ready && state.quantity > ProductRules.minQuantity
                        ? cubit.decrement
                        : null,
                    onIncrement:
                        ready && state.quantity < ProductRules.maxQuantity
                        ? cubit.increment
                        : null,
                  ),
                ],
              ),
              if (product != null)
                Padding(
                  padding: const EdgeInsets.only(top: AppSpacing.xxxl),
                  child: ProductDescriptionView(
                    description: product.description,
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Shown only once the product has loaded.
class _AddToCartBar extends StatelessWidget {
  const new();

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ProductDetailCubit>().state;
    final total = state.total;
    if (state.status != ProductLoadStatus.ready || total == null) {
      return const SizedBox.shrink();
    }
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.pageGutter,
          AppSpacing.s,
          AppSpacing.pageGutter,
          AppSpacing.l,
        ),
        child: AddToCartBarView(
          total: total,
          adding: state.addStatus == CartAddStatus.adding,
          onPressed: context.read<ProductDetailCubit>().addToCart,
        ),
      ),
    );
  }
}

class _NotFound extends StatelessWidget {
  const new();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.pageGutter),
        child: Text(
          context.l10n.productNotFound,
          style: context.text.body.copyWith(color: context.colors.inkMuted),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
