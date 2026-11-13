import 'package:donuts/core/database/daos/cart_dao.dart';
import 'package:donuts/core/result/guard.dart';
import 'package:donuts/core/result/result.dart';
import 'package:donuts/features/cart/data/mapper/cart_db_mapper.dart';
import 'package:donuts/features/cart/domain/cart_rules.dart';
import 'package:donuts/features/cart/domain/repositories/cart_repository.dart';
import 'package:donuts/features/cart/domain/vo/cart_vo.dart';

class CartRepositoryImpl implements CartRepository {
  const new(this._dao, {required this._now});

  final CartDao _dao;
  final DateTime Function() _now;

  @override
  Stream<CartVO> watchCart() =>
      _dao.watchLines().map((lines) => lines.toVO()).guarded();

  @override
  Stream<int> watchCount() => _dao.watchTotalQuantity().guarded();

  @override
  Future<Result<void>> add(String productId, int quantity) {
    _checkQuantity(quantity);
    return guard(
      () =>
          _dao.add(productId, quantity, at: _now(), cap: CartRules.maxQuantity),
    );
  }

  @override
  Future<Result<void>> setQuantity(String productId, int quantity) {
    _checkQuantity(quantity);
    return guard(() => _dao.setQuantity(productId, quantity, at: _now()));
  }

  @override
  Future<Result<void>> remove(String productId) =>
      guard(() => _dao.remove(productId));

  @override
  Future<Result<void>> clear() => guard(_dao.clear);

  static void _checkQuantity(int quantity) => RangeError.checkValueInInterval(
    quantity,
    CartRules.minQuantity,
    CartRules.maxQuantity,
    'quantity',
  );
}
