import 'package:donuts/core/widgets/images/network_image.dart';
import 'package:donuts/core/widgets/images/product_hero_image.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

import '../../../helpers/pump_app.dart';

const _home = ProductHeroImage(
  url: null,
  asset: 'home.png',
  radius: 12,
  inset: 0.2,
);
const _detail = ProductHeroImage(url: null, asset: null);

Future<(Element, Element)> _pumpHeroes(WidgetTester tester) async {
  await pumpThemed(
    tester,
    const Column(
      children: [
        SizedBox.square(
          dimension: 10,
          child: Hero(tag: 'home', child: _home),
        ),
        SizedBox.square(
          dimension: 10,
          child: Hero(tag: 'detail', child: _detail),
        ),
      ],
    ),
  );
  final heroes = find.byType(Hero).evaluate().toList();
  return (heroes[0], heroes[1]);
}

void main() {
  for (final direction in HeroFlightDirection.values) {
    testWidgets('on a $direction the shuttle flies the Home photo and eases '
        'the corners', (tester) async {
      final animation = AnimationController(
        vsync: const TestVSync(),
        value: 0.5,
      );
      addTearDown(animation.dispose);
      final (home, detail) = await _pumpHeroes(tester);
      final (from, to) = direction == HeroFlightDirection.push
          ? (home, detail)
          : (detail, home);

      final shuttle = productHeroShuttle(from, animation, direction, from, to);
      await pumpThemed(tester, SizedBox.square(dimension: 10, child: shuttle));

      final image = tester.widget<ProductHeroImage>(
        find.byType(ProductHeroImage),
      );
      expect(image.asset, 'home.png');
      expect(image.radius, 6);
      expect(image.inset, closeTo(0.1, 1e-9));
      expect(image.fit, BoxFit.contain);
    });
  }

  testWidgets('with no image the white card still shows', (tester) async {
    await pumpThemed(
      tester,
      const Center(
        child: SizedBox(
          width: 100,
          height: 150,
          child: ProductHeroImage(url: null, asset: null, inset: 0.15),
        ),
      ),
    );

    final placeholder = tester.widget<DecoratedBox>(
      find.byKey(AppNetworkImage.placeholderKey),
    );
    expect((placeholder.decoration as ShapeDecoration).color, Colors.white);
    expect(
      tester.getSize(find.byKey(AppNetworkImage.placeholderKey)),
      const Size(70, 105),
    );
  });
}
