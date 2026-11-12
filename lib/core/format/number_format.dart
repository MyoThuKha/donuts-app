import 'package:intl/intl.dart';

final NumberFormat _grouped = NumberFormat('#,##0', 'en');

/// A whole number with thousands separators: `3,200`, `680,000`.
String formatGrouped(int value) => _grouped.format(value);
