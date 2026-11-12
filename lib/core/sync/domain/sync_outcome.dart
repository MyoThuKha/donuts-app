/// What a catalog refresh did to the stored data.
enum SyncOutcome {
  /// The remote catalog was newer, and the stored catalog now matches it.
  updated,

  /// The stored catalog was already at this version or newer.
  upToDate,
}
