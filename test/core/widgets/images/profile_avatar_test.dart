import 'package:donuts/core/theme/donuts_colors.dart';
import 'package:donuts/core/widgets/images/profile_avatar.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

import '../../../helpers/pump_app.dart';

/// The asset behind [image], looking through the resize a decode width adds.
String? _assetName(ImageProvider image) => switch (image) {
  AssetImage(:final assetName) => assetName,
  ResizeImage(:final imageProvider) => _assetName(imageProvider),
  _ => null,
};

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

  testWidgets('with no photo downloaded it shows the bundled photo', (
    tester,
  ) async {
    const asset = 'assets/images/avatar_member.webp';
    await pumpThemed(
      tester,
      const Center(
        child: ProfileAvatar(
          imageUrl: null,
          asset: asset,
          size: 58,
          initials: 'YP',
        ),
      ),
    );

    expect(
      find.byWidgetPredicate((w) => w is Image && _assetName(w.image) == asset),
      findsOneWidget,
    );
  });
}
