import 'package:donuts/core/l10n/generated/app_localizations.dart';
import 'package:material_ui/material_ui.dart';

export 'package:donuts/core/l10n/generated/app_localizations.dart';

extension L10nContext on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);
}
