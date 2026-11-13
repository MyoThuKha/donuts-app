import 'dart:async';

import 'package:donuts/app/shell/widgets/app_bottom_nav.dart';
import 'package:donuts/core/router/app_routes.dart';
import 'package:donuts/core/widgets/images/product_hero_tag.dart';
import 'package:donuts/features/auth/presentation/onboarding/onboarding_screen.dart';
import 'package:donuts/features/home/presentation/home_screen.dart';
import 'package:donuts/features/product/presentation/product_detail_screen.dart';
import 'package:donuts/features/rewards/presentation/rewards_screen.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

import '../../helpers/fakes.dart';
import '../../helpers/pump_app.dart';

ProductDetailScreen _detail(WidgetTester tester) =>
    tester.widget<ProductDetailScreen>(find.byType(ProductDetailScreen));

void main() {
  testWidgets('/home shows HomeScreen inside the shell', (tester) async {
    await pumpRouterApp(
      tester,
      session: testSessionCubit()..signedIn(testUser),
    );

    expect(find.byType(HomeScreen), findsOneWidget);
    expect(find.byType(AppBottomNav), findsOneWidget);
  });

  testWidgets('/rewards shows RewardsScreen inside the shell', (tester) async {
    await pumpRouterApp(
      tester,
      session: testSessionCubit()..signedIn(testUser),
      initialLocation: AppRoutes.rewards,
    );

    expect(find.byType(RewardsScreen), findsOneWidget);
    expect(find.byType(AppBottomNav), findsOneWidget);
  });

  testWidgets(
    '/product/p_coconut shows ProductDetailScreen for p_coconut without the '
    'bottom nav',
    (tester) async {
      await pumpRouterApp(
        tester,
        session: testSessionCubit()..signedIn(testUser),
        initialLocation: AppRoutes.productDetail('p_coconut'),
      );

      expect(_detail(tester).productId, 'p_coconut');
      expect(_detail(tester).heroTag, productHeroTag('p_coconut'));
      expect(find.byType(AppBottomNav), findsNothing);
    },
  );

  testWidgets('a signed-out user opening a product link lands on onboarding', (
    tester,
  ) async {
    await pumpRouterApp(
      tester,
      session: testSessionCubit(),
      initialLocation: AppRoutes.productDetail('p_coconut'),
    );

    expect(find.byType(OnboardingScreen), findsOneWidget);
    expect(find.byType(ProductDetailScreen), findsNothing);
  });

  testWidgets('the product route uses the hero tag passed as extra', (
    tester,
  ) async {
    await pumpRouterApp(
      tester,
      session: testSessionCubit()..signedIn(testUser),
    );
    final scoped = productHeroTag('p_dalgona', scope: 'order_again');

    final router = GoRouter.of(tester.element(find.byType(HomeScreen)));
    unawaited(router.push(AppRoutes.productDetail('p_dalgona'), extra: scoped));
    await tester.pumpAndSettle();

    expect(_detail(tester).productId, 'p_dalgona');
    expect(_detail(tester).heroTag, scoped);
  });
}
