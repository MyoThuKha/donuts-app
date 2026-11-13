import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:donuts/core/widgets/images/blended_fit_image.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

/// A 200 x 100 landscape photo, like a seasonal box photo.
Future<MemoryImage> _landscapePhoto(WidgetTester tester) async {
  final bytes = await tester.runAsync(() async {
    final image = await createTestImage(width: 200, height: 100);
    final data = await image.toByteData(format: ui.ImageByteFormat.png);
    return data!.buffer.asUint8List();
  });
  return MemoryImage(bytes!);
}

Future<Size> _paintedSize(
  WidgetTester tester,
  MemoryImage photo,
  double t,
) async {
  await tester.pumpWidget(
    Center(
      child: SizedBox.square(
        dimension: 100,
        child: BlendedFitImage(
          image: photo,
          from: BoxFit.cover,
          to: BoxFit.contain,
          t: t,
          placeholder: const SizedBox.expand(key: Key('placeholder')),
        ),
      ),
    ),
  );
  await tester.runAsync(
    () => precacheImage(photo, tester.binding.rootElement!),
  );
  await tester.pump();
  return tester.getSize(find.byType(RawImage));
}

/// Pumps [photo] alone in a 100 x 100 box with [fit] and a 12 pt radius,
/// and returns the rounded clip once the photo has loaded.
Future<ClipRRect> _clipFor(
  WidgetTester tester,
  MemoryImage photo,
  BoxFit fit,
) async {
  await tester.pumpWidget(
    Center(
      child: SizedBox.square(
        dimension: 100,
        child: BlendedFitImage(
          image: photo,
          from: fit,
          radius: 12,
          placeholder: const SizedBox.expand(),
        ),
      ),
    ),
  );
  await tester.runAsync(
    () => precacheImage(photo, tester.binding.rootElement!),
  );
  await tester.pump();
  return tester.widget<ClipRRect>(find.byType(ClipRRect));
}

void main() {
  testWidgets('a contained photo is clipped to its own rectangle with the '
      'radius', (tester) async {
    final photo = await _landscapePhoto(tester);

    final clip = await _clipFor(tester, photo, BoxFit.contain);

    expect(tester.getSize(find.byType(ClipRRect)), const Size(100, 50));
    expect(clip.borderRadius, BorderRadius.circular(12));
  });

  testWidgets('a covered photo is clipped to the box', (tester) async {
    final photo = await _landscapePhoto(tester);

    await _clipFor(tester, photo, BoxFit.cover);

    expect(tester.getSize(find.byType(ClipRRect)), const Size(100, 100));
  });

  testWidgets('a landscape photo eases from the cover size to the contain '
      'size in a square box', (tester) async {
    final photo = await _landscapePhoto(tester);

    expect(await _paintedSize(tester, photo, 0), const Size(200, 100));
    expect(await _paintedSize(tester, photo, 0.5), const Size(150, 75));
    expect(await _paintedSize(tester, photo, 1), const Size(100, 50));
  });

  testWidgets('the placeholder shows until the photo loads', (tester) async {
    final photo = await _landscapePhoto(tester);
    await tester.pumpWidget(
      BlendedFitImage(
        image: photo,
        from: BoxFit.cover,
        to: BoxFit.contain,
        t: 0,
        placeholder: const SizedBox.expand(key: Key('placeholder')),
      ),
    );

    expect(find.byKey(const Key('placeholder')), findsOneWidget);
    expect(find.byType(RawImage), findsNothing);
  });

  testWidgets('shows the fallback picture rounded while the main image has '
      'nothing', (tester) async {
    final photo = await _landscapePhoto(tester);
    final broken = MemoryImage(Uint8List.fromList([0, 1, 2, 3]));
    await tester.pumpWidget(
      Center(
        child: SizedBox.square(
          dimension: 100,
          child: BlendedFitImage(
            image: broken,
            fallbackImage: photo,
            from: BoxFit.contain,
            radius: 12,
            placeholder: const SizedBox.expand(key: Key('placeholder')),
          ),
        ),
      ),
    );
    await tester.runAsync(() async {
      await precacheImage(photo, tester.binding.rootElement!);
      await Future<void>.delayed(const Duration(milliseconds: 100));
    });
    await tester.pump();

    expect(find.byKey(const Key('placeholder')), findsNothing);
    expect(tester.getSize(find.byType(ClipRRect)), const Size(100, 50));
  });
}
