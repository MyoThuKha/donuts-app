// Freezed's redirecting factory must keep the class name.
// ignore_for_file: unnecessary_type_name_in_constructor
import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_envelope.freezed.dart';
part 'api_envelope.g.dart';

/// The `{data, error, meta}` wrapper every mock API response and seed file
/// uses.
@Freezed(genericArgumentFactories: true)
abstract class ApiEnvelope<T> with _$ApiEnvelope<T> {
  const factory ApiEnvelope({
    required ApiMetaDto meta,
    T? data,
    ApiErrorDto? error,
  }) = _ApiEnvelope<T>;

  factory fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) => _$ApiEnvelopeFromJson(json, fromJsonT);
}

@freezed
abstract class ApiMetaDto with _$ApiMetaDto {
  const factory ApiMetaDto({
    required int version,
    required DateTime generatedAt,
  }) = _ApiMetaDto;

  factory fromJson(Map<String, dynamic> json) => _$ApiMetaDtoFromJson(json);
}

@freezed
abstract class ApiErrorDto with _$ApiErrorDto {
  const factory ApiErrorDto({required String code, required String message}) =
      _ApiErrorDto;

  factory fromJson(Map<String, dynamic> json) => _$ApiErrorDtoFromJson(json);
}
