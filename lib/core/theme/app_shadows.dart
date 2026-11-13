import 'package:donuts/core/theme/donuts_colors.dart';
import 'package:material_ui/material_ui.dart';

/// Shadows for surfaces that float over the page.
abstract final class AppShadows {
  static const double _floatingAlpha = 0.12;
  static const double _floatingBlur = 16;
  static const Offset _floatingDrop = Offset(0, 4);

  /// The soft drop under white pills that float over content, such as the
  /// pull-to-refresh indicator and the snackbar.
  static List<BoxShadow> floating(DonutsColors colors) => [
    BoxShadow(
      color: colors.ink.withValues(alpha: _floatingAlpha),
      blurRadius: _floatingBlur,
      offset: _floatingDrop,
    ),
  ];
}
