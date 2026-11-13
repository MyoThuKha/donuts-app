import 'package:donuts/core/result/app_failure.dart';
import 'package:donuts/core/result/result.dart';
import 'package:donuts/core/router/app_routes.dart';
import 'package:donuts/core/widgets/buttons/primary_button.dart';
import 'package:donuts/core/widgets/feedback/page_state_view.dart';
import 'package:donuts/features/auth/presentation/session/blocs/session_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mocktail/mocktail.dart';

import '../helpers/auth_flow.dart';
import '../helpers/fakes.dart';
import '../helpers/pump_app.dart';

/*
 The brief asks for portrait phones from 4.7 to 6.9 inches at text scale up
 to 1.3 without overflow. The 4.7-inch phone (375 by 667 points) is the
 tightest, so every screen and its error, sheet and dialog states are laid
 out there at 1.3, scrolled to the end, and checked for overflow errors.
 Rewards and the bottom nav have their own 1.3 tests.
*/

const Size _smallPhone = Size(375, 667);
const double _largeText = 1.3;
const String _phone = '09254135592';

final Finder _continue = find.byType(AppPrimaryButton);
final Finder _field = find.byType(TextField);

void main() {
  setUpAll(registerAuthFallbacks);

  late AuthFlowMocks mocks;

  setUp(() async {
    mocks = AuthFlowMocks();
    await mocks.install();
  });

  tearDown(() => FocusManager.instance.primaryFocus?.unfocus());

  group('sign-up and log-in at 1.3x text on a 4.7-inch phone', () {
    testWidgets('Onboarding and its placeholder sheet fit', (tester) async {
      await _pump(tester, AppRoutes.onboarding);

      await tester.tap(find.bySemanticsLabel('Continue with Google'));
      await tester.pumpAndSettle();
      _expectNoOverflow(tester);
    });

    testWidgets('Phone fits with its inline error', (tester) async {
      await _pump(tester, AppRoutes.registerPhone);

      await tester.enterText(_field, '0912');
      FocusManager.instance.primaryFocus?.unfocus();
      await tester.pumpAndSettle();
      expect(find.byType(TextField), findsOneWidget);
      _expectNoOverflow(tester);
    });

    testWidgets('Phone fits with the unregistered-number notice', (
      tester,
    ) async {
      when(() => mocks.requestOtp(any()))
          .thenAnswer((_) async => const Failure(NotRegisteredFailure()));
      await _pump(tester, AppRoutes.logInPhone);

      await _enterPhone(tester);
      expect(find.text('This number isn’t registered yet.'), findsOneWidget);
      _expectNoOverflow(tester);
    });

    testWidgets('OTP fits with the wrong-code and locked messages', (
      tester,
    ) async {
      when(() => mocks.verifyOtp(any()))
          .thenAnswer((_) async => const Failure(WrongOtpFailure()));
      await _pump(tester, AppRoutes.logInPhone);
      await _enterPhone(tester);

      for (var i = 0; i < 3; i++) {
        await tester.enterText(_field, '000000');
        await tester.pumpAndSettle();
        _expectNoOverflow(tester);
      }
      expect(
        find.text('Too many wrong codes. Tap Resend to get a new one.'),
        findsOneWidget,
      );
      await unmountApp(tester);
    });

    testWidgets('Name fits with both inline errors', (tester) async {
      await _pump(tester, AppRoutes.registerName);

      await tester.enterText(_field.at(0), '4');
      await tester.enterText(_field.at(1), '4');
      FocusManager.instance.primaryFocus?.unfocus();
      await tester.pumpAndSettle();
      _expectNoOverflow(tester);
    });

    testWidgets('Date of birth and its wheel sheet fit', (tester) async {
      await _pump(tester, AppRoutes.registerName);
      await tester.enterText(_field.first, 'Ye Min');
      await tester.pump();
      await tester.tap(_continue);
      await tester.pumpAndSettle();
      _expectNoOverflow(tester);

      await tester.tap(find.text('Month'));
      await tester.pumpAndSettle();
      _expectNoOverflow(tester);
    });

    testWidgets('Welcome fits', (tester) async {
      await _pump(
        tester,
        AppRoutes.welcome,
        session: testSessionCubit()..signedIn(testUser, justRegistered: true),
      );
      _expectNoOverflow(tester);
    });
  });

  group('signed in at 1.3x text on a 4.7-inch phone', () {
    testWidgets('Home fits from the header to the shops band', (tester) async {
      await _pumpSignedIn(tester, AppRoutes.home);
      await _scrollToEnd(tester);
    });

    testWidgets('Product detail fits, with its Add to cart bar', (
      tester,
    ) async {
      await _pumpSignedIn(tester, AppRoutes.productDetail(testCoconutId));
      expect(find.text('JD022123'), findsOneWidget);
      await _scrollToEnd(tester);
    });

    testWidgets('a full-page message fits, as on an unknown product', (
      tester,
    ) async {
      await _pumpSignedIn(tester, AppRoutes.productDetail('p_missing'));
      expect(find.byType(PageStateView), findsOneWidget);
      _expectNoOverflow(tester);
    });

    testWidgets('Settings and the Log out dialog fit', (tester) async {
      await _pumpSignedIn(tester, AppRoutes.settings);
      await _scrollToEnd(tester);

      await tester.tap(find.text('Log out'));
      await tester.pumpAndSettle();
      expect(find.text('Log out of J’Donuts?'), findsOneWidget);
      _expectNoOverflow(tester);
    });
  });
}

/// The Coconut Donut the product fakes serve.
const String testCoconutId = 'p_coconut';

Future<void> _pump(
  WidgetTester tester,
  String location, {
  SessionCubit? session,
}) async {
  _useSmallPhoneAtLargeText(tester);
  await pumpRouterApp(
    tester,
    session: session ?? testSessionCubit(),
    initialLocation: location,
  );
  _expectNoOverflow(tester);
}

Future<void> _pumpSignedIn(WidgetTester tester, String location) =>
    _pump(tester, location, session: testSessionCubit()..signedIn(testUser));

Future<void> _enterPhone(WidgetTester tester) async {
  await tester.enterText(_field, _phone);
  await tester.pump();
  await tester.tap(_continue);
  await tester.pumpAndSettle();
  _expectNoOverflow(tester);
}

void _useSmallPhoneAtLargeText(WidgetTester tester) {
  tester.view
    ..physicalSize = _smallPhone * 2
    ..devicePixelRatio = 2;
  tester.platformDispatcher.textScaleFactorTestValue = _largeText;
  addTearDown(tester.view.reset);
  addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
}

/// Jumps the page's vertical scroll view to its end until it stops
/// growing, so lazily built sections are laid out too, checking each step.
Future<void> _scrollToEnd(WidgetTester tester) async {
  final page = find.byWidgetPredicate(
    (widget) =>
        widget is Scrollable && widget.axisDirection == AxisDirection.down,
  );
  final position = tester.state<ScrollableState>(page.first).position;
  var end = -1.0;
  while (position.maxScrollExtent != end) {
    end = position.maxScrollExtent;
    position.jumpTo(end);
    await tester.pumpAndSettle();
    _expectNoOverflow(tester);
  }
}

/// A RenderFlex overflow surfaces as an exception after the frame.
void _expectNoOverflow(WidgetTester tester) =>
    expect(tester.takeException(), isNull);
