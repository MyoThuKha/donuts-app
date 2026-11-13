import 'package:donuts/core/network/reachability_probe.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/scripted_adapter.dart';

HeadReachabilityProbe _probe(ScriptedReply reply) => HeadReachabilityProbe(
  scriptedDio(ScriptedAdapter([reply])),
  Uri.parse('https://example.com/mock-api/v1/catalog.json'),
);

void main() {
  test('the HEAD probe returns false when the connection fails', () async {
    expect(await _probe(const ScriptedSocketFailure())(), isFalse);
  });

  test(
    'the HEAD probe returns true on a 404, because the host answered',
    () async {
      expect(await _probe(const ScriptedResponse(404))(), isTrue);
    },
  );

  test('the HEAD probe sends a HEAD request', () async {
    final adapter = ScriptedAdapter(const [ScriptedResponse(200)]);
    await HeadReachabilityProbe(
      scriptedDio(adapter),
      Uri.parse('https://example.com/mock-api/v1/catalog.json'),
    )();

    expect(adapter.requests.single.method, 'HEAD');
  });
}
