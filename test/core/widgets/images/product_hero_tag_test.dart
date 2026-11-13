import 'package:donuts/core/widgets/images/product_hero_tag.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('productHeroTag scopes by section and falls back without one', () {
    expect(productHeroTag('p_dalgona'), 'product-image-p_dalgona');
    expect(
      productHeroTag('p_dalgona', scope: 'popular'),
      'product-image-popular-p_dalgona',
    );
    expect(
      productHeroTag('p_dalgona', scope: 'popular'),
      isNot(productHeroTag('p_dalgona', scope: 'order_again')),
    );
  });
}
