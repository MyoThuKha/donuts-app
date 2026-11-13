import 'package:donuts/features/product/domain/product_rules.dart';
import 'package:donuts/features/product/domain/vo/product_detail_vo.dart';
import 'package:equatable/equatable.dart';

enum ProductLoadStatus { loading, ready, notFound, failed }

enum CartAddStatus { idle, adding, added, failed }

final class ProductDetailState extends Equatable {
  const new({
    this.status = ProductLoadStatus.loading,
    this.product,
    this.quantity = ProductRules.minQuantity,
    this.addStatus = CartAddStatus.idle,
    this.addedQuantity = 0,
  });

  final ProductLoadStatus status;

  /// Null while loading and once the catalog no longer has the product.
  final ProductDetailVO? product;
  final int quantity;
  final CartAddStatus addStatus;

  /// The quantity of the last add that succeeded, for its snackbar.
  final int addedQuantity;

  /// What [quantity] items cost, or null without a product.
  int? get total => product?.totalFor(quantity);

  ProductDetailState copyWith({
    int? quantity,
    CartAddStatus? addStatus,
    int? addedQuantity,
  }) => ProductDetailState(
    status: status,
    product: product,
    quantity: quantity ?? this.quantity,
    addStatus: addStatus ?? this.addStatus,
    addedQuantity: addedQuantity ?? this.addedQuantity,
  );

  @override
  List<Object?> get props => [
    status,
    product,
    quantity,
    addStatus,
    addedQuantity,
  ];
}
