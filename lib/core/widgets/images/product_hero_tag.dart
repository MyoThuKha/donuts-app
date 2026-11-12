/// The Hero tag for a product's image.
///
/// One product can sit in two Home rows, and two Heroes with one tag on a
/// screen throw, so Home passes the row id as [scope] and hands the same
/// tag to Product detail. A deep link has no row and uses the plain tag.
Object productHeroTag(String productId, {String? scope}) => scope == null
    ? 'product-image-$productId'
    : 'product-image-$scope-$productId';
