// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'J\'Donuts';

  @override
  String get tabHome => 'Home';

  @override
  String get tabReward => 'Reward';

  @override
  String get tabExplore => 'Explore';

  @override
  String get tabWallet => 'Wallet';

  @override
  String get tabSettings => 'Settings';

  @override
  String placeholderComingSoon(String tab) {
    return '$tab is coming soon';
  }
}
