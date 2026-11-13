import 'package:dio/dio.dart';

/// Checks that the API host actually answers.
abstract interface class ReachabilityProbe {
  Future<bool> call();
}

/// Sends a HEAD request to [_uri]. Any HTTP response counts as reachable,
/// even an error status, because the network path works.
class HeadReachabilityProbe implements ReachabilityProbe {
  const new(this._dio, this._uri);

  final Dio _dio;
  final Uri _uri;

  @override
  Future<bool> call() async {
    try {
      await _dio.headUri<void>(_uri);
      return true;
    } on DioException catch (e) {
      return e.response != null;
    }
  }
}
