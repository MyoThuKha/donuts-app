import 'dart:async';

/// The challenges claimed with Earn in this run of the app, with the points
/// each one paid. It lives in memory only: a refresh or a restart clears
/// it, and the database never sees it.
class RewardClaimsMemorySource {
  Map<String, int> _claims = const {};
  final Set<StreamController<Map<String, int>>> _listeners = {};

  /// Claimed challenge ids and their points. Emits the current claims on
  /// listen, then every change.
  Stream<Map<String, int>> watch() {
    late final StreamController<Map<String, int>> controller;
    controller = StreamController(
      onListen: () {
        controller.add(_claims);
        _listeners.add(controller);
      },
      onCancel: () => _listeners.remove(controller),
    );
    return controller.stream;
  }

  bool isClaimed(String challengeId) => _claims.containsKey(challengeId);

  void claim(String challengeId, int points) =>
      _set({..._claims, challengeId: points});

  void clear() => _set(const {});

  void _set(Map<String, int> claims) {
    _claims = Map.unmodifiable(claims);
    for (final listener in [..._listeners]) {
      listener.add(_claims);
    }
  }
}
