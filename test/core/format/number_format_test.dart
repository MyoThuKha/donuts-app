import 'package:donuts/core/format/number_format.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('formatGrouped puts thousands separators in', () {
    expect(formatGrouped(3200), '3,200');
    expect(formatGrouped(680000), '680,000');
    expect(formatGrouped(0), '0');
  });
}
