import 'package:cupertino_ui/cupertino_ui.dart';
import 'package:donuts/core/widgets/inputs/date_wheel_sheet.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

import '../../../helpers/pump_app.dart';

final _earliest = DateTime(1906, 11, 12);
final _latest = DateTime(2013, 11, 12);

/// Pumps a button that opens the sheet from [initial] and records what it
/// returns in [results].
Future<void> _pumpOpener(
  WidgetTester tester, {
  required DateTime initial,
  required List<DateTime?> results,
}) => pumpThemed(
  tester,
  Builder(
    builder: (context) => TextButton(
      onPressed: () async => results.add(
        await showDateWheelSheet(
          context,
          title: 'Select your birthday',
          initial: initial,
          earliest: _earliest,
          latest: _latest,
        ),
      ),
      child: const Text('Open'),
    ),
  ),
);

CupertinoDatePicker _picker(WidgetTester tester) =>
    tester.widget<CupertinoDatePicker>(find.byType(CupertinoDatePicker));

void main() {
  testWidgets('Select returns the date turned to on the wheels', (
    tester,
  ) async {
    final results = <DateTime?>[];
    await _pumpOpener(tester, initial: DateTime(1990, 6, 15), results: results);
    await tester.tap(find.text('Open'));
    await tester.pumpAndSettle();

    expect(find.text('Select your birthday'), findsOneWidget);
    _picker(tester).onDateTimeChanged(DateTime(1980, 5, 1, 9, 30));
    await tester.tap(find.text('SELECT'));
    await tester.pumpAndSettle();

    expect(results, [DateTime(1980, 5)]);
  });

  testWidgets('closing the sheet returns nothing', (tester) async {
    final results = <DateTime?>[];
    await _pumpOpener(tester, initial: DateTime(1990, 6, 15), results: results);
    await tester.tap(find.text('Open'));
    await tester.pumpAndSettle();

    await tester.tap(find.byTooltip('Close'));
    await tester.pumpAndSettle();

    expect(results, [null]);
  });

  testWidgets('the wheels stop at the limits and start inside them', (
    tester,
  ) async {
    await _pumpOpener(tester, initial: DateTime(2026, 11, 13), results: []);
    await tester.tap(find.text('Open'));
    await tester.pumpAndSettle();

    final picker = _picker(tester);
    expect(picker.minimumDate, _earliest);
    expect(picker.maximumDate, _latest);
    expect(picker.initialDateTime, _latest);
  });
}
