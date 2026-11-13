import 'dart:async';

import 'package:material_ui/material_ui.dart';

/// Holds the app's first frame behind the launch screen until the images
/// that frame asks for have decoded, and tells entrance animations when
/// it is on screen.
///
/// On a cold start Home asks for about twenty images at once: each
/// product's bundled asset and its cached download, plus the tier
/// backdrop. Decoding and uploading them while the first frames rasterize
/// held the raster thread for 100 to 250 ms on a mid-range Android phone.
/// Entrance animations had already started, so they jumped ahead when the
/// frames came through. With the frame held, the images decode while
/// nothing is drawn, and entrances start once the first frame is shown.
///
/// `main` calls [hold] before `runApp` and [release] after it. Without
/// [hold], as in widget tests, [isShown] is true and [shown] has completed.
abstract final class FirstFrame {
  static Completer<void>? _shown;

  /// Longest the launch screen stays up waiting for images, such as a
  /// download that isn't cached yet.
  static const Duration maxHold = Duration(milliseconds: 800);

  /// How often [release] checks the image cache.
  static const Duration _poll = Duration(milliseconds: 16);

  /// Checks in a row with nothing left to decode before the frame goes
  /// out. More than one, because a screen's data can arrive a frame after
  /// its first images and ask for more.
  static const int _quietChecks = 3;

  /// Whether the first frame is on screen, or was never held.
  static bool get isShown => _shown?.isCompleted ?? true;

  /// Completes once the first frame is on screen.
  static Future<void> get shown => _shown?.future ?? Future<void>.value();

  /// Keeps the first frame off screen until [release].
  static void hold() {
    if (_shown != null) return;
    _shown = Completer<void>();
    WidgetsBinding.instance.deferFirstFrame();
  }

  /// Stands in for [hold] in widget tests, which can't defer a frame.
  /// [shown] completes when the returned completer does.
  @visibleForTesting
  static Completer<void> debugHold() => _shown = Completer<void>();

  /// Undoes [debugHold].
  @visibleForTesting
  static void debugReset() => _shown = null;

  /// Lets the first frame out once the images the app asked for have
  /// decoded, or after [maxHold], then completes [shown] when it has been
  /// rasterized.
  static Future<void> release() async {
    final shown = _shown;
    if (shown == null || shown.isCompleted) return;
    final binding = WidgetsBinding.instance;
    final cache = PaintingBinding.instance.imageCache;
    final clock = Stopwatch()..start();
    var quiet = 0;
    while (quiet < _quietChecks && clock.elapsed < maxHold) {
      await Future<void>.delayed(_poll);
      final asked = cache.currentSize + cache.pendingImageCount > 0;
      quiet = asked && cache.pendingImageCount == 0 ? quiet + 1 : 0;
    }
    binding.allowFirstFrame();
    await binding.waitUntilFirstFrameRasterized;
    shown.complete();
  }
}
