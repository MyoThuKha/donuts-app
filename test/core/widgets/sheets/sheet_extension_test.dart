import 'package:donuts/core/widgets/sheets/app_sheet_route.dart';
import 'package:donuts/core/widgets/sheets/sheet_extension.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

import '../../../helpers/pump_app.dart';

const _body = SizedBox(height: 300, child: Text('Sheet body'));

Future<void> _pumpOpener(WidgetTester tester) => pumpThemed(
  tester,
  Builder(
    builder: (context) => TextButton(
      onPressed: () => _body.sheet<void>(context, title: 'Profile Detail'),
      child: const Text('Open'),
    ),
  ),
);

void main() {
  testWidgets('.sheet() slides the widget up with its title', (tester) async {
    await _pumpOpener(tester);

    await tester.tap(find.text('Open'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));
    final midway = tester.getTopLeft(find.text('Sheet body')).dy;
    await tester.pumpAndSettle();

    expect(find.text('Profile Detail'), findsOneWidget);
    expect(tester.getTopLeft(find.text('Sheet body')).dy, lessThan(midway));
  });

  testWidgets('the close button dismisses the sheet', (tester) async {
    await _pumpOpener(tester);
    await tester.tap(find.text('Open'));
    await tester.pumpAndSettle();

    await tester.tap(find.byTooltip('Close'));
    await tester.pumpAndSettle();

    expect(find.byType(AppSheetRoute<void>), findsNothing);
    expect(find.text('Sheet body'), findsNothing);
  });

  testWidgets('a short drag snaps back, a long one closes', (tester) async {
    await _pumpOpener(tester);
    await tester.tap(find.text('Open'));
    await tester.pumpAndSettle();
    final resting = tester.getTopLeft(find.text('Sheet body')).dy;

    await tester.drag(find.text('Sheet body'), const Offset(0, 40));
    await tester.pumpAndSettle();
    expect(tester.getTopLeft(find.text('Sheet body')).dy, resting);

    await tester.drag(find.text('Sheet body'), const Offset(0, 400));
    await tester.pumpAndSettle();
    expect(find.text('Sheet body'), findsNothing);
  });

  testWidgets('under Reduce Motion the sheet appears at once', (tester) async {
    tester.platformDispatcher.accessibilityFeaturesTestValue =
        const FakeAccessibilityFeatures(disableAnimations: true);
    addTearDown(tester.platformDispatcher.clearAccessibilityFeaturesTestValue);
    await _pumpOpener(tester);

    await tester.tap(find.text('Open'));
    await tester.pump();
    await tester.pump();
    final firstFrame = tester.getTopLeft(find.text('Sheet body')).dy;
    await tester.pumpAndSettle();

    expect(tester.getTopLeft(find.text('Sheet body')).dy, firstFrame);
  });
}
