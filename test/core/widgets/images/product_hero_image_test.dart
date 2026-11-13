import 'package:donuts/core/widgets/images/network_image.dart';
import 'package:donuts/core/widgets/images/product_hero_image.dart';
import 'package:donuts/core/widgets/images/rounded_network_image.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

import '../../../helpers/pump_app.dart';

const _home = ProductHeroImage(
  url: null,
  asset: 'home.png',
  radius: 12,
  inset: 0.2,
);
const _detail = ProductHeroImage(url: null, asset: null, pictureRadius: 8);

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
      expect(image.toFit, BoxFit.contain);
      expect(image.progress, 0.5);
      expect(image.pictureRadius, 8);
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

  testWidgets('a picture radius draws through RoundedNetworkImage', (
    tester,
  ) async {
    await pumpThemed(
      tester,
      const SizedBox.square(
        dimension: 100,
        child: ProductHeroImage(url: null, asset: 'a.png', pictureRadius: 8),
      ),
    );

    final image = tester.widget<RoundedNetworkImage>(
      find.byType(RoundedNetworkImage),
    );
    expect(image.radius, 8);
  });

  testWidgets('Home tiles keep the plain image', (tester) async {
    await pumpThemed(
      tester,
      const SizedBox.square(
        dimension: 100,
        child: ProductHeroImage(url: null, asset: 'a.png', radius: 12),
      ),
    );

    expect(find.byType(RoundedNetworkImage), findsNothing);
    expect(find.byType(AppNetworkImage), findsOneWidget);
  });

  testWidgets('tile radius follows the text scale', (tester) async {
    late double regular;
    late double large;
    await pumpThemed(
      tester,
      Column(
        children: [
          Builder(
            builder: (context) {
              regular = ProductHeroImage.tileRadius(context);
              return const SizedBox();
            },
          ),
          MediaQuery(
            data: const MediaQueryData(textScaler: TextScaler.linear(2)),
            child: Builder(
              builder: (context) {
                large = ProductHeroImage.tileRadius(context);
                return const SizedBox();
              },
            ),
          ),
        ],
      ),
    );

    expect(large, greaterThan(regular));
  });
}
