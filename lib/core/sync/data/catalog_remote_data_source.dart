import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:donuts/core/network/api_config.dart';
import 'package:donuts/core/network/api_exception.dart';
import 'package:donuts/core/sync/data/dto/api_envelope.dart';
import 'package:donuts/core/sync/data/dto/catalog_dto.dart';

/// Fetches the public catalog from the mock API.
class CatalogRemoteDataSource {
  const new(this._dio);

  final Dio _dio;

  /// Throws a [DioException] when the request fails, a [FormatException]
  /// when the body isn't the expected JSON, and an [ApiException] when the
  /// envelope reports an error.
  Future<ApiEnvelope<CatalogDto>> fetchCatalog() async {
    final response = await _dio.get<String>(ApiConfig.catalogPath);
    final json = jsonDecode(response.data ?? '');
    if (json is! Map<String, dynamic>) {
      throw const FormatException('The catalog is not a JSON object');
    }
    final envelope = ApiEnvelope<CatalogDto>.fromJson(
      json,
      (data) => CatalogDto.fromJson(data! as Map<String, dynamic>),
    );
    final error = envelope.error;
    if (error != null) throw ApiException(error.code, error.message);
    if (envelope.data == null) {
      throw const ApiException('empty', 'The catalog response has no data');
    }
    return envelope;
  }
}
