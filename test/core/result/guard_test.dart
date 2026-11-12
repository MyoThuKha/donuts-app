import 'package:donuts/core/result/app_failure.dart';
import 'package:donuts/core/result/guard.dart';
import 'package:donuts/core/result/result.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

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
        () async => throw const FormatException('bad'),
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

    test('lets programming errors through instead of hiding them', () {
      expect(guard<int>(() async => throw StateError('bug')), throwsStateError);
    });
  });
}
