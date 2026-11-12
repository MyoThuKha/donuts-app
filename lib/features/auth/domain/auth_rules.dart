/// Rules the client's requirements fix for sign-up and log-in.
abstract final class AuthRules {
  static const String countryCode = '+95';
  static const int otpLength = 6;
  static const int maxOtpAttempts = 3;
  static const Duration resendCountdown = Duration(minutes: 5);
  static const int nameMaxLength = 50;
  static const int minimumAge = 13;
}
