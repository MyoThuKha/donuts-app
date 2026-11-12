import 'dart:io';

import 'package:dio/dio.dart';
import 'package:donuts/core/network/api_exception.dart';
import 'package:donuts/core/result/app_failure.dart';
import 'package:donuts/core/result/guard.dart';
import 'package:donuts/core/result/result.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:json_annotation/json_annotation.dart';

void main() {
  group('guard', () {
    test('wraps a returned value in Success', () async {
      final result = await guard(() async => 3);

      expect(result, isA<Success<int>>().having((s) => s.data, 'data', 3));
    });

    test('turns a SQLite error into a DatabaseFailure', () async {
      final result = await guard<int>(
        () async => throw SqliteException(
          extendedResultCode: 10,
          message: 'disk I/O error',
        ),
      );

      expect(
        result,
        isA<Failure<int>>().having(
          (f) => f.failure,
          'failure',
          isA<DatabaseFailure>(),
        ),
      );
    });

    test('turns any other exception into an UnknownFailure', () async {
      final result = await guard<int>(
        () async => throw const _OtherException(),
      );

      expect(
        result,
        isA<Failure<int>>().having(
          (f) => f.failure,
          'failure',
          isA<UnknownFailure>(),
        ),
      );
    });

    test('guard turns CheckedFromJsonException into ParsingFailure', () async {
      final result = await guard<int>(
        () async =>
            throw CheckedFromJsonException({}, 'priceMmk', 'ProductDto', 'bad'),
      );

      expect(_failureOf(result), isA<ParsingFailure>());
    });

    test('guard turns FormatException into ParsingFailure', () async {
      final result = await guard<int>(
        () async => throw const FormatException('bad'),
      );

      expect(_failureOf(result), isA<ParsingFailure>());
    });

    test('a receive timeout becomes TimeoutFailure', () async {
      final result = await guard<int>(
        () async => throw DioException.receiveTimeout(
          timeout: const Duration(seconds: 8),
          requestOptions: RequestOptions(),
        ),
      );

      expect(_failureOf(result), isA<TimeoutFailure>());
    });

    test('a 500 becomes ServerFailure with status 500', () async {
      final options = RequestOptions();
      final result = await guard<int>(
        () async => throw DioException.badResponse(
          statusCode: 500,
          requestOptions: options,
          response: Response<void>(requestOptions: options, statusCode: 500),
        ),
      );

      expect(
        _failureOf(result),
        isA<ServerFailure>().having((f) => f.statusCode, 'statusCode', 500),
      );
    });

    test('a SocketException becomes NetworkFailure', () async {
      final result = await guard<int>(
        () async => throw DioException.connectionError(
          requestOptions: RequestOptions(),
          reason: 'offline',
          error: const SocketException('offline'),
        ),
      );

      expect(_failureOf(result), isA<NetworkFailure>());
    });

    test('ApiException becomes ServerFailure', () async {
      final result = await guard<int>(
        () async => throw const ApiException('not_found', 'No catalog'),
      );

      expect(_failureOf(result), isA<ServerFailure>());
    });

    test('lets programming errors through instead of hiding them', () {
      expect(guard<int>(() async => throw StateError('bug')), throwsStateError);
    });
  });
}

AppFailure? _failureOf<T>(Result<T> result) => switch (result) {
  Failure(:final failure) => failure,
  Success() => null,
};

class _OtherException implements Exception {
  const new();
}
