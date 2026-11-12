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

  @override
  String get welcomeTitle => 'Welcome to the world of J\'donuts';

  @override
  String get onboardingTitle => 'Round food for every mood';

  @override
  String get getStarted => 'Let\'s get started';

  @override
  String get alreadyHaveAccount => 'Already have an account?';

  @override
  String get logIn => 'Log In';

  @override
  String get termsPrefix =>
      'By continuing, you acknowledge that you have read and agree to our';

  @override
  String get termsOfUse => 'Terms of Use';

  @override
  String get and => 'and';

  @override
  String get privacyPolicy => 'Privacy Policy';

  @override
  String get comingSoonTitle => 'Coming soon';

  @override
  String get close => 'Close';

  @override
  String get logOut => 'Log out';

  @override
  String get logOutConfirm => 'Log out of J\'Donuts?';

  @override
  String get cancel => 'Cancel';

  @override
  String get registrationComingSoon => 'Registration is on its way.';

  @override
  String continueWith(String provider) {
    return 'Continue with $provider';
  }

  @override
  String socialSignInUnavailable(String provider) {
    return '$provider sign-in isn\'t available in this demo';
  }

  @override
  String documentUnavailable(String document) {
    return 'The $document will be available here soon.';
  }

  @override
  String stepOf(int step, int total) {
    return 'Step $step of $total';
  }

  @override
  String get back => 'Back';
}
