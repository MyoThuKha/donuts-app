import 'package:donuts/features/product/domain/vo/product_detail_vo.dart';
import 'package:flutter_test/flutter_test.dart';

ProductDetailVO _product({int priceMmk = 3200, int? discountPercent}) =>
    ProductDetailVO(
      id: 'p_coconut',
      code: 'JD022123',
      name: 'Coconut Donut',
      priceMmk: priceMmk,
      isNew: true,
      discountPercent: discountPercent,
      description: 'A donut.',
      imageUrl: 'https://example.com/coconut.webp',
    );

void main() {
  test('without a discount the unit price is the list price', () {
    expect(_product().unitPriceMmk, 3200);
  });

  test('a 50% discount halves the unit price, rounded down', () {
    expect(_product(priceMmk: 3201, discountPercent: 50).unitPriceMmk, 1600);
  });

  test('totalFor multiplies the unit price by the quantity', () {
    expect(_product().totalFor(3), 9600);
    expect(_product(discountPercent: 25).totalFor(2), 4800);
  });
}
