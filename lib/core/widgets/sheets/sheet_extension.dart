import 'package:donuts/core/motion/app_motion.dart';
import 'package:donuts/core/widgets/sheets/app_sheet_route.dart';
import 'package:material_ui/material_ui.dart';

/// Opens any widget as the app's bottom sheet:
///
/// ```dart
/// await const ProfileDetailView().sheet(context, title: 'Profile Detail');
/// ```
extension SheetWidget on Widget {
  /// Builds the route without pushing it, for callers that push routes
  /// themselves.
  AppSheetRoute<T> asSheetRoute<T>(BuildContext context, {String? title}) =>
      AppSheetRoute<T>(
        child: this,
        title: title,
        reduced: context.motion.reduced,
      );

  /// Pushes this widget as a sheet and completes with the value it pops.
  ///
  /// It goes on the root navigator, so it covers the bottom nav too.
  Future<T?> sheet<T>(BuildContext context, {String? title}) => Navigator.of(
    context,
    rootNavigator: true,
  ).push(asSheetRoute<T>(context, title: title));
}
