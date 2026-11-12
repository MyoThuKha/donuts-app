import 'package:dio/dio.dart';
import 'package:donuts/core/network/retry_interceptor.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/scripted_adapter.dart';

void main() {
  late List<Duration> waits;

  Dio dioWith(ScriptedAdapter adapter) {
    final dio = scriptedDio(adapter);
    dio.interceptors.add(
      RetryInterceptor(dio: dio, wait: (delay) async => waits.add(delay)),
    );
    return dio;
  }

  setUp(() => waits = []);

  test('a GET that fails to connect twice then succeeds returns the response '
      'after 3 requests', () async {
    final adapter = ScriptedAdapter(const [
      ScriptedSocketFailure(),
      ScriptedSocketFailure(),
      ScriptedResponse(200, 'ok'),
    ]);

    final response = await dioWith(adapter).get<String>('v1/catalog.json');

    expect(response.data, 'ok');
    expect(adapter.requests, hasLength(3));
  });

  test('a GET that keeps failing stops after 2 retries '
      'with delays of 500 ms and 1 s', () async {
    final adapter = ScriptedAdapter(const [ScriptedSocketFailure()]);

    await expectLater(
      dioWith(adapter).get<String>('v1/catalog.json'),
      throwsA(isA<DioException>()),
    );
    expect(adapter.requests, hasLength(3));
    expect(waits, const [Duration(milliseconds: 500), Duration(seconds: 1)]);
  });

  test('a GET that gets a 503 is retried', () async {
    final adapter = ScriptedAdapter(const [
      ScriptedResponse(503),
      ScriptedResponse(200, 'ok'),
    ]);

    final response = await dioWith(adapter).get<String>('v1/catalog.json');

    expect(response.data, 'ok');
    expect(adapter.requests, hasLength(2));
  });

  test('a POST is never retried', () async {
    final adapter = ScriptedAdapter(const [ScriptedSocketFailure()]);

    await expectLater(
      dioWith(adapter).post<String>('v1/catalog.json'),
      throwsA(isA<DioException>()),
    );
    expect(adapter.requests, hasLength(1));
  });

  test('a 404 is not retried', () async {
    final adapter = ScriptedAdapter(const [ScriptedResponse(404)]);

    await expectLater(
      dioWith(adapter).get<String>('v1/catalog.json'),
      throwsA(isA<DioException>()),
    );
    expect(adapter.requests, hasLength(1));
  });
}
