import 'package:donuts/features/auth/presentation/onboarding/onboarding_screen.dart';
import 'package:donuts/features/auth/presentation/welcome/welcome_screen.dart';
import 'package:donuts/features/home/presentation/home_screen.dart';
import 'package:donuts/features/product/presentation/product_detail_screen.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../test/helpers/memory_session_store.dart';
import 'helpers/app_flow.dart';

/*
 Runs the whole app on a device: a new user registers, lands on Home and
 opens Coconut Donut.

 The app uses its real fake auth (with the 1 s wait), the bundled seed and
 every real screen. Only three things are swapped so each run starts the
 same way:
 - an in-memory database, so the phone number is always unregistered,
 - an in-memory session store, so no session survives from an earlier run,
 - a connectivity source that reports no network, so Home renders from the
   seed alone, as it does in airplane mode.
*/

const String _phone = '09254135592';
const String _productName = 'Coconut Donut';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('a new user registers, reaches Home and opens a product', (
    tester,
  ) async {
    final sessionStore = MemorySessionStore();
    await startApp(tester, sessionStore);

    await tapPrimary(tester, OnboardingScreen);
    await enterPhone(tester, _phone);
    await enterOtp(tester);
    await enterName(tester);
    await pickDateOfBirth(tester, DateTime(1995, 6, 15));

    await waitForScreen(tester, WelcomeScreen);
    expect(sessionStore.userId, isNotNull);
    await tapPrimary(tester, WelcomeScreen);

    await waitFor(tester, find.byType(HomeScreen));
    await openProduct(tester, _productName);

    await waitForScreen(tester, ProductDetailScreen);
    for (final text in ['JD022123', _productName, 'What’s this?']) {
      expect(inside(ProductDetailScreen, find.text(text)), findsOneWidget);
    }
    // The unit price, and the Add to cart total for one.
    expect(inside(ProductDetailScreen, find.text('3,200 MMK')), findsWidgets);

    await tester.tap(find.byIcon(LucideIcons.plus));
    await waitFor(tester, inside(ProductDetailScreen, find.text('6,400 MMK')));
  });
}
