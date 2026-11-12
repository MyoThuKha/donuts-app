import 'dart:async';

import 'package:donuts/core/di/locator.dart';
import 'package:donuts/core/l10n/l10n.dart';
import 'package:donuts/core/result/app_failure.dart';
import 'package:donuts/core/result/result.dart';
import 'package:donuts/core/theme/app_theme.dart';
import 'package:donuts/features/product/domain/usecases/add_to_cart_use_case.dart';
import 'package:donuts/features/product/domain/usecases/watch_product_use_case.dart';
import 'package:donuts/features/product/presentation/product_detail_screen.dart';
import 'package:donuts/features/product/presentation/views/add_to_cart_bar_view.dart';
import 'package:donuts/features/product/presentation/views/product_card_view.dart';
import 'package:donuts/features/product/presentation/widgets/quantity_stepper_widget.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mocktail/mocktail.dart';

import '../../../helpers/product_fakes.dart';

const _heroTag = 'product-image-seasonal-p_coconut';

void main() {
  late MockAddToCartUseCase addToCart;

  setUpAll(registerProductFallbacks);

  setUp(() {
    addToCart = MockAddToCartUseCase();
    when(() => addToCart(any()))
        .thenAnswer((_) async => const Success<void>(null));
    getIt
      ..registerSingleton<WatchProductUseCase>(FakeWatchProductUseCase())
      ..registerSingleton<AddToCartUseCase>(addToCart);
    registerProductFakes(getIt);
  });
  tearDown(getIt.reset);

  Future<void> pumpDetail(
    WidgetTester tester, {
    String productId = 'p_coconut',
    bool reduceMotion = false,
  }) async {
    // An iPhone 17 Pro screen, so the whole page fits.
    tester.view
      ..physicalSize = const Size(1206, 2622)
      ..devicePixelRatio = 3;
    addTearDown(tester.view.reset);
    // No outer Scaffold: on the device the product route is the root one,
    // and snackbars show on the root Scaffold.
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        theme: AppTheme.light(),
        home: Builder(
          builder: (context) => MediaQuery(
            data: MediaQuery.of(context)
                .copyWith(disableAnimations: reduceMotion),
            child: ProductDetailScreen(productId: productId, heroTag: _heroTag),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  Finder inStepper(String text) => find.descendant(
    of: find.byType(QuantityStepperWidget),
    matching: find.text(text),
  );

  Future<void> tapPlus(WidgetTester tester) =>
      tester.tap(find.bySemanticsLabel('Increase quantity'));

  testWidgets('shows the code, name, New badge and 3,200 MMK', (tester) async {
    await pumpDetail(tester);

    Finder inCard(String text) => find.descendant(
      of: find.byType(ProductCardView),
      matching: find.text(text),
    );
    expect(inCard('JD022123'), findsOneWidget);
    expect(inCard('Coconut Donut'), findsOneWidget);
    expect(inCard('New'), findsOneWidget);
    expect(inCard('3,200 MMK'), findsOneWidget);
    expect(find.text('Enjoy our scrumptious donuts.'), findsOneWidget);
  });

  testWidgets('the image sits in a Hero with the tag the route passed', (
    tester,
  ) async {
    await pumpDetail(tester);

    expect(tester.widget<Hero>(find.byType(Hero)).tag, _heroTag);
  });

  testWidgets('tapping plus twice shows 3 and a total of 9,600 MMK', (
    tester,
  ) async {
    await pumpDetail(tester);

    await tapPlus(tester);
    await tester.pumpAndSettle();
    await tapPlus(tester);
    await tester.pumpAndSettle();

    expect(inStepper('3'), findsOneWidget);
    expect(find.text('9,600 MMK'), findsOneWidget);
  });

  testWidgets('minus is disabled at 1', (tester) async {
    await pumpDetail(tester);

    expect(
      tester.getSemantics(find.bySemanticsLabel('Decrease quantity')),
      isSemantics(isButton: true, hasEnabledState: true, isEnabled: false),
    );
    await tester.tap(find.bySemanticsLabel('Decrease quantity'));
    await tester.pumpAndSettle();
    expect(inStepper('1'), findsOneWidget);
  });

  testWidgets('the quantity rolls up on increment and down on decrement', (
    tester,
  ) async {
    await pumpDetail(tester);
    const halfway = Duration(milliseconds: 75);

    Future<(double, double)> rollTo(
      String semantics,
      String from,
      String to,
    ) async {
      await tester.tap(find.bySemanticsLabel(semantics));
      await tester.pump();
      await tester.pump(halfway);
      final positions = (
        tester.getCenter(inStepper(from)).dy,
        tester.getCenter(inStepper(to)).dy,
      );
      await tester.pumpAndSettle();
      return positions;
    }

    final (oneUp, twoIn) = await rollTo('Increase quantity', '1', '2');
    expect(oneUp, lessThan(twoIn));
    final (twoUp, threeIn) = await rollTo('Increase quantity', '2', '3');
    expect(twoUp, lessThan(threeIn));
    final (threeDown, twoBack) = await rollTo('Decrease quantity', '3', '2');
    expect(threeDown, greaterThan(twoBack));
    final (twoDown, oneBack) = await rollTo('Decrease quantity', '2', '1');
    expect(twoDown, greaterThan(oneBack));
  });

  testWidgets('with reduce motion the quantity changes without animation', (
    tester,
  ) async {
    await pumpDetail(tester, reduceMotion: true);

    await tapPlus(tester);
    await tester.pump();

    expect(inStepper('2'), findsOneWidget);
    expect(inStepper('1'), findsNothing);
    expect(find.text('6,400 MMK'), findsOneWidget);
  });

  testWidgets('Add to cart shows the added snackbar', (tester) async {
    await pumpDetail(tester);
    await tapPlus(tester);
    await tester.pumpAndSettle();

    await tester.tap(find.text('ADD TO CART'));
    await tester.pumpAndSettle();

    expect(find.text('Added 2 Coconut Donut to your cart'), findsOneWidget);
  });

  testWidgets('the added snackbar leaves the Add to cart bar uncovered', (
    tester,
  ) async {
    await pumpDetail(tester);

    await tester.tap(find.text('ADD TO CART'));
    await tester.pumpAndSettle();

    final bar = tester.getRect(find.byType(AddToCartBarView));
    final snackBar = tester.getRect(find.byType(SnackBar));
    expect(bar.overlaps(snackBar), isFalse);
  });

  testWidgets('a failed add shows the failure snackbar', (tester) async {
    when(() => addToCart(any()))
        .thenAnswer((_) async => const Failure<void>(DatabaseFailure()));
    await pumpDetail(tester);

    await tester.tap(find.text('ADD TO CART'));
    await tester.pumpAndSettle();

    expect(find.text("Couldn't add to your cart. Try again."), findsOneWidget);
  });

  testWidgets('the image flies from the tile that opened the screen', (
    tester,
  ) async {
    const tileImage = Key('tile-image');
    final router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (_, _) => const Align(
            alignment: Alignment.topLeft,
            child: Hero(
              tag: _heroTag,
              child: SizedBox.square(key: tileImage, dimension: 50),
            ),
          ),
          routes: [
            GoRoute(
              path: 'product/:id',
              builder: (_, state) => ProductDetailScreen(
                productId: state.pathParameters['id']!,
                heroTag: _heroTag,
              ),
            ),
          ],
        ),
      ],
    );
    addTearDown(router.dispose);
    await tester.pumpWidget(
      MaterialApp.router(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        theme: AppTheme.light(),
        routerConfig: router,
      ),
    );

    unawaited(router.push('/product/p_coconut'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 50));

    // In flight, the tile keeps an offstage copy of its image as a
    // placeholder while the shuttle carries the visible one.
    expect(find.byKey(tileImage, skipOffstage: false), findsNWidgets(2));
    await tester.pumpAndSettle();
  });

  testWidgets('an unknown product shows the not-found message and back pops', (
    tester,
  ) async {
    final router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (_, _) => const Text('previous page'),
          routes: [
            GoRoute(
              path: 'product/:id',
              builder: (_, state) =>
                  ProductDetailScreen(productId: state.pathParameters['id']!),
            ),
          ],
        ),
      ],
    );
    addTearDown(router.dispose);
    await tester.pumpWidget(
      MaterialApp.router(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        theme: AppTheme.light(),
        routerConfig: router,
      ),
    );
    unawaited(router.push('/product/p_missing'));
    await tester.pumpAndSettle();

    expect(find.text("This product isn't available any more."), findsOneWidget);

    await tester.tap(find.bySemanticsLabel('Back'));
    await tester.pumpAndSettle();

    expect(find.text('previous page'), findsOneWidget);
  });
}
