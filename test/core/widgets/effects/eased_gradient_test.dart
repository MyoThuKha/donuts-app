import 'package:donuts/core/widgets/effects/eased_gradient.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

void main() {
  const top = Color(0xFFFF0000);
  const bottom = Color(0xFF0000FF);

  test('keeps the key colours at their stops, in order', () {
    final gradient = easedVerticalGradient([(0, top), (1, bottom)]);
    final stops = gradient.stops!;

    expect(gradient.colors.first, top);
    expect(gradient.colors.last, bottom);
    expect(stops.first, 0);
    expect(stops.last, 1);
    for (var i = 1; i < stops.length; i++) {
      expect(stops[i], greaterThan(stops[i - 1]));
    }
  });

  test('changes colour slowly next to a key and fastest between keys', () {
    final colors = easedVerticalGradient([(0, top), (1, bottom)]).colors;
    double step(int i) => (colors[i + 1].b - colors[i].b).abs();

    final middle = colors.length ~/ 2;
    expect(step(0), lessThan(step(middle - 1)));
    expect(step(colors.length - 2), lessThan(step(middle - 1)));
  });
}
