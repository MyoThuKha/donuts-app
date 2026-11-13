import 'dart:convert';

import 'package:donuts/core/theme/app_theme.dart';
import 'package:donuts/core/theme/donuts_colors.dart';
import 'package:donuts/core/theme/donuts_text.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('light theme uses the bundled Plus Jakarta Sans family', () {
    expect(
      AppTheme.light().textTheme.bodyMedium?.fontFamily,
      'PlusJakartaSans',
    );
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
        'assets/fonts/PlusJakartaSans-$weight.ttf',
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

  test('error colour is the danger token, not the link pink', () {
    expect(AppTheme.light().colorScheme.error, DonutsColors.light.danger);
  });
}
