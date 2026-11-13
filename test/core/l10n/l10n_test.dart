import 'package:donuts/core/l10n/l10n.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

void main() {
  testWidgets('English strings resolve through context.l10n', (tester) async {
    late AppLocalizations l10n;
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: appLocalizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Builder(
          builder: (context) {
            l10n = context.l10n;
            return const SizedBox.shrink();
          },
        ),
      ),
    );

    expect(l10n.tabReward, 'Reward');
    expect(l10n.placeholderComingSoon('Wallet'), 'Wallet is coming soon');
  });

  test('screen 8 to 10 strings read as designed', () async {
    final l10n = await AppLocalizations.delegate.load(const Locale('en'));

    expect(
      l10n.homeShopsTitle(4),
      'There are 4 J’Donut shops near\u00A0you.\u00A0😋',
    );
    expect(
      l10n.homeShopsTitle(1),
      'There is 1 J’Donut shop near\u00A0you.\u00A0😋',
    );
    expect(l10n.productPrice('3,200'), '3,200 MMK');
    expect(
      l10n.rewardsTierRemaining('500', 'Gold'),
      '500 pts Remaining to become Gold',
    );
    expect(
      l10n.productAddedToCart(2, 'Coconut Donut'),
      'Added 2 Coconut Donut to your cart',
    );
    expect(l10n.discountOff(50), '50% off');
    expect(l10n.rewardsProgress(9, 12), '9/12');
  });
}
