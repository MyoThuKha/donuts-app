// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_envelope.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ApiEnvelope<T> _$ApiEnvelopeFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) => $checkedCreate('_ApiEnvelope', json, ($checkedConvert) {
  final val = _ApiEnvelope<T>(
    meta: $checkedConvert(
      'meta',
      (v) => ApiMetaDto.fromJson(v as Map<String, dynamic>),
    ),
    data: $checkedConvert(
      'data',
      (v) => _$nullableGenericFromJson(v, fromJsonT),
    ),
    error: $checkedConvert(
      'error',
      (v) => v == null ? null : ApiErrorDto.fromJson(v as Map<String, dynamic>),
    ),
  );
  return val;
});

Map<String, dynamic> _$ApiEnvelopeToJson<T>(
  _ApiEnvelope<T> instance,
  Object? Function(T value) toJsonT,
) => <String, dynamic>{
  'meta': instance.meta.toJson(),
  'data': _$nullableGenericToJson(instance.data, toJsonT),
  'error': instance.error?.toJson(),
};

T? _$nullableGenericFromJson<T>(
  Object? input,
  T Function(Object? json) fromJson,
) => input == null ? null : fromJson(input);

Object? _$nullableGenericToJson<T>(
  T? input,
  Object? Function(T value) toJson,
) => input == null ? null : toJson(input);

_ApiMetaDto _$ApiMetaDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_ApiMetaDto', json, ($checkedConvert) {
      final val = _ApiMetaDto(
        version: $checkedConvert('version', (v) => (v as num).toInt()),
        generatedAt: $checkedConvert(
          'generatedAt',
          (v) => DateTime.parse(v as String),
        ),
      );
      return val;
    });

Map<String, dynamic> _$ApiMetaDtoToJson(_ApiMetaDto instance) =>
    <String, dynamic>{
      'version': instance.version,
      'generatedAt': instance.generatedAt.toIso8601String(),
    };

_ApiErrorDto _$ApiErrorDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_ApiErrorDto', json, ($checkedConvert) {
      final val = _ApiErrorDto(
        code: $checkedConvert('code', (v) => v as String),
        message: $checkedConvert('message', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$ApiErrorDtoToJson(_ApiErrorDto instance) =>
    <String, dynamic>{'code': instance.code, 'message': instance.message};
