/// Limits on how many of one product a single add can put in the cart.
abstract final class ProductRules {
  static const int minQuantity = 1;
  static const int maxQuantity = 99;
}
