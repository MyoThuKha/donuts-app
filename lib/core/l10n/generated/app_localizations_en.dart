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

  @override
  String get phoneTitle => 'Enter your phone number';

  @override
  String get phoneHint => '09xxxxxxxxx';

  @override
  String get phoneInvalid =>
      'Enter a Myanmar mobile number, like 09 254 135 592';

  @override
  String get notRegistered => 'This number isn\'t registered yet.';

  @override
  String get registerInstead => 'Register instead';

  @override
  String get alreadyRegistered => 'This number is already registered.';

  @override
  String get logInInstead => 'Log in instead';

  @override
  String get genericError => 'Something went wrong. Try again.';

  @override
  String get continueLabel => 'Continue';

  @override
  String get otpTitle => 'Verify your number';

  @override
  String get otpWrong => 'That code isn\'t right. Try again.';

  @override
  String get otpLocked => 'Too many wrong codes. Tap Resend to get a new one.';

  @override
  String get didntReceive => 'Didn\'t receive the code?';

  @override
  String get resend => 'Resend';

  @override
  String get firstNameRequired => 'Enter your first name';

  @override
  String get nameInvalid => 'Use letters and spaces only';

  @override
  String get dobInvalid => 'That date doesn\'t exist';

  @override
  String get dobFuture => 'Date of birth can\'t be in the future';

  @override
  String otpSent(String phone) {
    return 'We\'ve sent a 6 digit OTP to $phone';
  }

  @override
  String resendIn(String time) {
    return 'resend in $time min';
  }

  @override
  String nameTooLong(int max) {
    return 'Use $max characters or fewer';
  }

  @override
  String dobTooYoung(int age) {
    return 'You need to be at least $age to join';
  }

  @override
  String get nameTitle => 'What\'s your name?';

  @override
  String get firstNameHint => 'First Name';

  @override
  String get lastNameHint => 'Last Name';

  @override
  String get dobTitle => 'What\'s your date of birth?';

  @override
  String get monthHint => 'Month';

  @override
  String get dayHint => 'Day';

  @override
  String get yearHint => 'Year';

  @override
  String get letsExplore => 'Let\'s explore';

  @override
  String get imageUnavailable => 'Image unavailable';
}
