import 'package:donuts/core/l10n/generated/app_localizations.dart';
import 'package:material_ui/material_ui.dart';

export 'package:donuts/core/l10n/generated/app_localizations.dart';

/// The app's strings plus Material, Cupertino and widgets localisations.
///
/// Use this, not `AppLocalizations.localizationsDelegates`. gen-l10n still
/// pulls the Material and Cupertino delegates from `flutter_localizations`,
/// which serve the framework's old types. `material_ui` reads its own, so
/// those delegates never apply and any locale but English throws.
const List<LocalizationsDelegate<dynamic>> appLocalizationsDelegates = [
  AppLocalizations.delegate,
  ...GlobalMaterialLocalizations.delegates,
];

extension L10nContext on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);
}
