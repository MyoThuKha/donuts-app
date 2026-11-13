import 'dart:convert';

import 'package:donuts/core/theme/app_theme.dart';
import 'package:donuts/core/theme/donuts_colors.dart';
import 'package:donuts/core/theme/donuts_text.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('light theme uses the bundled Schibsted Grotesk family', () {
    expect(
      AppTheme.light().textTheme.bodyMedium?.fontFamily,
      'SchibstedGrotesk',
    );
  });

  test('Myanmar script falls back to the bundled Noto Sans Myanmar', () {
    final theme = AppTheme.light();
    final text = theme.extension<DonutsText>()!;

    expect(theme.textTheme.bodyMedium?.fontFamilyFallback, ['NotoSansMyanmar']);
    for (final style in [text.body, text.sectionTitle, text.label]) {
      expect(style.fontFamilyFallback, ['NotoSansMyanmar']);
    }
  });

  test("light theme carries the J'Donuts colour tokens from the design", () {
    final colors = AppTheme.light().extension<DonutsColors>()!;

    expect(colors.primary, const Color(0xFF58CFEC));
    expect(colors.accent, const Color(0xFFEE589E));
    expect(colors.highlight, const Color(0xFFFF7F1F));
    expect(colors.canvas, const Color(0xFFEEF0F1));
    expect(colors.ink, const Color(0xFF1D2931));
  });

  test('button text style is 14/800 with 1.2 letter spacing', () {
    final text = AppTheme.light().extension<DonutsText>()!;

    expect(text.button.fontSize, 14);
    expect(text.button.fontWeight, FontWeight.w800);
    expect(text.button.letterSpacing, 1.2);
  });

  test('cardTitle is 16/800, a step above body', () {
    final text = AppTheme.light().extension<DonutsText>()!;

    expect(text.cardTitle.fontSize, 16);
    expect(text.cardTitle.fontWeight, FontWeight.w800);
  });

  test('tabActive and pointsLabel only recolour sectionTitle and label', () {
    final text = AppTheme.light().extension<DonutsText>()!;
    const colors = DonutsColors.light;

    expect(text.tabActive, text.sectionTitle.copyWith(color: colors.onPrimary));
    expect(text.pointsLabel, text.label.copyWith(color: colors.accent));
  });

  test('bannerTitle, link, captionLink, highlight and error only recolour '
      'their base roles', () {
    final text = AppTheme.light().extension<DonutsText>()!;
    const colors = DonutsColors.light;

    expect(text.bannerTitle, text.headline.copyWith(color: colors.onPrimary));
    expect(text.link, text.label.copyWith(color: colors.accent));
    expect(text.captionLink, text.caption.copyWith(color: colors.accent));
    expect(text.highlight, text.bodySmall.copyWith(color: colors.accent));
    expect(text.error, text.caption.copyWith(color: colors.danger));
  });

  testWidgets('every bundled font weight loads from the asset bundle', (
    tester,
  ) async {
    for (final weight in [
      'Regular',
      'Medium',
      'SemiBold',
      'Bold',
      'ExtraBold',
    ]) {
      final data = await rootBundle.load(
        'assets/fonts/schibsted_grotesk/SchibstedGrotesk-$weight.ttf',
      );
      expect(data.lengthInBytes, greaterThan(0));
    }
  });

  testWidgets(
    'font manifest registers the theme family at weights 400 to 800',
    (tester) async {
      final manifest = jsonDecode(
        await rootBundle.loadString('FontManifest.json'),
      ) as List<dynamic>;
      final family = manifest.cast<Map<String, dynamic>>().singleWhere(
        (entry) => entry['family'] == DonutsText.fontFamily,
      );
      final weights = [
        for (final font in family['fonts'] as List<dynamic>)
          (font as Map<String, dynamic>)['weight'],
      ];

      expect(weights, unorderedEquals([400, 500, 600, 700, 800]));
    },
  );

  test(
    'headings and buttons use Nunito, body text stays Schibsted Grotesk',
    () {
      final text = AppTheme.light().extension<DonutsText>()!;

      for (final heading in [
        text.display,
        text.title,
        text.headline,
        text.sectionTitle,
        text.tabActive,
        text.points,
        text.button,
      ]) {
        expect(heading.fontFamily, DonutsText.roundedFamily);
      }
      for (final plain in [
        text.body,
        text.label,
        text.caption,
        text.cardTitle,
      ]) {
        expect(plain.fontFamily, DonutsText.fontFamily);
      }
    },
  );

  testWidgets('font manifest registers Nunito at weights 500 to 800', (
    tester,
  ) async {
    // Real asset I/O, outside the test's fake clock.
    final source = await tester.runAsync(
      () => rootBundle.loadString('FontManifest.json', cache: false),
    );
    final manifest = jsonDecode(source!) as List<dynamic>;
    final family = manifest.cast<Map<String, dynamic>>().singleWhere(
      (entry) => entry['family'] == DonutsText.roundedFamily,
    );
    final weights = [
      for (final font in family['fonts'] as List<dynamic>)
        (font as Map<String, dynamic>)['weight'],
    ];

    expect(weights, unorderedEquals([500, 600, 700, 800]));
  });

  test('error colour is the danger token, not the link pink', () {
    expect(AppTheme.light().colorScheme.error, DonutsColors.light.danger);
  });
}
