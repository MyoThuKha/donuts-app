import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';

/// One scripted reply: a status and body, or a socket failure.
sealed class ScriptedReply {
  const new();
}

final class ScriptedResponse extends ScriptedReply {
  const new(this.statusCode, [this.body = '']);

  final int statusCode;
  final String body;
}

final class ScriptedSocketFailure extends ScriptedReply {
  const new();
}

/// Replays [replies] in order, one per request, and repeats the last one
/// when the queue runs out.
class ScriptedAdapter implements HttpClientAdapter {
  new(this.replies);

  final List<ScriptedReply> replies;
  final List<RequestOptions> requests = [];

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    final index = requests.length.clamp(0, replies.length - 1);
    requests.add(options);
    return switch (replies[index]) {
      ScriptedResponse(:final statusCode, :final body) =>
        ResponseBody.fromString(
          body,
          statusCode,
          headers: {
            Headers.contentTypeHeader: ['text/plain; charset=utf-8'],
          },
        ),
      ScriptedSocketFailure() => throw const SocketException('offline'),
    };
  }

  @override
  void close({bool force = false}) {}
}

/// A Dio on [adapter] with the app's base URL shape.
Dio scriptedDio(ScriptedAdapter adapter) => Dio(
  BaseOptions(
    baseUrl: 'https://example.com/mock-api/',
    responseType: ResponseType.plain,
  ),
)..httpClientAdapter = adapter;

/// [object] encoded as a response body.
String jsonBody(Object object) => jsonEncode(object);
