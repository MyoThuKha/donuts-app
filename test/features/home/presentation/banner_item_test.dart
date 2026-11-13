import 'package:donuts/core/widgets/images/network_image.dart';
import 'package:donuts/features/home/presentation/home_dimens.dart';
import 'package:donuts/features/home/presentation/items/banner_item.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

import '../../../helpers/app_fonts.dart';
import '../../../helpers/home_fixtures.dart';
import '../../../helpers/pump_app.dart';

/// A card on a 4.7-inch phone: 80% of 375 pt less the page gutter.
const double _smallCardWidth = 280;

Future<void> _pumpBanner(WidgetTester tester, double textScale) async {
  tester.platformDispatcher.textScaleFactorTestValue = textScale;
  addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
  await pumpThemed(
    tester,
    Center(
      child: SizedBox(
        width: _smallCardWidth,
        height: HomeDimens.bannerHeight,
        child: BannerItem(banner: testBanners.first),
      ),
    ),
  );
  await tester.pump();
}

void main() {
  setUpAll(loadAppFonts);

  for (final scale in [1.0, 1.3]) {
    testWidgets('the whole title stays above the photo at ${scale}x text', (
      tester,
    ) async {
      await _pumpBanner(tester, scale);

      final titleFinder = find.text(testBanners.first.title);
      final title = tester.getRect(titleFinder);
      final photo = tester.getRect(find.byType(AppNetworkImage));
      final paragraph = tester.renderObject<RenderParagraph>(
        find.descendant(of: titleFinder, matching: find.byType(RichText)),
      );

      expect(title.bottom, lessThanOrEqualTo(photo.top));
      expect(paragraph.didExceedMaxLines, isFalse, reason: 'no ellipsis');
      expect(tester.takeException(), isNull);
    });
  }

  testWidgets('at 1x the photo keeps its design height', (tester) async {
    await _pumpBanner(tester, 1);

    final photo = tester.getRect(find.byType(AppNetworkImage));

    expect(
      photo.height,
      closeTo(
        HomeDimens.bannerHeight * HomeDimens.bannerImageFactor.height,
        0.01,
      ),
    );
  });
}
