/// Limits on how many of one product the cart can hold, and a single add
/// can put in it.
abstract final class CartRules {
  static const int minQuantity = 1;
  static const int maxQuantity = 99;
}
