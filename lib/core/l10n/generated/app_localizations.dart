import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('en')];

  /// App name shown by the OS task switcher.
  ///
  /// In en, this message translates to:
  /// **'J’Donuts'**
  String get appTitle;

  /// Bottom navigation label for the Home tab.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get tabHome;

  /// Bottom navigation label for the Rewards tab.
  ///
  /// In en, this message translates to:
  /// **'Reward'**
  String get tabReward;

  /// Bottom navigation label for the Explore tab.
  ///
  /// In en, this message translates to:
  /// **'Explore'**
  String get tabExplore;

  /// Bottom navigation label for the Wallet tab.
  ///
  /// In en, this message translates to:
  /// **'Wallet'**
  String get tabWallet;

  /// Bottom navigation label for the Settings tab.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get tabSettings;

  /// Body of a tab that is not built yet.
  ///
  /// In en, this message translates to:
  /// **'{tab} is coming soon'**
  String placeholderComingSoon(String tab);

  /// No description provided for @welcomeTitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome to the world of J’donuts'**
  String get welcomeTitle;

  /// No description provided for @onboardingTitle.
  ///
  /// In en, this message translates to:
  /// **'Round food for every mood'**
  String get onboardingTitle;

  /// No description provided for @getStarted.
  ///
  /// In en, this message translates to:
  /// **'Let’s get started'**
  String get getStarted;

  /// No description provided for @alreadyHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get alreadyHaveAccount;

  /// No description provided for @logIn.
  ///
  /// In en, this message translates to:
  /// **'Log In'**
  String get logIn;

  /// No description provided for @termsPrefix.
  ///
  /// In en, this message translates to:
  /// **'By continuing, you acknowledge that you have read and agree to our'**
  String get termsPrefix;

  /// No description provided for @termsOfUse.
  ///
  /// In en, this message translates to:
  /// **'Terms of Use'**
  String get termsOfUse;

  /// No description provided for @and.
  ///
  /// In en, this message translates to:
  /// **'and'**
  String get and;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// No description provided for @comingSoonTitle.
  ///
  /// In en, this message translates to:
  /// **'Coming soon'**
  String get comingSoonTitle;

  /// Snackbar for buttons whose feature isn’t built yet
  ///
  /// In en, this message translates to:
  /// **'This feature is coming soon.'**
  String get featureComingSoon;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @logOut.
  ///
  /// In en, this message translates to:
  /// **'Log out'**
  String get logOut;

  /// No description provided for @logOutConfirm.
  ///
  /// In en, this message translates to:
  /// **'Log out of J’Donuts?'**
  String get logOutConfirm;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @accountDateOfBirth.
  ///
  /// In en, this message translates to:
  /// **'Date of birth'**
  String get accountDateOfBirth;

  /// No description provided for @accountAge.
  ///
  /// In en, this message translates to:
  /// **'Age'**
  String get accountAge;

  /// No description provided for @accountAgeYears.
  ///
  /// In en, this message translates to:
  /// **'{years, plural, =1{1 year} other{{years} years}}'**
  String accountAgeYears(int years);

  /// No description provided for @settingsVersion.
  ///
  /// In en, this message translates to:
  /// **'J’Donuts {version}'**
  String settingsVersion(String version);

  /// Accessibility label for a social sign-in button.
  ///
  /// In en, this message translates to:
  /// **'Continue with {provider}'**
  String continueWith(String provider);

  /// Placeholder sheet body for social sign-in.
  ///
  /// In en, this message translates to:
  /// **'{provider} sign-in isn’t available in this demo'**
  String socialSignInUnavailable(String provider);

  /// Placeholder sheet body for legal documents.
  ///
  /// In en, this message translates to:
  /// **'The {document} will be available here soon.'**
  String documentUnavailable(String document);

  /// Screen-reader label for the registration progress ring.
  ///
  /// In en, this message translates to:
  /// **'Step {step} of {total}'**
  String stepOf(int step, int total);

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @phoneTitle.
  ///
  /// In en, this message translates to:
  /// **'Enter your phone number'**
  String get phoneTitle;

  /// No description provided for @phoneHint.
  ///
  /// In en, this message translates to:
  /// **'09xxxxxxxxx'**
  String get phoneHint;

  /// No description provided for @phoneInvalid.
  ///
  /// In en, this message translates to:
  /// **'Enter a Myanmar mobile number, like 09 254 135 592'**
  String get phoneInvalid;

  /// No description provided for @notRegistered.
  ///
  /// In en, this message translates to:
  /// **'This number isn’t registered yet.'**
  String get notRegistered;

  /// No description provided for @registerInstead.
  ///
  /// In en, this message translates to:
  /// **'Register instead'**
  String get registerInstead;

  /// No description provided for @alreadyRegistered.
  ///
  /// In en, this message translates to:
  /// **'This number is already registered.'**
  String get alreadyRegistered;

  /// No description provided for @logInInstead.
  ///
  /// In en, this message translates to:
  /// **'Log in instead'**
  String get logInInstead;

  /// No description provided for @genericError.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong. Try again.'**
  String get genericError;

  /// No description provided for @continueLabel.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueLabel;

  /// No description provided for @otpTitle.
  ///
  /// In en, this message translates to:
  /// **'Verify your number'**
  String get otpTitle;

  /// No description provided for @otpWrong.
  ///
  /// In en, this message translates to:
  /// **'That code isn’t right. Try again.'**
  String get otpWrong;

  /// No description provided for @otpLocked.
  ///
  /// In en, this message translates to:
  /// **'Too many wrong codes. Tap Resend to get a new one.'**
  String get otpLocked;

  /// No description provided for @didntReceive.
  ///
  /// In en, this message translates to:
  /// **'Didn’t receive the code?'**
  String get didntReceive;

  /// No description provided for @resend.
  ///
  /// In en, this message translates to:
  /// **'Resend'**
  String get resend;

  /// No description provided for @firstNameRequired.
  ///
  /// In en, this message translates to:
  /// **'Enter your first name'**
  String get firstNameRequired;

  /// No description provided for @nameInvalid.
  ///
  /// In en, this message translates to:
  /// **'Use letters and spaces only'**
  String get nameInvalid;

  /// No description provided for @dobInvalid.
  ///
  /// In en, this message translates to:
  /// **'That date doesn’t exist'**
  String get dobInvalid;

  /// No description provided for @dobFuture.
  ///
  /// In en, this message translates to:
  /// **'Date of birth can’t be in the future'**
  String get dobFuture;

  /// No description provided for @otpSent.
  ///
  /// In en, this message translates to:
  /// **'We’ve sent a 6 digit OTP to {phone}'**
  String otpSent(String phone);

  /// No description provided for @resendIn.
  ///
  /// In en, this message translates to:
  /// **'resend in {time} min'**
  String resendIn(String time);

  /// No description provided for @nameTooLong.
  ///
  /// In en, this message translates to:
  /// **'Use {max} characters or fewer'**
  String nameTooLong(int max);

  /// No description provided for @dobTooYoung.
  ///
  /// In en, this message translates to:
  /// **'You need to be at least {age} to join'**
  String dobTooYoung(int age);

  /// No description provided for @nameTitle.
  ///
  /// In en, this message translates to:
  /// **'What’s your name?'**
  String get nameTitle;

  /// No description provided for @firstNameHint.
  ///
  /// In en, this message translates to:
  /// **'First Name'**
  String get firstNameHint;

  /// No description provided for @lastNameHint.
  ///
  /// In en, this message translates to:
  /// **'Last Name'**
  String get lastNameHint;

  /// No description provided for @dobTitle.
  ///
  /// In en, this message translates to:
  /// **'What’s your date of birth?'**
  String get dobTitle;

  /// No description provided for @monthHint.
  ///
  /// In en, this message translates to:
  /// **'Month'**
  String get monthHint;

  /// No description provided for @dayHint.
  ///
  /// In en, this message translates to:
  /// **'Day'**
  String get dayHint;

  /// No description provided for @yearHint.
  ///
  /// In en, this message translates to:
  /// **'Year'**
  String get yearHint;

  /// Title of the sheet with the date of birth wheel
  ///
  /// In en, this message translates to:
  /// **'Select your birthday'**
  String get dobPickerTitle;

  /// Button that confirms the value chosen in a picker sheet
  ///
  /// In en, this message translates to:
  /// **'Select'**
  String get select;

  /// No description provided for @letsExplore.
  ///
  /// In en, this message translates to:
  /// **'Let’s explore'**
  String get letsExplore;

  /// Screen reader label for an image that failed to load
  ///
  /// In en, this message translates to:
  /// **'Image unavailable'**
  String get imageUnavailable;

  /// Member tier under the name on Home
  ///
  /// In en, this message translates to:
  /// **'{tier} member'**
  String homeMemberTier(String tier);

  /// Chip under the Home header; points is pre-formatted
  ///
  /// In en, this message translates to:
  /// **'{points} points left to become {tier} Member'**
  String homePointsToNextTier(String points, String tier);

  /// Home header chip when there is no next tier
  ///
  /// In en, this message translates to:
  /// **'You’re at our top tier'**
  String get homeTopTier;

  /// Screen reader label for the notification bell
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{No notifications} =1{1 notification} other{{count} notifications}}'**
  String homeNotifications(int count);

  /// Home section title
  ///
  /// In en, this message translates to:
  /// **'Seasonal specials'**
  String get homeSectionSeasonal;

  /// Home section title
  ///
  /// In en, this message translates to:
  /// **'Popular'**
  String get homeSectionPopular;

  /// Home section title
  ///
  /// In en, this message translates to:
  /// **'Order again'**
  String get homeSectionOrderAgain;

  /// Chevron button next to a Home section title
  ///
  /// In en, this message translates to:
  /// **'See all'**
  String get homeSeeAll;

  /// Discount badge on product tiles and Product detail
  ///
  /// In en, this message translates to:
  /// **'{percent}% off'**
  String discountOff(int percent);

  /// Title of the nearby shops band. Non-breaking spaces keep "near you. 😋" on one line.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{There is 1 J’Donut shop near you. 😋} other{There are {count} J’Donut shops near you. 😋}}'**
  String homeShopsTitle(int count);

  /// Button in the nearby shops band
  ///
  /// In en, this message translates to:
  /// **'Explore now'**
  String get homeExploreNow;

  /// Link on a shop card
  ///
  /// In en, this message translates to:
  /// **'Order online'**
  String get homeOrderOnline;

  /// Banner at the top of Home while offline
  ///
  /// In en, this message translates to:
  /// **'You’re offline. Showing saved data.'**
  String get homeOffline;

  /// Label in the pull-to-refresh pill while the refresh runs
  ///
  /// In en, this message translates to:
  /// **'Loading'**
  String get refreshLoading;

  /// Snackbar after a failed pull-to-refresh
  ///
  /// In en, this message translates to:
  /// **'Couldn’t refresh. Showing saved data.'**
  String get homeRefreshFailed;

  /// Shown in a Home section with no items
  ///
  /// In en, this message translates to:
  /// **'Nothing here yet.'**
  String get homeSectionEmpty;

  /// Shown in a Home section that failed to load
  ///
  /// In en, this message translates to:
  /// **'We couldn’t load this section.'**
  String get homeSectionError;

  /// Retry button in a failed Home section
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get homeRetry;

  /// Badge on a new product
  ///
  /// In en, this message translates to:
  /// **'New'**
  String get productNew;

  /// Label next to the product description
  ///
  /// In en, this message translates to:
  /// **'What’s this?'**
  String get productWhatsThis;

  /// Add to cart button
  ///
  /// In en, this message translates to:
  /// **'Add to cart'**
  String get productAddToCart;

  /// A price in Myanmar kyat; amount is pre-formatted
  ///
  /// In en, this message translates to:
  /// **'{amount} MMK'**
  String productPrice(String amount);

  /// Snackbar after adding to the cart
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{Added 1 {name} to your cart} other{Added {count} {name} to your cart}}'**
  String productAddedToCart(int count, String name);

  /// Screen reader label for the minus button
  ///
  /// In en, this message translates to:
  /// **'Decrease quantity'**
  String get productDecrease;

  /// Screen reader label for the plus button
  ///
  /// In en, this message translates to:
  /// **'Increase quantity'**
  String get productIncrease;

  /// Product detail for a product the catalog no longer has
  ///
  /// In en, this message translates to:
  /// **'This product isn’t available any more.'**
  String get productNotFound;

  /// Snackbar when adding to the cart fails
  ///
  /// In en, this message translates to:
  /// **'Couldn’t add to your cart. Try again.'**
  String get productAddFailed;

  /// Rewards screen title
  ///
  /// In en, this message translates to:
  /// **'J\' Donuts Rewards'**
  String get rewardsTitle;

  /// Pill next to the Rewards title
  ///
  /// In en, this message translates to:
  /// **'Rewards'**
  String get rewardsPill;

  /// Screen reader label for the Rewards pill badge
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 reward available} other{{count} rewards available}}'**
  String rewardsAvailable(int count);

  /// Caption under the current tier
  ///
  /// In en, this message translates to:
  /// **'You’re here now'**
  String get rewardsTierCurrent;

  /// Caption under the next tier; points is pre-formatted
  ///
  /// In en, this message translates to:
  /// **'{points} pts Remaining to become {tier}'**
  String rewardsTierRemaining(String points, String tier);

  /// Caption under tiers beyond the next one
  ///
  /// In en, this message translates to:
  /// **'You’ll be here soon'**
  String get rewardsTierUpcoming;

  /// Caption under tiers below the current one
  ///
  /// In en, this message translates to:
  /// **'Reached'**
  String get rewardsTierReached;

  /// Label inside the points ring
  ///
  /// In en, this message translates to:
  /// **'Total points'**
  String get rewardsTotalPoints;

  /// Rewards tab
  ///
  /// In en, this message translates to:
  /// **'Eat more earn more'**
  String get rewardsTabChallenges;

  /// Rewards tab
  ///
  /// In en, this message translates to:
  /// **'Gift'**
  String get rewardsTabGifts;

  /// Button on a challenge card
  ///
  /// In en, this message translates to:
  /// **'Earn'**
  String get rewardsEarn;

  /// Grey button on a challenge whose points were already earned
  ///
  /// In en, this message translates to:
  /// **'Earned'**
  String get rewardsEarned;

  /// Button on a gift card
  ///
  /// In en, this message translates to:
  /// **'Redeem'**
  String get rewardsRedeem;

  /// Points value; points is pre-formatted
  ///
  /// In en, this message translates to:
  /// **'{points} pts'**
  String rewardsPoints(String points);

  /// Challenge progress
  ///
  /// In en, this message translates to:
  /// **'{progress}/{target}'**
  String rewardsProgress(int progress, int target);

  /// Rewards with no member data
  ///
  /// In en, this message translates to:
  /// **'Nothing to show yet.'**
  String get rewardsEmpty;

  /// Rewards when its data fails to load
  ///
  /// In en, this message translates to:
  /// **'We couldn’t load your rewards.'**
  String get rewardsError;

  /// Retry button on the Rewards error state
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get rewardsRetry;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
