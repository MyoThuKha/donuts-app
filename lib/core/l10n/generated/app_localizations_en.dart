// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'J’Donuts';

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
  String get welcomeTitle => 'Welcome to the world of J’donuts';

  @override
  String get onboardingTitle => 'Round food for every mood';

  @override
  String get getStarted => 'Let’s get started';

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
  String get termsSuffix => '.';

  @override
  String get comingSoonTitle => 'Coming soon';

  @override
  String get featureComingSoon => 'This feature is coming soon.';

  @override
  String get close => 'Close';

  @override
  String get logOut => 'Log out';

  @override
  String get logOutConfirm => 'Log out of J’Donuts?';

  @override
  String get logOutFailed => 'Couldn’t log out. Try again.';

  @override
  String get cancel => 'Cancel';

  @override
  String get accountDateOfBirth => 'Date of birth';

  @override
  String get accountAge => 'Age';

  @override
  String accountAgeYears(int years) {
    String _temp0 = intl.Intl.pluralLogic(
      years,
      locale: localeName,
      other: '$years years',
      one: '1 year',
    );
    return '$_temp0';
  }

  @override
  String get settingsLanguage => 'Language';

  @override
  String get languageSystem => 'Device language';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageBurmese => 'မြန်မာ';

  @override
  String settingsVersion(String version) {
    return 'J’Donuts $version';
  }

  @override
  String continueWith(String provider) {
    return 'Continue with $provider';
  }

  @override
  String socialSignInUnavailable(String provider) {
    return '$provider sign-in isn’t available in this demo';
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
  String get notRegistered => 'This number isn’t registered yet.';

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
  String get otpWrong => 'That code isn’t right. Try again.';

  @override
  String get otpRetry => 'Try again';

  @override
  String get otpLocked => 'Too many wrong codes. Tap Resend to get a new one.';

  @override
  String get didntReceive => 'Didn’t receive the code?';

  @override
  String get resend => 'Resend';

  @override
  String get firstNameRequired => 'Enter your first name';

  @override
  String get nameInvalid => 'Use letters and spaces only';

  @override
  String get dobInvalid => 'That date doesn’t exist';

  @override
  String get dobFuture => 'Date of birth can’t be in the future';

  @override
  String otpSent(String phone) {
    return 'We’ve sent a 6 digit OTP to $phone';
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
  String get nameTitle => 'What’s your name?';

  @override
  String get firstNameHint => 'First Name';

  @override
  String get lastNameHint => 'Last Name';

  @override
  String get dobTitle => 'What’s your date of birth?';

  @override
  String get monthHint => 'Month';

  @override
  String get dayHint => 'Day';

  @override
  String get yearHint => 'Year';

  @override
  String get dobPickerTitle => 'Select your birthday';

  @override
  String get select => 'Select';

  @override
  String get letsExplore => 'Let’s explore';

  @override
  String get imageUnavailable => 'Image unavailable';

  @override
  String homeMemberTier(String tier) {
    return '$tier member';
  }

  @override
  String homePointsToNextTier(String points, String tier) {
    return '$points points left to become $tier Member';
  }

  @override
  String get homeMemberEmpty => 'Your membership details aren’t ready yet.';

  @override
  String get homeTopTier => 'You’re at our top tier';

  @override
  String homeNotifications(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count notifications',
      one: '1 notification',
      zero: 'No notifications',
    );
    return '$_temp0';
  }

  @override
  String get homeSectionSeasonal => 'Seasonal specials';

  @override
  String get homeSectionPopular => 'Popular';

  @override
  String get homeSectionOrderAgain => 'Order again';

  @override
  String get homeSectionOther => 'More to try';

  @override
  String get homeSectionPopularEmoji => '🔥';

  @override
  String get homeSeeAll => 'See all';

  @override
  String discountOff(int percent) {
    return '$percent% off';
  }

  @override
  String homeShopsTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'There are $count J’Donut shops near you. 😋',
      one: 'There is 1 J’Donut shop near you. 😋',
    );
    return '$_temp0';
  }

  @override
  String get homeExploreNow => 'Explore now';

  @override
  String get homeOrderOnline => 'Order online';

  @override
  String get homeOffline => 'You’re offline. Showing saved data.';

  @override
  String get refreshLoading => 'Loading';

  @override
  String get homeRefreshFailed => 'Couldn’t refresh. Showing saved data.';

  @override
  String get homeSectionEmpty => 'Nothing here yet.';

  @override
  String get homeSectionError => 'We couldn’t load this section.';

  @override
  String get homeSeedError => 'We couldn’t set up your app';

  @override
  String get homeSeedErrorHint =>
      'Your donuts, shops and rewards didn’t load. Give it another try.';

  @override
  String get homeRetry => 'Try again';

  @override
  String get productNew => 'New';

  @override
  String get productWhatsThis => 'What’s this?';

  @override
  String get productAddToCart => 'Add to cart';

  @override
  String productPrice(String amount) {
    return '$amount MMK';
  }

  @override
  String productAddedToCart(int count, String name) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Added $count $name to your cart',
      one: 'Added 1 $name to your cart',
    );
    return '$_temp0';
  }

  @override
  String get productDecrease => 'Decrease quantity';

  @override
  String get productIncrease => 'Increase quantity';

  @override
  String get productNotFound => 'This product isn’t available any more.';

  @override
  String get productAddFailed => 'Couldn’t add to your cart. Try again.';

  @override
  String get productLoadError => 'We couldn’t load this product.';

  @override
  String get productLoadErrorHint =>
      'Something went wrong on our side. Give it another try.';

  @override
  String get productNotFoundHint => 'It may have sold out or left the menu.';

  @override
  String get rewardsTitle => 'J\' Donuts Rewards';

  @override
  String get rewardsPill => 'Rewards';

  @override
  String rewardsAvailable(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count rewards available',
      one: '1 reward available',
    );
    return '$_temp0';
  }

  @override
  String get rewardsTierCurrent => 'You’re here now';

  @override
  String rewardsTierRemaining(String points, String tier) {
    return '$points pts Remaining to become $tier';
  }

  @override
  String get rewardsTierUpcoming => 'You’ll be here soon';

  @override
  String get rewardsTierReached => 'Reached';

  @override
  String get rewardsTotalPoints => 'Total points';

  @override
  String get rewardsTabChallenges => 'Eat more earn more';

  @override
  String get rewardsTabGifts => 'Gift';

  @override
  String get rewardsEarn => 'Earn';

  @override
  String get rewardsEarned => 'Earned';

  @override
  String get rewardsRedeem => 'Redeem';

  @override
  String rewardsPoints(String points) {
    return '$points pts';
  }

  @override
  String rewardsProgress(int progress, int target) {
    return '$progress/$target';
  }

  @override
  String get rewardsEmpty => 'Nothing to show yet.';

  @override
  String get rewardsError => 'We couldn’t load your rewards.';

  @override
  String get rewardsRetry => 'Try again';

  @override
  String get cartTitle => 'Cart';

  @override
  String get cartEmptyTitle => 'Your cart is empty';

  @override
  String get cartEmptyMessage => 'Add a donut from any product page.';

  @override
  String get cartErrorTitle => 'Couldn\'t load your cart';

  @override
  String get cartErrorMessage =>
      'Something went wrong reading it. Try again in a moment.';

  @override
  String get cartRetry => 'Try again';

  @override
  String get cartRemove => 'Remove';

  @override
  String get cartChangeFailed => 'Couldn\'t update your cart';

  @override
  String cartOpen(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Cart, $count items',
      one: 'Cart, 1 item',
      zero: 'Cart, empty',
    );
    return '$_temp0';
  }

  @override
  String get cartTotal => 'Total';
}
