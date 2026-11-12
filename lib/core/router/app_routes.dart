/// Route paths. Features navigate with these, never with string literals.
abstract final class AppRoutes {
  static const String home = '/home';
  static const String rewards = '/rewards';
  static const String explore = '/explore';
  static const String wallet = '/wallet';
  static const String settings = '/settings';

  static const String onboarding = '/onboarding';
  static const String welcome = '/welcome';

  static const String register = '/register';
  static const String registerPhone = '$register/phone';
  static const String registerOtp = '$register/otp';
  static const String registerName = '$register/name';
  static const String registerDob = '$register/dob';

  static const String logIn = '/login';
  static const String logInPhone = '$logIn/phone';
  static const String logInOtp = '$logIn/otp';

  /// Routes a signed-out user may see.
  static bool isPublic(String location) =>
      location == onboarding ||
      location.startsWith('$register/') ||
      location.startsWith('$logIn/');
}
