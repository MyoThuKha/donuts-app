// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Burmese (`my`).
class AppLocalizationsMy extends AppLocalizations {
  AppLocalizationsMy([String locale = 'my']) : super(locale);

  @override
  String get appTitle => 'J’Donuts';

  @override
  String get tabHome => 'ပင်မ';

  @override
  String get tabReward => 'ဆုလာဘ်';

  @override
  String get tabExplore => 'ရှာဖွေ';

  @override
  String get tabWallet => 'ပိုက်ဆံအိတ်';

  @override
  String get tabSettings => 'ဆက်တင်';

  @override
  String placeholderComingSoon(String tab) {
    return '$tab မကြာမီ ရောက်ရှိလာပါမည်';
  }

  @override
  String get welcomeTitle => 'J’donuts ကမ္ဘာလေးမှ ကြိုဆိုပါတယ်';

  @override
  String get onboardingTitle => 'စိတ်ခံစားမှုတိုင်းအတွက် အဝိုင်းလေးတွေ';

  @override
  String get getStarted => 'စတင်ကြရအောင်';

  @override
  String get alreadyHaveAccount => 'အကောင့်ရှိပြီးသားလား?';

  @override
  String get logIn => 'အကောင့်ဝင်ရန်';

  @override
  String get termsPrefix => 'ဆက်လက်လုပ်ဆောင်ခြင်းဖြင့် ကျွန်ုပ်တို့၏';

  @override
  String get termsOfUse => 'အသုံးပြုမှုစည်းမျဉ်းများ';

  @override
  String get and => 'နှင့်';

  @override
  String get privacyPolicy => 'ကိုယ်ရေးအချက်အလက်မူဝါဒ';

  @override
  String get termsSuffix => ' ကို ဖတ်ရှုပြီး သဘောတူကြောင်း အသိအမှတ်ပြုပါသည်။';

  @override
  String get comingSoonTitle => 'မကြာမီ လာပါမည်';

  @override
  String get featureComingSoon => 'ဤလုပ်ဆောင်ချက်ကို မကြာမီ သုံးနိုင်ပါမည်။';

  @override
  String get close => 'ပိတ်ရန်';

  @override
  String get logOut => 'အကောင့်မှ ထွက်ရန်';

  @override
  String get logOutConfirm => 'J’Donuts မှ ထွက်မလား?';

  @override
  String get logOutFailed => 'အကောင့်မှ ထွက်၍ မရပါ။ ထပ်ကြိုးစားကြည့်ပါ။';

  @override
  String get cancel => 'မလုပ်တော့ပါ';

  @override
  String get accountDateOfBirth => 'မွေးသက္ကရာဇ်';

  @override
  String get accountAge => 'အသက်';

  @override
  String accountAgeYears(int years) {
    String _temp0 = intl.Intl.pluralLogic(
      years,
      locale: localeName,
      other: '$years နှစ်',
    );
    return '$_temp0';
  }

  @override
  String get settingsLanguage => 'ဘာသာစကား';

  @override
  String get languageSystem => 'ဖုန်း၏ ဘာသာစကား';

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
    return '$provider ဖြင့် ဆက်လုပ်ရန်';
  }

  @override
  String socialSignInUnavailable(String provider) {
    return 'ဤနမူနာတွင် $provider ဖြင့် အကောင့်ဝင်၍ မရသေးပါ';
  }

  @override
  String documentUnavailable(String document) {
    return '$document ကို ဤနေရာတွင် မကြာမီ ဖတ်ရှုနိုင်ပါမည်။';
  }

  @override
  String stepOf(int step, int total) {
    return 'အဆင့် $total ဆင့်အနက် အဆင့် $step';
  }

  @override
  String get back => 'နောက်သို့';

  @override
  String get phoneTitle => 'သင့်ဖုန်းနံပါတ်ကို ထည့်ပါ';

  @override
  String get phoneHint => '09xxxxxxxxx';

  @override
  String get phoneInvalid =>
      '09 254 135 592 ကဲ့သို့ မြန်မာမိုဘိုင်းနံပါတ်ကို ထည့်ပါ';

  @override
  String get notRegistered => 'ဤနံပါတ်ဖြင့် စာရင်းမသွင်းရသေးပါ။';

  @override
  String get registerInstead => 'စာရင်းသွင်းရန်';

  @override
  String get alreadyRegistered => 'ဤနံပါတ်ဖြင့် စာရင်းသွင်းပြီးသား ဖြစ်ပါသည်။';

  @override
  String get logInInstead => 'အကောင့်ဝင်ရန်';

  @override
  String get genericError => 'တစ်ခုခု မှားယွင်းသွားပါသည်။ ထပ်ကြိုးစားကြည့်ပါ။';

  @override
  String get continueLabel => 'ဆက်လုပ်ရန်';

  @override
  String get otpTitle => 'သင့်နံပါတ်ကို အတည်ပြုပါ';

  @override
  String get otpWrong => 'ကုဒ် မှားနေပါသည်။ ထပ်ကြိုးစားကြည့်ပါ။';

  @override
  String get otpRetry => 'ထပ်ကြိုးစားရန်';

  @override
  String get otpLocked =>
      'ကုဒ်မှားသည့်အကြိမ် များလွန်းပါသည်။ ကုဒ်အသစ်ရယူရန် ပြန်ပို့ရန် ကို နှိပ်ပါ။';

  @override
  String get didntReceive => 'ကုဒ် မရရှိဘူးလား?';

  @override
  String get resend => 'ပြန်ပို့ရန်';

  @override
  String get firstNameRequired => 'သင့်အမည်ကို ထည့်ပါ';

  @override
  String get nameInvalid => 'စာလုံးများနှင့် ကွက်လပ်များသာ သုံးပါ';

  @override
  String get dobInvalid => 'ထိုရက်စွဲ မရှိပါ';

  @override
  String get dobFuture => 'မွေးသက္ကရာဇ်သည် အနာဂတ်ရက်စွဲ မဖြစ်ရပါ';

  @override
  String otpSent(String phone) {
    return '$phone သို့ ဂဏန်း 6 လုံးပါ OTP ကုဒ် ပို့ထားပါသည်';
  }

  @override
  String resendIn(String time) {
    return '$time မိနစ်အကြာတွင် ပြန်ပို့နိုင်ပါမည်';
  }

  @override
  String nameTooLong(int max) {
    return 'စာလုံး $max လုံးအထိသာ သုံးပါ';
  }

  @override
  String dobTooYoung(int age) {
    return 'ပါဝင်ရန် အသက် အနည်းဆုံး $age နှစ် ပြည့်ရပါမည်';
  }

  @override
  String get nameTitle => 'သင့်နာမည် ဘယ်လိုခေါ်လဲ?';

  @override
  String get firstNameHint => 'ရှေ့အမည်';

  @override
  String get lastNameHint => 'နောက်အမည်';

  @override
  String get dobTitle => 'သင် ဘယ်နေ့ မွေးလဲ?';

  @override
  String get monthHint => 'လ';

  @override
  String get dayHint => 'ရက်';

  @override
  String get yearHint => 'နှစ်';

  @override
  String get dobPickerTitle => 'သင့်မွေးနေ့ကို ရွေးပါ';

  @override
  String get select => 'ရွေးရန်';

  @override
  String get letsExplore => 'စတင်ရှာဖွေကြရအောင်';

  @override
  String get imageUnavailable => 'ပုံ မရရှိနိုင်ပါ';

  @override
  String homeMemberTier(String tier) {
    return '$tier အဖွဲ့ဝင်';
  }

  @override
  String homePointsToNextTier(String points, String tier) {
    return '$tier အဖွဲ့ဝင်ဖြစ်ရန် $points မှတ် လိုပါသေးသည်';
  }

  @override
  String get homeMemberEmpty => 'သင့်အဖွဲ့ဝင် အချက်အလက်များ မရသေးပါ။';

  @override
  String get homeTopTier => 'အမြင့်ဆုံးအဆင့်သို့ ရောက်ရှိနေပါပြီ';

  @override
  String homeNotifications(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'အသိပေးချက် $count ခု',
      zero: 'အသိပေးချက် မရှိပါ',
    );
    return '$_temp0';
  }

  @override
  String get homeSectionSeasonal => 'ရာသီအလိုက် အထူးများ';

  @override
  String get homeSectionPopular => 'လူကြိုက်များ';

  @override
  String get homeSectionOrderAgain => 'ထပ်မှာရန်';

  @override
  String get homeSectionOther => 'နောက်ထပ် စမ်းကြည့်ရန်';

  @override
  String get homeSectionPopularEmoji => '🔥';

  @override
  String get homeSeeAll => 'အားလုံးကြည့်ရန်';

  @override
  String discountOff(int percent) {
    return '$percent% လျှော့';
  }

  @override
  String homeShopsTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'သင့်အနီးတွင် J’Donut ဆိုင် $count ဆိုင် ရှိပါသည်။ 😋',
    );
    return '$_temp0';
  }

  @override
  String get homeExploreNow => 'အခုပဲ ကြည့်ရှုရန်';

  @override
  String get homeOrderOnline => 'အွန်လိုင်းမှ မှာယူရန်';

  @override
  String get homeOffline =>
      'အင်တာနက် မရှိပါ။ သိမ်းထားသည့် အချက်အလက်များကို ပြသနေပါသည်။';

  @override
  String get refreshLoading => 'ရယူနေသည်';

  @override
  String get homeRefreshFailed =>
      'ပြန်လည်ရယူ၍ မရပါ။ သိမ်းထားသည့် အချက်အလက်များကို ပြသနေပါသည်။';

  @override
  String get homeSectionEmpty => 'ဘာမှ မရှိသေးပါ။';

  @override
  String get homeSectionError => 'ဤကဏ္ဍကို ဖွင့်၍ မရပါ။';

  @override
  String get homeSeedError => 'အက်ပ်ကို ပြင်ဆင်၍ မရပါ';

  @override
  String get homeSeedErrorHint =>
      'ဒိုးနတ်များ၊ ဆိုင်များနှင့် ဆုလာဘ်များကို ဖွင့်၍ မရပါ။ ထပ်ကြိုးစားကြည့်ပါ။';

  @override
  String get homeRetry => 'ထပ်ကြိုးစားရန်';

  @override
  String get productNew => 'အသစ်';

  @override
  String get productWhatsThis => 'ဒါဘာလဲ?';

  @override
  String get productAddToCart => 'ခြင်းထဲ ထည့်ရန်';

  @override
  String productPrice(String amount) {
    return '$amount ကျပ်';
  }

  @override
  String productAddedToCart(int count, String name) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$name $count ခုကို ခြင်းထဲ ထည့်လိုက်ပါပြီ',
    );
    return '$_temp0';
  }

  @override
  String get productDecrease => 'အရေအတွက် လျှော့ရန်';

  @override
  String get productIncrease => 'အရေအတွက် တိုးရန်';

  @override
  String get productNotFound => 'ဤပစ္စည်းကို မရရှိနိုင်တော့ပါ။';

  @override
  String get productAddFailed => 'ခြင်းထဲ ထည့်၍ မရပါ။ ထပ်ကြိုးစားကြည့်ပါ။';

  @override
  String get productLoadError => 'ဤပစ္စည်းကို ဖွင့်၍ မရပါ။';

  @override
  String get productLoadErrorHint =>
      'ကျွန်ုပ်တို့ဘက်မှ တစ်ခုခု မှားယွင်းသွားပါသည်။ ထပ်ကြိုးစားကြည့်ပါ။';

  @override
  String get productNotFoundHint =>
      'ရောင်းကုန်သွားခြင်း သို့မဟုတ် မီနူးမှ ဖယ်ထားခြင်း ဖြစ်နိုင်ပါသည်။';

  @override
  String get rewardsTitle => 'J\' Donuts ဆုလာဘ်';

  @override
  String get rewardsPill => 'ဆုလာဘ်များ';

  @override
  String rewardsAvailable(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'ရယူနိုင်သော ဆုလာဘ် $count ခု',
    );
    return '$_temp0';
  }

  @override
  String get rewardsTierCurrent => 'လက်ရှိအဆင့်';

  @override
  String rewardsTierRemaining(String points, String tier) {
    return '$tier ဖြစ်ရန် $points မှတ် လိုသည်';
  }

  @override
  String get rewardsTierUpcoming => 'မကြာမီ ရောက်ပါမည်';

  @override
  String get rewardsTierReached => 'ရောက်ပြီး';

  @override
  String get rewardsTotalPoints => 'စုစုပေါင်းရမှတ်';

  @override
  String get rewardsTabChallenges => 'ပိုစား ပိုရ';

  @override
  String get rewardsTabGifts => 'လက်ဆောင်';

  @override
  String get rewardsEarn => 'ရယူရန်';

  @override
  String get rewardsEarned => 'ရရှိပြီး';

  @override
  String get rewardsRedeem => 'လဲလှယ်ရန်';

  @override
  String rewardsPoints(String points) {
    return '$points မှတ်';
  }

  @override
  String rewardsProgress(int progress, int target) {
    return '$progress/$target';
  }

  @override
  String get rewardsEmpty => 'ပြသရန် မရှိသေးပါ။';

  @override
  String get rewardsError => 'သင့်ဆုလာဘ်များကို ဖွင့်၍ မရပါ။';

  @override
  String get rewardsRetry => 'ထပ်ကြိုးစားရန်';

  @override
  String get cartTitle => 'ခြင်း';

  @override
  String get cartEmptyTitle => 'ခြင်းထဲ ဘာမှ မရှိသေးပါ';

  @override
  String get cartEmptyMessage =>
      'ပစ္စည်းစာမျက်နှာ တစ်ခုခုမှ မုန့်ကို ထည့်နိုင်ပါသည်။';

  @override
  String get cartBrowse => 'မုန့်များ ကြည့်ရန်';

  @override
  String get cartErrorTitle => 'ခြင်းကို ဖွင့်မရပါ';

  @override
  String get cartErrorMessage =>
      'ဖတ်ရာတွင် အမှားဖြစ်သွားပါသည်။ ခဏနေ ထပ်ကြိုးစားပါ။';

  @override
  String get cartRetry => 'ထပ်ကြိုးစားရန်';

  @override
  String get cartCheckout => 'ငွေချေရန်';

  @override
  String get cartRemove => 'ဖယ်ရှားရန်';

  @override
  String get cartUndo => 'ပြန်ထည့်ရန်';

  @override
  String get cartChangeFailed => 'ခြင်းကို ပြင်မရပါ';

  @override
  String cartRemoved(String name) {
    return '$name ကို ဖယ်လိုက်ပါပြီ';
  }

  @override
  String cartOpen(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'ခြင်း၊ ပစ္စည်း $count ခု',
    );
    return '$_temp0';
  }
}
