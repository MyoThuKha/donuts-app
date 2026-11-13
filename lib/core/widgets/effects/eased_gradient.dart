import 'package:material_ui/material_ui.dart';

/// Extra stops placed between each pair of key colours.
const int _samplesPerSpan = 8;

/// A vertical [LinearGradient] that eases between [keys], each a stop
/// (0 to 1) and its colour.
///
/// A plain gradient changes colour at a constant rate and then switches
/// rate at each stop. The eye reads that switch as a line across the
/// screen. Easing each span with [Curves.easeInOut] brings the rate of
/// change to zero at every key, so no stop shows as an edge.
LinearGradient easedVerticalGradient(List<(double, Color)> keys) {
  assert(keys.length >= 2, 'A gradient needs at least two keys');
  final colors = <Color>[];
  final stops = <double>[];
  for (var i = 0; i < keys.length - 1; i++) {
    final (fromStop, fromColor) = keys[i];
    final (toStop, toColor) = keys[i + 1];
    for (var j = 0; j < _samplesPerSpan; j++) {
      final t = j / _samplesPerSpan;
      stops.add(fromStop + (toStop - fromStop) * t);
      colors.add(
        Color.lerp(fromColor, toColor, Curves.easeInOut.transform(t))!,
      );
    }
  }
  final (lastStop, lastColor) = keys.last;
  stops.add(lastStop);
  colors.add(lastColor);
  return LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: colors,
    stops: stops,
  );
}
