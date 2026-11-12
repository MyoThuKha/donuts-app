import 'package:donuts/core/widgets/images/product_hero_tag.dart';
import 'package:donuts/features/home/presentation/items/product_tile_item.dart';
import 'package:donuts/features/product/presentation/product_detail_screen.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

import '../../../helpers/fakes.dart';
import '../../../helpers/home_harness.dart';
import '../../../helpers/pump_app.dart';

Finder _tile(String name) =>
    find.ancestor(of: find.text(name), matching: find.byType(ProductTileItem));

void main() {
  testWidgets('tapping a tile opens its product detail', (tester) async {
    useTallPhoneSurface(tester);
    await pumpRouterApp(
      tester,
      session: testSessionCubit()..signedIn(testUser),
    );

    final tile = _tile('Coconut Donut');
    final hero = tester.widget<Hero>(
      find.descendant(of: tile, matching: find.byType(Hero)),
    );
    expect(hero.tag, productHeroTag('p_coconut', scope: 'popular'));

    await tester.ensureVisible(tile);
    await tester.pumpAndSettle();
    await tester.tap(tile);
    await tester.pumpAndSettle();

    final detail = tester.widget<ProductDetailScreen>(
      find.byType(ProductDetailScreen),
    );
    expect(detail.productId, 'p_coconut');
    expect(detail.heroTag, productHeroTag('p_coconut', scope: 'popular'));
  });

  testWidgets('Dalgona opens from Order again although Popular lists it too', (
    tester,
  ) async {
    useTallPhoneSurface(tester);
    await pumpRouterApp(
      tester,
      session: testSessionCubit()..signedIn(testUser),
    );

    final orderAgainDalgona = _tile('Dalgona Creamy Coffee').last;
    await tester.ensureVisible(orderAgainDalgona);
    await tester.pumpAndSettle();
    await tester.tap(orderAgainDalgona);
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
    final detail = tester.widget<ProductDetailScreen>(
      find.byType(ProductDetailScreen),
    );
    expect(detail.productId, 'p_dalgona');
    expect(detail.heroTag, productHeroTag('p_dalgona', scope: 'order_again'));
  });
}
