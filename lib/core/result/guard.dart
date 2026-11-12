import 'package:donuts/core/result/app_failure.dart';
import 'package:donuts/core/result/result.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';

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
  } on Exception catch (e, s) {
    return Failure(UnknownFailure(error: e, stackTrace: s));
  }
}
