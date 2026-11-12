/// Typed failures that cross layer boundaries instead of exceptions.
sealed class AppFailure {
  const new({this.error, this.stackTrace});

  /// The exception that caused this failure, kept for logging.
  final Object? error;
  final StackTrace? stackTrace;
}

final class NetworkFailure extends AppFailure {
  const new({super.error, super.stackTrace});
}

final class TimeoutFailure extends AppFailure {
  const new({super.error, super.stackTrace});
}

final class ServerFailure extends AppFailure {
  const new({this.statusCode, super.error, super.stackTrace});

  final int? statusCode;
}

final class ParsingFailure extends AppFailure {
  const new({super.error, super.stackTrace});
}

final class DatabaseFailure extends AppFailure {
  const new({super.error, super.stackTrace});
}

/// Log-in was attempted with a number nobody has registered.
final class NotRegisteredFailure extends AppFailure {
  const new();
}

/// Registration was attempted with a number that already has an account.
final class AlreadyRegisteredFailure extends AppFailure {
  const new();
}

final class WrongOtpFailure extends AppFailure {
  const new();
}

final class UnknownFailure extends AppFailure {
  const new({super.error, super.stackTrace});
}
