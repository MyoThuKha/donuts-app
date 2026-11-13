import 'package:donuts/core/database/daos/cart_dao.dart';
import 'package:donuts/core/pricing/discount.dart';
import 'package:donuts/features/cart/domain/vo/cart_item_vo.dart';
import 'package:donuts/features/cart/domain/vo/cart_vo.dart';

extension CartLineRowMapper on CartLineRow {
  CartItemVO toVO() => CartItemVO(
    productId: product.id,
    name: product.name,
    unitPriceMmk: discountedPrice(product.priceMmk, product.discountPercent),
    quantity: item.quantity,
    imageUrl: product.imageUrl,
    imageAsset: product.imageAsset,
  );
}

extension CartLineRowsMapper on List<CartLineRow> {
  CartVO toVO() => CartVO(items: [for (final line in this) line.toVO()]);
}
