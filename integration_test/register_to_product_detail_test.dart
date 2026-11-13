import 'package:cupertino_ui/cupertino_ui.dart';
import 'package:donuts/app/app.dart';
import 'package:donuts/app/bootstrap.dart';
import 'package:donuts/app/di/di.dart';
import 'package:donuts/core/database/app_database.dart';
import 'package:donuts/core/di/locator.dart';
import 'package:donuts/core/widgets/buttons/primary_button.dart';
import 'package:donuts/features/auth/presentation/dob/dob_screen.dart';
import 'package:donuts/features/auth/presentation/name/name_screen.dart';
import 'package:donuts/features/auth/presentation/onboarding/onboarding_screen.dart';
import 'package:donuts/features/auth/presentation/otp/otp_screen.dart';
import 'package:donuts/features/auth/presentation/phone/phone_screen.dart';
import 'package:donuts/features/auth/presentation/welcome/welcome_screen.dart';
import 'package:donuts/features/home/presentation/home_screen.dart';
import 'package:donuts/features/product/presentation/product_detail_screen.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:material_ui/material_ui.dart';

import '../test/helpers/fake_connectivity.dart';
import '../test/helpers/fake_language_store.dart';
import '../test/helpers/memory_session_store.dart';

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
const String _otp = '123456';
const String _productName = 'Coconut Donut';

/// Real frames take real time here, so waits poll instead of settling once.
const Duration _pollStep = Duration(milliseconds: 100);
const Duration _waitLimit = Duration(seconds: 15);

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('a new user registers, reaches Home and opens a product', (
    tester,
  ) async {
    final sessionStore = MemorySessionStore();
    await _startApp(tester, sessionStore);

    await _tapPrimary(tester, OnboardingScreen);
    await _enterPhone(tester);
    await _enterOtp(tester);
    await _enterName(tester);
    await _pickDateOfBirth(tester, DateTime(1995, 6, 15));

    await _waitForScreen(tester, WelcomeScreen);
    expect(sessionStore.userId, isNotNull);
    await _tapPrimary(tester, WelcomeScreen);

    await _waitFor(tester, find.byType(HomeScreen));
    await _openProduct(tester, _productName);

    await _waitForScreen(tester, ProductDetailScreen);
    for (final text in ['JD022123', _productName, 'What’s this?']) {
      expect(_inside(ProductDetailScreen, find.text(text)), findsOneWidget);
    }
    // The unit price, and the Add to cart total for one.
    expect(_inside(ProductDetailScreen, find.text('3,200 MMK')), findsWidgets);

    await tester.tap(find.byIcon(LucideIcons.plus));
    await _waitFor(
      tester,
      _inside(ProductDetailScreen, find.text('6,400 MMK')),
    );
  });
}

Future<void> _startApp(
  WidgetTester tester,
  MemorySessionStore sessionStore,
) async {
  await configureDependencies(
    database: AppDatabase.forTesting(NativeDatabase.memory()),
    sessionStore: sessionStore,
    // The finders read English text, whatever language the device uses or
    // the app last saved.
    languageStore: FakeLanguageStore('en'),
    connectivitySource: FakeConnectivitySource(),
    probe: FakeReachabilityProbe(reachable: false),
  );
  addTearDown(getIt.reset);
  await bootstrap();
  await tester.pumpWidget(const DonutsApp());
}

Future<void> _enterPhone(WidgetTester tester) async {
  await _waitForScreen(tester, PhoneScreen);
  await tester.enterText(_fieldsOf(PhoneScreen), _phone);
  await _tapPrimary(tester, PhoneScreen);
}

/// The code verifies itself once the sixth digit is in.
Future<void> _enterOtp(WidgetTester tester) async {
  await _waitForScreen(tester, OtpScreen);
  await tester.enterText(_fieldsOf(OtpScreen), _otp);
}

Future<void> _enterName(WidgetTester tester) async {
  await _waitForScreen(tester, NameScreen);
  await tester.enterText(_fieldsOf(NameScreen).at(0), 'Ye Min');
  await tester.enterText(_fieldsOf(NameScreen).at(1), 'Phyoe Win');
  await _tapPrimary(tester, NameScreen);
}

/// Opens the wheel from the Month field, turns it to [date] through the
/// picker's own callback and confirms.
Future<void> _pickDateOfBirth(WidgetTester tester, DateTime date) async {
  await _waitForScreen(tester, DobScreen);
  await tester.tap(find.text('Month'));
  final picker = find.byType(CupertinoDatePicker);
  await _waitForArrival(tester, picker);
  tester.widget<CupertinoDatePicker>(picker).onDateTimeChanged(date);
  await tester.tap(find.text('SELECT'));
  await _tapPrimary(tester, DobScreen);
}

/// Scrolls the tile named [name] into view and taps it.
Future<void> _openProduct(WidgetTester tester, String name) async {
  final tile = find.text(name);
  await _waitFor(tester, tile);
  await tester.ensureVisible(tile);
  await tester.pump(_pollStep);
  await tester.tap(tile);
}

Finder _inside(Type screen, Finder finder) =>
    find.descendant(of: find.byType(screen), matching: finder);

Finder _fieldsOf(Type screen) => _inside(screen, find.byType(TextField));

/// Waits until [screen]'s primary button is enabled, then taps it.
Future<void> _tapPrimary(WidgetTester tester, Type screen) async {
  final enabled = _inside(
    screen,
    find.byWidgetPredicate(
      (widget) => widget is AppPrimaryButton && widget.onPressed != null,
    ),
  );
  await _waitFor(tester, enabled);
  await tester.tap(enabled);
  await tester.pump(_pollStep);
}

Future<void> _waitForScreen(WidgetTester tester, Type screen) =>
    _waitForArrival(tester, find.byType(screen));

/// Waits until [finder] matches and the route holding it has finished
/// arriving, so taps reach it instead of the transition.
Future<void> _waitForArrival(WidgetTester tester, Finder finder) async {
  await _waitFor(tester, finder);
  await _waitUntil(
    tester,
    () => ModalRoute.of(tester.element(finder))!.animation!.isCompleted,
    'the route of ${finder.describeMatch(Plurality.one)} to arrive',
  );
}

Future<void> _waitFor(WidgetTester tester, Finder finder) => _waitUntil(
  tester,
  () => finder.evaluate().isNotEmpty,
  finder.describeMatch(Plurality.zero),
);

/// Pumps frames until [done] is true, or fails after [_waitLimit].
Future<void> _waitUntil(
  WidgetTester tester,
  bool Function() done,
  String what,
) async {
  final end = DateTime.now().add(_waitLimit);
  while (DateTime.now().isBefore(end)) {
    await tester.pump(_pollStep);
    if (done()) return;
  }
  fail('Timed out waiting for $what');
}
