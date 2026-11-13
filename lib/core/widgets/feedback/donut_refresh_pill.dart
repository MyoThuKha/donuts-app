import 'dart:math' as math;

import 'package:donuts/core/l10n/l10n.dart';
import 'package:donuts/core/theme/app_dimens.dart';
import 'package:donuts/core/theme/app_shadows.dart';
import 'package:donuts/core/theme/theme_context.dart';
import 'package:material_ui/material_ui.dart';

/// The white circle with the donut that `DonutRefreshIndicator` shows. At
/// [expand] 1 it is a pill with the loading label to the donut's right.
/// The donut turns [turns] times.
class DonutRefreshPill extends StatelessWidget {
  const new({required this.expand, required this.turns, super.key});

  final double expand;
  final double turns;

  static const String _donut = 'assets/images/reward_donut.png';

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final donutPixels =
        (AppSizes.refreshDonut * MediaQuery.devicePixelRatioOf(context))
            .round();

    return DecoratedBox(
      decoration: ShapeDecoration(
        color: colors.surface,
        shape: const StadiumBorder(),
        shadows: AppShadows.floating(colors),
      ),
      child: SizedBox(
        height: AppSizes.refreshIndicator,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox.square(
              dimension: AppSizes.refreshIndicator,
              child: Center(
                child: Transform.rotate(
                  angle: turns * 2 * math.pi,
                  child: Image.asset(
                    _donut,
                    width: AppSizes.refreshDonut,
                    height: AppSizes.refreshDonut,
                    cacheWidth: donutPixels,
                    excludeFromSemantics: true,
                  ),
                ),
              ),
            ),
            if (expand > 0)
              ClipRect(
                child: Align(
                  alignment: Alignment.centerLeft,
                  widthFactor: expand,
                  child: Opacity(
                    opacity: expand,
                    child: Padding(
                      padding: const EdgeInsets.only(right: AppSpacing.xl),
                      child: Text(
                        context.l10n.refreshLoading,
                        style: context.text.label,
                        maxLines: 1,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
