import 'package:donuts/core/theme/donuts_colors.dart';
import 'package:donuts/core/theme/donuts_text.dart';
import 'package:material_ui/material_ui.dart';

extension ThemeContext on BuildContext {
  DonutsColors get colors => Theme.of(this).extension<DonutsColors>()!;

  DonutsText get text => Theme.of(this).extension<DonutsText>()!;
}
