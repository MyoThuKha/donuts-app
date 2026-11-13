import 'dart:async';
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
  } on Exception catch (e, s) {
    return Failure(failureFrom(e, s));
  }
}

/// The stream form of [guard], for repositories that follow the database.
extension GuardedStream<T> on Stream<T> {
  /// Turns every [Exception] the stream emits into its [AppFailure], so a
  /// cubit following a repository stream gets the same typed failures as a
  /// [Result]. An [Error] passes through unchanged, because it is a bug.
  Stream<T> guarded() => transform(
    StreamTransformer.fromHandlers(
      handleError: (error, stackTrace, sink) => sink.addError(
        error is Exception ? failureFrom(error, stackTrace) : error,
        stackTrace,
      ),
    ),
  );
}

/// The [AppFailure] that [e] stands for.
AppFailure failureFrom(Exception e, StackTrace s) => switch (e) {
  SqliteException() ||
  DriftWrappedException() => DatabaseFailure(error: e, stackTrace: s),
  DioException() => _fromDio(e, s),
  ApiException() => ServerFailure(error: e, stackTrace: s),
  CheckedFromJsonException() ||
  FormatException() => ParsingFailure(error: e, stackTrace: s),
  _ => UnknownFailure(error: e, stackTrace: s),
};

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
