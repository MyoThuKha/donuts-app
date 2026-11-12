/// A catalog that parsed but contradicts itself: a repeated id, or a
/// section that names a product the catalog doesn't have.
///
/// It extends [FormatException], so `guard` reports it as a `ParsingFailure`.
class CatalogIntegrityException extends FormatException {
  const new(super.message);
}
