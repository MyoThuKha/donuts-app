import 'package:donuts/core/format/date_format.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  setUpAll(initializeDateFormatting);

  test('formats a long date in English', () {
    expect(formatLongDate(DateTime(1980, 5), 'en'), 'May 1, 1980');
  });

  test('keeps Latin digits in Burmese', () {
    final date = formatLongDate(DateTime(1995, 1, 15), 'my');

    expect(date, contains('1995'));
    expect(date, contains('15'));
    expect(date, isNot(contains('၁')));
  });
}
