import 'package:dio/dio.dart';
import 'package:donuts/core/network/api_config.dart';
import 'package:donuts/core/network/retry_interceptor.dart';
import 'package:flutter/foundation.dart';

/// The Dio the app uses for the mock API.
///
/// Bodies come back as plain text, because GitHub raw serves JSON as
/// `text/plain`. The data source decodes them itself.
Dio buildApiDio(ApiConfig config, {bool logRequests = kDebugMode}) {
  final dio = Dio(
    BaseOptions(
      baseUrl: config.baseUrl,
      connectTimeout: ApiConfig.connectTimeout,
      receiveTimeout: ApiConfig.receiveTimeout,
      responseType: ResponseType.plain,
    ),
  );
  dio.interceptors.add(RetryInterceptor(dio: dio));
  if (logRequests) {
    dio.interceptors.add(LogInterceptor());
  }
  return dio;
}
