import 'package:donuts/app/shell/widgets/nav_icons.dart';
import 'package:donuts/features/auth/presentation/onboarding/onboarding_screen.dart';
import 'package:donuts/features/auth/presentation/welcome/welcome_screen.dart';
import 'package:donuts/features/cart/presentation/cart_screen.dart';
import 'package:donuts/features/home/presentation/home_screen.dart';
import 'package:donuts/features/product/presentation/product_detail_screen.dart';
import 'package:donuts/features/settings/presentation/settings_screen.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:material_ui/material_ui.dart';

import '../test/helpers/memory_session_store.dart';
import 'helpers/app_flow.dart';

/*
 Runs the cart on a device with the real database code: a new user adds
 two Coconut Donuts, edits the cart and removes the item, adds one more,
 then logs out and back in to find the cart empty. The setup is the same as the
 register-to-product test: in-memory database and session, no network.
*/

const String _phone = '09254135592';
const String _productName = 'Coconut Donut';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('a new user adds to the cart, edits it, and log out empties it', (
    tester,
  ) async {
    await startApp(tester, MemorySessionStore());
    await _register(tester);

    // Two Coconut Donuts into the cart from Product detail.
    await openProduct(tester, _productName);
    await waitForScreen(tester, ProductDetailScreen);
    await tester.tap(find.byIcon(LucideIcons.plus));
    await waitFor(tester, inside(ProductDetailScreen, find.text('6,400 MMK')));
    await tapPrimary(tester, ProductDetailScreen);
    await waitFor(tester, find.text('Added 2 Coconut Donut to your cart'));
    await tester.tap(find.bySemanticsLabel('Back'));
    await waitForScreen(tester, HomeScreen);

    // Settings shows the count, and its tag opens the cart.
    await _openCartFromSettings(tester, itemsLabel: 'Cart, 2 items');
    expect(inside(CartScreen, find.text(_productName)), findsOneWidget);
    expect(inside(CartScreen, find.text('6,400 MMK')), findsNWidgets(2));

    // Plus writes 3, then minus twice brings it back to 1.
    await tester.tap(inside(CartScreen, find.byIcon(LucideIcons.plus)));
    await waitFor(tester, inside(CartScreen, find.text('9,600 MMK')));
    for (var i = 0; i < 2; i++) {
      await tester.tap(inside(CartScreen, find.byIcon(LucideIcons.minus)));
      await tester.pump(pollStep);
    }
    await waitFor(tester, inside(CartScreen, find.byIcon(LucideIcons.trash2)));

    // Trash empties the cart.
    await tester.tap(inside(CartScreen, find.byIcon(LucideIcons.trash2)));
    await waitFor(tester, find.text('Your cart is empty'));

    // One more from Product detail, so log out has something to empty.
    await tester.tap(find.bySemanticsLabel('Back'));
    await waitForScreen(tester, SettingsScreen);
    await tester.tap(find.byKey(const ValueKey(NavIcons.home)));
    await waitFor(tester, find.byType(HomeScreen));
    await openProduct(tester, _productName);
    await waitForScreen(tester, ProductDetailScreen);
    await tapPrimary(tester, ProductDetailScreen);
    await waitFor(tester, find.text('Added 1 Coconut Donut to your cart'));
    await tester.tap(find.bySemanticsLabel('Back'));
    await waitForScreen(tester, HomeScreen);
    await tester.tap(find.byKey(const ValueKey(NavIcons.settings)));
    await waitForScreen(tester, SettingsScreen);
    await waitFor(tester, find.bySemanticsLabel('Cart, 1 item'));

    // Log out empties the cart, so the next sign-in starts with none.
    await _logOut(tester);
    await _logIn(tester);
    await _openCartFromSettings(tester, itemsLabel: 'Cart, empty');
    expect(find.text('Your cart is empty'), findsOneWidget);
  });
}

Future<void> _register(WidgetTester tester) async {
  await tapPrimary(tester, OnboardingScreen);
  await enterPhone(tester, _phone);
  await enterOtp(tester);
  await enterName(tester);
  await pickDateOfBirth(tester, DateTime(1995, 6, 15));
  await waitForScreen(tester, WelcomeScreen);
  await tapPrimary(tester, WelcomeScreen);
  await waitFor(tester, find.byType(HomeScreen));
}

Future<void> _openCartFromSettings(
  WidgetTester tester, {
  required String itemsLabel,
}) async {
  await tester.tap(find.byKey(const ValueKey(NavIcons.settings)));
  await waitForScreen(tester, SettingsScreen);
  final tag = find.bySemanticsLabel(itemsLabel);
  await waitFor(tester, tag);
  await tester.tap(tag);
  await waitForScreen(tester, CartScreen);
}

Future<void> _logOut(WidgetTester tester) async {
  await tester.tap(find.text('Log out'));
  final confirm = find.descendant(
    of: find.byType(AlertDialog),
    matching: find.text('Log out'),
  );
  await waitFor(tester, confirm);
  await tester.tap(confirm);
  await waitForScreen(tester, OnboardingScreen);
}

Future<void> _logIn(WidgetTester tester) async {
  await tester.tap(find.text('Log In'));
  await enterPhone(tester, _phone);
  await enterOtp(tester);
  await waitFor(tester, find.byType(HomeScreen));
}
