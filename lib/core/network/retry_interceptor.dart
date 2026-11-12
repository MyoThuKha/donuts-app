import 'dart:io';

import 'package:dio/dio.dart';

/// Retries a failed GET after a growing delay: [baseDelay], then twice that.
///
/// Only failures a retry can fix are retried: no connection, a timeout, or a
/// 5xx. Other methods are never retried, because they may not be safe to
/// repeat.
class RetryInterceptor extends Interceptor {
  new({
    required this._dio,
    this.maxRetries = 2,
    this.baseDelay = const Duration(milliseconds: 500),
    this._wait = Future<void>.delayed,
  });

  final Dio _dio;
  final int maxRetries;
  final Duration baseDelay;
  final Future<void> Function(Duration) _wait;

  static const String _attemptKey = 'retryAttempt';
  static const int _firstServerError = 500;

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final options = err.requestOptions;
    final attempt = options.extra[_attemptKey] as int? ?? 0;
    if (attempt >= maxRetries || !_isRetryable(err)) return handler.next(err);

    await _wait(baseDelay * (1 << attempt));
    options.extra[_attemptKey] = attempt + 1;
    try {
      handler.resolve(await _dio.fetch<dynamic>(options));
    } on DioException catch (e) {
      handler.next(e);
    }
  }

  bool _isRetryable(DioException err) {
    if (err.requestOptions.method.toUpperCase() != 'GET') return false;
    return switch (err.type) {
      DioExceptionType.connectionError ||
      DioExceptionType.connectionTimeout ||
      DioExceptionType.sendTimeout ||
      DioExceptionType.receiveTimeout => true,
      DioExceptionType.badResponse =>
        (err.response?.statusCode ?? 0) >= _firstServerError,
      DioExceptionType.unknown => err.error is SocketException,
      _ => false,
    };
  }
}
