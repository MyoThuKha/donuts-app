import 'package:donuts/core/l10n/generated/app_localizations.dart';
import 'package:flutter/widgets.dart';

/// The languages the member can pick in Settings. [system] follows the
/// device.
enum AppLanguage {
  system(null),
  english(Locale('en')),
  burmese(Locale('my'));

  new(this.locale);

  /// The locale to force, or null to follow the device.
  final Locale? locale;

  /// The stored code, such as `my`, or null for [system].
  String? get code => locale?.languageCode;

  /// English and Burmese name themselves in their own script, so a member
  /// who can't read the current language still finds theirs.
  String label(AppLocalizations l10n) => switch (this) {
    system => l10n.languageSystem,
    english => l10n.languageEnglish,
    burmese => l10n.languageBurmese,
  };

  /// The language stored as [code], or [system] for null or an unknown code.
  static AppLanguage fromCode(String? code) => values.firstWhere(
    (language) => language.code != null && language.code == code,
    orElse: () => system,
  );
}
