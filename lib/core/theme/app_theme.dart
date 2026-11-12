import 'package:donuts/core/theme/donuts_colors.dart';
import 'package:donuts/core/theme/donuts_text.dart';
import 'package:material_ui/material_ui.dart';

abstract final class AppTheme {
  static ThemeData light() {
    const colors = DonutsColors.light;
    final text = DonutsText.fromColors(colors);
    return ThemeData(
      colorScheme: ColorScheme(
        brightness: Brightness.light,
        primary: colors.primary,
        onPrimary: colors.onPrimary,
        secondary: colors.accent,
        onSecondary: colors.onPrimary,
        tertiary: colors.highlight,
        onTertiary: colors.onPrimary,
        error: colors.accent,
        onError: colors.onPrimary,
        surface: colors.surface,
        onSurface: colors.ink,
      ),
      fontFamily: DonutsText.fontFamily,
      scaffoldBackgroundColor: colors.canvas,
      extensions: [colors, text],
    );
  }
}
