import 'package:donuts/features/cart/domain/usecases/remove_from_cart_use_case.dart';
import 'package:donuts/features/cart/domain/usecases/set_cart_quantity_use_case.dart';
import 'package:donuts/features/cart/domain/usecases/watch_cart_count_use_case.dart';
import 'package:donuts/features/cart/domain/usecases/watch_cart_use_case.dart';
import 'package:donuts/features/cart/domain/vo/cart_item_vo.dart';
import 'package:donuts/features/cart/domain/vo/cart_vo.dart';
import 'package:mocktail/mocktail.dart';

class MockWatchCartUseCase extends Mock implements WatchCartUseCase;

class MockWatchCartCountUseCase extends Mock implements WatchCartCountUseCase;

class MockSetCartQuantityUseCase extends Mock implements SetCartQuantityUseCase;

class MockRemoveFromCartUseCase extends Mock implements RemoveFromCartUseCase;

const CartItemVO testCoconutLine = CartItemVO(
  productId: 'p_coconut',
  name: 'Coconut Donut',
  unitPriceMmk: 3200,
  quantity: 2,
  imageUrl: 'https://example.com/coconut.webp',
);

const CartItemVO testBerryLine = CartItemVO(
  productId: 'p_berry',
  name: 'Strawberry Donut',
  unitPriceMmk: 2500,
  quantity: 1,
  imageUrl: 'https://example.com/berry.webp',
);

/// Coconut (2 × 3,200) then Strawberry (1 × 2,500): 8,900 MMK.
const CartVO testCart = CartVO(items: [testCoconutLine, testBerryLine]);

/// [testCart] with [productId]'s quantity set to [quantity].
CartVO cartWith(String productId, int quantity) => CartVO(
  items: [
    for (final item in testCart.items)
      if (item.productId == productId)
        item.copyWith(quantity: quantity)
      else
        item,
  ],
);
