import 'package:intl/intl.dart';

/// [date] as a long date in [locale], such as `May 1, 1980`.
///
/// Digits stay Latin in every locale. Burmese would otherwise show ၁၉၈၀
/// beside prices, points and ages that `formatGrouped` keeps Latin.
String formatLongDate(DateTime date, String locale) =>
    (DateFormat.yMMMMd(locale)..useNativeDigits = false).format(date);
