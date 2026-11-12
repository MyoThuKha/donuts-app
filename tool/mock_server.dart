// A developer tool, so printing to the console is its job.
// ignore_for_file: avoid_print
import 'dart:async';
import 'dart:io';

/// Serves `mock-api/` over HTTP, so a phone or simulator can run the app
/// against a local copy of the mock API.
///
/// It listens on loopback only. The iOS Simulator shares the Mac's loopback,
/// and a USB Android phone reaches it through `adb reverse`.
///
/// ```sh
/// dart run tool/mock_server.dart [--port 8080] [--delay-ms 0]
/// ```
Future<void> main(List<String> args) async {
  final port = int.parse(_option(args, '--port') ?? '8080');
  final delay = Duration(
    milliseconds: int.parse(_option(args, '--delay-ms') ?? '0'),
  );
  final root = Directory('mock-api').absolute;
  final server = await HttpServer.bind(InternetAddress.loopbackIPv4, port);

  print('Serving ${root.path} on http://localhost:$port/');
  print('Run the app with --dart-define=API_BASE_URL=http://localhost:$port/');
  print('For a USB Android phone, first run: adb reverse tcp:$port tcp:$port');

  await for (final request in server) {
    await Future<void>.delayed(delay);
    await _serve(request, root);
  }
}

Future<void> _serve(HttpRequest request, Directory root) async {
  final response = request.response;
  final method = request.method;
  final file = resolveMockFile(root, request.uri);
  print('$method ${request.uri.path}');
  if ((method != 'GET' && method != 'HEAD') || file == null) {
    response.statusCode = HttpStatus.notFound;
  } else {
    response.headers.contentType = ContentType.json;
    if (method == 'GET') await response.addStream(file.openRead());
  }
  await response.close();
}

/// The file under [root] for [uri], or null when it doesn't exist or the
/// path escapes [root].
File? resolveMockFile(Directory root, Uri uri) {
  final segments = uri.pathSegments.where((s) => s.isNotEmpty).toList();
  // pathSegments are decoded, so `%2F` arrives as a `/` inside a segment.
  final escapes = segments.any(
    (s) => s == '..' || s == '.' || s.contains('/') || s.contains(r'\'),
  );
  if (escapes) return null;
  final file = File([root.path, ...segments].join(Platform.pathSeparator));
  final insideRoot = file.absolute.path.startsWith(root.path);
  return insideRoot && file.existsSync() ? file : null;
}

String? _option(List<String> args, String name) {
  final index = args.indexOf(name);
  return index >= 0 && index + 1 < args.length ? args[index + 1] : null;
}
