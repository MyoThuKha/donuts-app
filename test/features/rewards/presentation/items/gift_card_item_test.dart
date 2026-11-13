import 'package:donuts/core/theme/app_dimens.dart';
import 'package:donuts/core/widgets/images/rounded_network_image.dart';
import 'package:donuts/features/rewards/domain/vo/gift_vo.dart';
import 'package:donuts/features/rewards/presentation/items/gift_card_item.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../helpers/pump_app.dart';

void main() {
  testWidgets('gift art is a contained, rounded picture', (tester) async {
    await pumpThemed(
      tester,
      const GiftCardItem(
        gift: GiftVO(
          id: 'g1',
          title: 'Box of six',
          costPoints: 300,
          imageAsset: 'a.png',
        ),
      ),
    );

    final art = tester.widget<RoundedNetworkImage>(
      find.byType(RoundedNetworkImage),
    );
    expect(art.radius, AppRadii.tile);
    expect(art.fit, BoxFit.contain);
  });
}
