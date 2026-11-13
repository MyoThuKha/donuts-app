import 'package:material_ui/material_ui.dart';

/// The app's snackbar. Every screen shows messages through here, so their
/// look can change in one place.
///
/// It floats: a fixed snackbar slides out from under the bottom nav, which
/// the Scaffold paints on top of it.
SnackBar appSnackBar(String message) =>
    SnackBar(content: Text(message), behavior: SnackBarBehavior.floating);

/// Shows the app's snackbar on a messenger the caller already holds, such
/// as one read before an `await`.
extension AppSnackBarMessenger on ScaffoldMessengerState {
  /// Shows [message], replacing any snackbar already on screen.
  void showMessage(String message) => this
    ..hideCurrentSnackBar()
    ..showSnackBar(appSnackBar(message));
}

/// Shows the app's snackbar from a widget's context.
extension AppSnackBarContext on BuildContext {
  /// Shows [message], replacing any snackbar already on screen.
  void showMessage(String message) =>
      ScaffoldMessenger.of(this).showMessage(message);
}
