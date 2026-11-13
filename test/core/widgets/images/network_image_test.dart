import 'package:donuts/core/widgets/images/network_image.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

import '../../../helpers/pump_app.dart';

const _url = 'https://example.com/donut.webp';
const _asset = 'assets/images/donut_coconut.webp';

/// A cache manager whose every download fails with a 404.
class _FailingCacheManager extends Fake implements BaseCacheManager {
  @override
  Stream<FileResponse> getFileStream(
    String url, {
    String? key,
    Map<String, String>? headers,
    bool withProgress = false,
  }) => Stream.error(
    HttpExceptionWithStatus(404, 'Not found', uri: Uri.parse(url)),
  );
}

Future<void> _pumpImage(WidgetTester tester, AppNetworkImage image) async {
  await pumpThemed(tester, SizedBox(width: 120, height: 120, child: image));
  await tester.runAsync(() => Future<void>.delayed(Duration.zero));
  await tester.pump();
  await tester.pump();
}

bool _isAssetImage(Widget widget, String asset) =>
    widget is Image &&
    widget.image is AssetImage &&
    (widget.image as AssetImage).assetName == asset;

void main() {
  testWidgets('shows the placeholder box when there is no url and no asset', (
    tester,
  ) async {
    await _pumpImage(tester, const AppNetworkImage(url: null));

    expect(find.byKey(AppNetworkImage.placeholderKey), findsOneWidget);
    expect(find.byKey(AppNetworkImage.errorKey), findsNothing);
  });

  testWidgets('draws the placeholder box in the given shape', (tester) async {
    await _pumpImage(
      tester,
      const AppNetworkImage(url: null, placeholderShape: CircleBorder()),
    );

    final box = tester.widget<DecoratedBox>(
      find.byKey(AppNetworkImage.placeholderKey),
    );
    expect((box.decoration as ShapeDecoration).shape, const CircleBorder());
  });

  testWidgets(
    'shows the error tile with its label when the download fails and there '
    'is no asset',
    (tester) async {
      await _pumpImage(
        tester,
        AppNetworkImage(url: _url, cacheManager: _FailingCacheManager()),
      );

      expect(find.byKey(AppNetworkImage.errorKey), findsOneWidget);
      expect(find.bySemanticsLabel('Image unavailable'), findsOneWidget);
    },
  );

  testWidgets('shows the bundled asset when the download fails', (
    tester,
  ) async {
    await pumpThemed(
      tester,
      SizedBox(
        width: 120,
        height: 120,
        child: AppNetworkImage(
          url: _url,
          asset: _asset,
          cacheManager: _FailingCacheManager(),
        ),
      ),
    );
    await tester.runAsync(() => Future<void>.delayed(Duration.zero));
    await tester.pump();

    expect(
      find.byWidgetPredicate((w) => _isAssetImage(w, _asset)),
      findsOneWidget,
    );
    expect(find.byKey(AppNetworkImage.errorKey), findsNothing);
  });

  testWidgets('falls back to the placeholder box when the bundled asset is '
      'missing', (tester) async {
    await _pumpImage(
      tester,
      const AppNetworkImage(url: null, asset: 'assets/images/missing.webp'),
    );
    await tester.runAsync(() => Future<void>.delayed(Duration.zero));
    await tester.pump();

    expect(find.byKey(AppNetworkImage.placeholderKey), findsOneWidget);
  });
}
