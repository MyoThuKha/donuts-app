import 'dart:io';

import 'package:dio/dio.dart';
import 'package:donuts/core/network/api_exception.dart';
import 'package:donuts/core/result/app_failure.dart';
import 'package:donuts/core/result/result.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:json_annotation/json_annotation.dart';

/// Runs [run] and turns its outcome into a [Result]. Repositories call this,
/// and nothing above them sees an exception.
///
/// Only [Exception]s become failures. An [Error] is a bug, so it rethrows.
Future<Result<T>> guard<T>(Future<T> Function() run) async {
  try {
    return Success(await run());
  } on SqliteException catch (e, s) {
    return Failure(DatabaseFailure(error: e, stackTrace: s));
  } on DriftWrappedException catch (e, s) {
    return Failure(DatabaseFailure(error: e, stackTrace: s));
  } on DioException catch (e, s) {
    return Failure(_fromDio(e, s));
  } on ApiException catch (e, s) {
    return Failure(ServerFailure(error: e, stackTrace: s));
  } on CheckedFromJsonException catch (e, s) {
    return Failure(ParsingFailure(error: e, stackTrace: s));
  } on FormatException catch (e, s) {
    return Failure(ParsingFailure(error: e, stackTrace: s));
  } on Exception catch (e, s) {
    return Failure(UnknownFailure(error: e, stackTrace: s));
  }
}

AppFailure _fromDio(DioException e, StackTrace s) => switch (e.type) {
  DioExceptionType.connectionTimeout ||
  DioExceptionType.sendTimeout ||
  DioExceptionType.receiveTimeout => TimeoutFailure(error: e, stackTrace: s),
  DioExceptionType.badResponse => ServerFailure(
    statusCode: e.response?.statusCode,
    error: e,
    stackTrace: s,
  ),
  DioExceptionType.connectionError => NetworkFailure(error: e, stackTrace: s),
  DioExceptionType.unknown when e.error is SocketException => NetworkFailure(
    error: e,
    stackTrace: s,
  ),
  _ => UnknownFailure(error: e, stackTrace: s),
};
