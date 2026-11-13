/// How a challenge draws its progress: a donut colouring in by quarters, or
/// an arc filling around a coffee cup.
enum ChallengeKind {
  donutQuarters,
  coffeeArc;

  /// The kind stored as [name], or null for a name this app doesn't know.
  static ChallengeKind? tryParse(String name) {
    for (final kind in values) {
      if (kind.name == name) return kind;
    }
    return null;
  }
}
