import 'dart:async';

import 'package:donuts/core/di/locator.dart';
import 'package:donuts/core/router/app_routes.dart';
import 'package:donuts/core/widgets/feedback/skeleton.dart';
import 'package:donuts/features/cart/domain/repositories/cart_repository.dart';
import 'package:donuts/features/cart/domain/usecases/remove_from_cart_use_case.dart';
import 'package:donuts/features/cart/domain/usecases/set_cart_quantity_use_case.dart';
import 'package:donuts/features/cart/domain/vo/cart_vo.dart';
import 'package:donuts/features/cart/presentation/blocs/cart_cubit.dart';
import 'package:donuts/features/cart/presentation/cart_screen.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mocktail/mocktail.dart';

import '../../../helpers/cart_fakes.dart';
import '../../../helpers/fakes.dart';
import '../../../helpers/pump_app.dart';

void main() {
  late FakeCartRepository repository;

  setUp(() {
    repository = FakeCartRepository();
    getIt.registerSingleton<CartRepository>(repository);
  });
  tearDown(getIt.reset);

  Future<void> pumpCart(WidgetTester tester) async {
    await pumpRouterApp(
      tester,
      session: testSessionCubit()..signedIn(testUser),
      initialLocation: AppRoutes.cart,
    );
    await tester.pumpAndSettle();
  }

  Finder tileOf(String productId) =>
      find.byKey(ValueKey('cart-item-$productId'));

  testWidgets('loading shows skeleton tiles', (tester) async {
    final watch = MockWatchCartUseCase();
    when(watch.call).thenAnswer((_) => StreamController<CartVO>().stream);
    getIt.registerFactory(
      () => CartCubit(
        watchCart: watch,
        setQuantity: SetCartQuantityUseCase(repository),
        remove: RemoveFromCartUseCase(repository),
      ),
    );

    await pumpThemed(tester, const CartScreen());
    await tester.pump();

    expect(find.byType(Skeleton), findsWidgets);
    expect(find.text('Total'), findsNothing);
  });

  testWidgets('an empty cart says so and shows no total', (tester) async {
    await pumpCart(tester);

    expect(find.text('Your cart is empty'), findsOneWidget);
    expect(find.text('Total'), findsNothing);
  });

  testWidgets('a failed read offers Try again, which loads the cart', (
    tester,
  ) async {
    repository
      ..seed({'p_coconut': 2})
      ..failWatch = true;
    await pumpCart(tester);
    expect(find.text("Couldn't load your cart"), findsOneWidget);

    repository.failWatch = false;
    await tester.tap(find.text('TRY AGAIN'));
    await tester.pumpAndSettle();

    expect(find.text('Coconut Donut'), findsOneWidget);
  });

  testWidgets('lists items newest first with the total in the bar', (
    tester,
  ) async {
    repository.seed({'p_berry': 1, 'p_coconut': 2});
    await pumpCart(tester);

    final coconut = tester.getTopLeft(find.text('Coconut Donut')).dy;
    final berry = tester.getTopLeft(find.text('Strawberry Donut')).dy;
    expect(coconut, lessThan(berry));
    expect(find.text('Total'), findsOneWidget);
    expect(find.text('8,900 MMK'), findsOneWidget);
  });

  testWidgets('plus writes the next quantity and the total follows', (
    tester,
  ) async {
    repository.seed({'p_coconut': 2});
    await pumpCart(tester);

    await tester.tap(
      find.descendant(
        of: tileOf('p_coconut'),
        matching: find.byIcon(LucideIcons.plus),
      ),
    );
    await tester.pumpAndSettle();

    expect(repository.cart.items.single.quantity, 3);
    expect(find.text('9,600 MMK'), findsNWidgets(2), reason: 'line and bar');
  });

  testWidgets('trash removes the item', (tester) async {
    repository.seed({'p_berry': 1, 'p_coconut': 2});
    await pumpCart(tester);

    await tester.tap(find.byIcon(LucideIcons.trash2));
    await tester.pumpAndSettle();

    expect(find.text('Strawberry Donut'), findsNothing);
    expect(repository.cart.totalQuantity, 2);
  });

  testWidgets('removing the last item shows the empty state', (tester) async {
    repository.seed({'p_berry': 1});
    await pumpCart(tester);

    await tester.tap(find.byIcon(LucideIcons.trash2));
    await tester.pumpAndSettle();

    expect(find.text('Your cart is empty'), findsOneWidget);
  });

  testWidgets('a failed change shows an error snackbar', (tester) async {
    repository.seed({'p_coconut': 2});
    await pumpCart(tester);
    repository.failWrites = true;

    await tester.tap(find.byIcon(LucideIcons.plus));
    await tester.pumpAndSettle();

    expect(find.text("Couldn't update your cart"), findsOneWidget);
    expect(find.text('6,400 MMK'), findsNWidgets(2));
  });

  testWidgets('back returns to where the cart was opened from', (tester) async {
    await pumpRouterApp(
      tester,
      session: testSessionCubit()..signedIn(testUser),
      initialLocation: AppRoutes.settings,
    );
    await tester.pumpAndSettle();
    await tester.tap(find.bySemanticsLabel(RegExp('^Cart')));
    await tester.pumpAndSettle();
    expect(find.byType(CartScreen), findsOneWidget);

    await tester.tap(find.bySemanticsLabel('Back'));
    await tester.pumpAndSettle();

    expect(find.byType(CartScreen), findsNothing);
  });

  testWidgets('fits at text scale 1.3 on a 375 by 667 screen', (tester) async {
    tester.view
      ..physicalSize = const Size(375, 667) * 2
      ..devicePixelRatio = 2;
    tester.platformDispatcher.textScaleFactorTestValue = 1.3;
    addTearDown(tester.view.reset);
    addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
    repository.seed({'p_berry': 1, 'p_coconut': 99});

    await pumpCart(tester);

    expect(tester.takeException(), isNull);
  });
}
