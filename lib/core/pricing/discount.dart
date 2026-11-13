/// [priceMmk] after a [discountPercent] off, rounded down to the kyat. No
/// discount leaves the price as it is.
int discountedPrice(int priceMmk, int? discountPercent) =>
    priceMmk * (100 - (discountPercent ?? 0)) ~/ 100;
