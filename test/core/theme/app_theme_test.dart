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

    expect(colors.primary, const Color(0xFF88D4EC));
    expect(colors.accent, const Color(0xFFE87BAC));
    expect(colors.highlight, const Color(0xFFF3984B));
    expect(colors.canvas, const Color(0xFFF1F3F3));
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
}
