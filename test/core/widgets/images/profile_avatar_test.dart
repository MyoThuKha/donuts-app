import 'package:donuts/core/theme/donuts_colors.dart';
import 'package:donuts/core/widgets/images/profile_avatar.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

import '../../../helpers/pump_app.dart';

void main() {
  testWidgets('without a photo it shows the initials on pink at its size', (
    tester,
  ) async {
    await pumpThemed(
      tester,
      const Center(
        child: ProfileAvatar(imageUrl: null, size: 58, initials: 'YP'),
      ),
    );

    expect(tester.getSize(find.byType(ProfileAvatar)), const Size.square(58));
    expect(find.text('YP'), findsOneWidget);
    expect(
      find.byWidgetPredicate(
        (w) => w is ColoredBox && w.color == DonutsColors.light.accent,
      ),
      findsOneWidget,
    );
  });
}
