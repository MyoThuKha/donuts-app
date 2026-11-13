import 'package:cupertino_ui/cupertino_ui.dart';
import 'package:donuts/core/l10n/l10n.dart';
import 'package:donuts/core/theme/app_dimens.dart';
import 'package:donuts/core/theme/theme_context.dart';
import 'package:donuts/core/widgets/buttons/primary_button.dart';
import 'package:donuts/core/widgets/sheets/sheet_extension.dart';
import 'package:material_ui/material_ui.dart';

/// Opens a sheet with month, day and year wheels, limited to [earliest]
/// through [latest]. Completes with the date chosen when Select is tapped,
/// or `null` when the sheet closes without a choice.
///
/// The wheels order the columns and name the months for the current
/// locale. [initial] outside the limits starts at the nearest limit.
Future<DateTime?> showDateWheelSheet(
  BuildContext context, {
  required String title,
  required DateTime initial,
  required DateTime earliest,
  required DateTime latest,
}) {
  final first = _dateOnly(earliest);
  final last = _dateOnly(latest);
  final start = _dateOnly(initial);
  return _DateWheelSheet(
    initial: start.isBefore(first)
        ? first
        : (start.isAfter(last) ? last : start),
    earliest: first,
    latest: last,
  ).sheet<DateTime>(context, title: title);
}

DateTime _dateOnly(DateTime date) => DateTime(date.year, date.month, date.day);

class _DateWheelSheet extends StatefulWidget {
  const new({
    required this.initial,
    required this.earliest,
    required this.latest,
  });

  final DateTime initial;
  final DateTime earliest;
  final DateTime latest;

  @override
  State<_DateWheelSheet> createState() => _DateWheelSheetState();
}

class _DateWheelSheetState extends State<_DateWheelSheet> {
  /// The height of the iOS date wheel: five rows, the middle one selected.
  static const double _wheelHeight = 216;

  late DateTime _date = widget.initial;

  @override
  Widget build(BuildContext context) {
    // The sheet route adds the title, close button, padding and safe area.
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: AppSpacing.xxl,
      children: [
        SizedBox(
          height: _wheelHeight,
          child: CupertinoTheme(
            data: CupertinoThemeData(
              brightness: Theme.of(context).brightness,
              textTheme: CupertinoTextThemeData(
                dateTimePickerTextStyle: context.text.body.copyWith(
                  color: context.colors.ink,
                ),
              ),
            ),
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              initialDateTime: widget.initial,
              minimumDate: widget.earliest,
              maximumDate: widget.latest,
              onDateTimeChanged: (date) => _date = _dateOnly(date),
            ),
          ),
        ),
        AppPrimaryButton(
          label: context.l10n.select,
          onPressed: () => Navigator.of(context).pop(_date),
        ),
      ],
    );
  }
}
