import 'package:donuts/core/pricing/discount.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('no discount leaves the price as it is', () {
    expect(discountedPrice(3200, null), 3200);
    expect(discountedPrice(3200, 0), 3200);
  });

  test('a discount rounds down to the kyat', () {
    expect(discountedPrice(3200, 20), 2560);
    expect(discountedPrice(2999, 50), 1499);
  });
}
