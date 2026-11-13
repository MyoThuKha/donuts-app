import 'package:donuts/core/widgets/images/blended_fit_image.dart';
import 'package:donuts/core/widgets/images/network_image.dart';
import 'package:donuts/core/widgets/images/rounded_network_image.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

import '../../../helpers/pump_app.dart';

void main() {
  test('provider is null without a url or an asset', () {
    expect(AppNetworkImage.provider(), isNull);
  });

  test('provider resizes an asset to the decode width', () {
    final provider = AppNetworkImage.provider(asset: 'a.png', cacheWidth: 800);

    expect(provider, isA<ResizeImage>());
    final resized = provider! as ResizeImage;
    expect(resized.width, 800);
    expect(resized.imageProvider, const AssetImage('a.png'));
  });

  testWidgets('shows the placeholder box with nothing to load', (tester) async {
    await pumpThemed(
      tester,
      const Center(
        child: SizedBox.square(
          dimension: 100,
          child: RoundedNetworkImage(url: null, radius: 12),
        ),
      ),
    );

    expect(find.byKey(AppNetworkImage.placeholderKey), findsOneWidget);
    expect(find.byType(BlendedFitImage), findsNothing);
  });

  testWidgets('shows the placeholder until the image loads', (tester) async {
    await pumpThemed(
      tester,
      const Center(
        child: SizedBox.square(
          dimension: 100,
          child: RoundedNetworkImage(
            url: null,
            asset: 'missing.png',
            radius: 12,
          ),
        ),
      ),
    );

    expect(find.byType(BlendedFitImage), findsOneWidget);
    expect(find.byKey(AppNetworkImage.placeholderKey), findsOneWidget);
    expect(find.byType(RawImage), findsNothing);
  });

  testWidgets('passes the placeholder shape and fallback on', (tester) async {
    await pumpThemed(
      tester,
      const Center(
        child: SizedBox.square(
          dimension: 100,
          child: RoundedNetworkImage(
            url: null,
            radius: 12,
            placeholderShape: CircleBorder(),
            fallback: Text('TU'),
          ),
        ),
      ),
    );

    final image = tester.widget<AppNetworkImage>(find.byType(AppNetworkImage));
    expect(image.placeholderShape, const CircleBorder());
    expect(find.text('TU'), findsOneWidget);
  });

  testWidgets('falls back to the bundled asset for the picture', (
    tester,
  ) async {
    await pumpThemed(
      tester,
      const Center(
        child: SizedBox.square(
          dimension: 100,
          child: RoundedNetworkImage(
            url: 'https://example.com/a.jpg',
            asset: 'a.png',
            radius: 12,
            cacheWidth: 800,
          ),
        ),
      ),
    );

    final blended = tester.widget<BlendedFitImage>(
      find.byType(BlendedFitImage),
    );
    expect(
      blended.fallbackImage,
      AppNetworkImage.provider(asset: 'a.png', cacheWidth: 800),
    );
  });
}
