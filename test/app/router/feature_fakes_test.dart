import 'package:donuts/core/di/locator.dart';
import 'package:donuts/core/router/app_routes.dart';
import 'package:donuts/core/sync/presentation/catalog_sync_cubit.dart';
import 'package:donuts/core/sync/presentation/catalog_sync_state.dart';
import 'package:donuts/core/widgets/images/product_hero_tag.dart';
import 'package:donuts/features/home/presentation/home_screen.dart';
import 'package:donuts/features/rewards/domain/usecases/watch_member_summary_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

import '../../helpers/fakes.dart';
import '../../helpers/pump_app.dart';

void main() {
  testWidgets(
    'pumpRouterApp provides a member summary for 680,000 points at Silver',
    (tester) async {
      await pumpRouterApp(
        tester,
        session: testSessionCubit()..signedIn(testUser),
      );

      final summary = await getIt<WatchMemberSummaryUseCase>()().first;

      expect(summary?.totalPoints, 680000);
      expect(summary?.tierProgress.current?.name, 'Silver');
      expect(summary?.tiers.map((t) => t.sortOrder), [0, 1, 2]);
    },
  );

  testWidgets("pumpRouterApp's catalog refresh completes without network", (
    tester,
  ) async {
    await pumpRouterApp(
      tester,
      session: testSessionCubit()..signedIn(testUser),
    );
    final sync = tester
        .element(find.byType(HomeScreen))
        .read<CatalogSyncCubit>();

    await sync.refresh();

    expect(sync.state.status, CatalogSyncStatus.succeeded);
  });

  testWidgets('the product stub carries the hero tag it was given', (
    tester,
  ) async {
    await pumpRouterApp(
      tester,
      session: testSessionCubit()..signedIn(testUser),
      initialLocation: AppRoutes.productDetail('p_coconut'),
    );

    final hero = tester.widget<Hero>(find.byType(Hero));
    expect(hero.tag, productHeroTag('p_coconut'));
    expect(find.byType(Material), findsWidgets);
  });
}
