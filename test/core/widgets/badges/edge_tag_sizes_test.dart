import 'package:donuts/core/theme/app_dimens.dart';
import 'package:donuts/core/widgets/badges/app_tag.dart';
import 'package:donuts/core/widgets/badges/edge_tag.dart';
import 'package:donuts/features/cart/presentation/widgets/cart_tag_widget.dart';
import 'package:donuts/features/home/presentation/widgets/notification_bell_widget.dart';
import 'package:donuts/features/rewards/presentation/widgets/rewards_pill_widget.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

import '../../../helpers/pump_app.dart';

/*
 The design draws the Home bell 36 points tall and the Rewards pill 42,
 each running off the right edge only a little past its count badge. Test
 fonts are boxes, so widths aren't checked: the height and the run past the
 badge set the proportions.
*/

double _height(WidgetTester tester) =>
    tester.getSize(find.byType(EdgeTag)).height;

/// From the count badge's right side to the tag's right edge.
double _runPastBadge(WidgetTester tester) =>
    tester.getTopRight(find.byType(EdgeTag)).dx -
    tester.getTopRight(find.byType(AppTag)).dx;

void main() {
  testWidgets('the bell tag is 36 tall with a short run past its count', (
    tester,
  ) async {
    await pumpThemed(
      tester,
      const Align(child: NotificationBellWidget(count: 2)),
    );

    expect(_height(tester), 36);
    expect(_runPastBadge(tester), AppSpacing.s);
  });

  testWidgets('the cart tag matches the bell', (tester) async {
    await pumpThemed(
      tester,
      Align(child: CartTagWidget(count: 2, onTap: () {})),
    );

    expect(_height(tester), 36);
    expect(_runPastBadge(tester), AppSpacing.s);
  });

  testWidgets('the Rewards pill is 42 tall with a short run past its count', (
    tester,
  ) async {
    await pumpThemed(
      tester,
      const Align(
        child: RewardsPill(count: 3, badge: AlwaysStoppedAnimation(1)),
      ),
    );

    expect(_height(tester), 42);
    expect(_runPastBadge(tester), AppSpacing.s);
  });
}
