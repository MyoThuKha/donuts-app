import 'package:donuts/core/database/daos/cart_dao.dart';
import 'package:donuts/core/result/guard.dart';
import 'package:donuts/core/result/result.dart';
import 'package:donuts/features/cart/domain/cart_rules.dart';
import 'package:donuts/features/cart/domain/repositories/cart_repository.dart';

class CartRepositoryImpl implements CartRepository {
  const new(this._dao, {required this._now});

  final CartDao _dao;
  final DateTime Function() _now;

  @override
  Future<Result<void>> add(String productId, int quantity) {
    RangeError.checkValueInInterval(
      quantity,
      CartRules.minQuantity,
      CartRules.maxQuantity,
      'quantity',
    );
    return guard(() => _dao.add(productId, quantity, at: _now()));
  }
}
