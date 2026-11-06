import 'package:flutter_test/flutter_test.dart';
import 'package:hiddify/core/connection/nil_catcher_subscription.dart';

void main() {
  test('NIL subscription has bounded per-protocol selections', () {
    final uri = NilCatcherSubscription.build(
      protocols: {'vless', 'hysteria2'},
      perProtocol: 20,
    );
    expect(uri.scheme, 'https');
    expect(uri.path, '/api/subscription');
    expect(uri.queryParameters['format'], 'base64');
    expect(uri.queryParameters['protocols'], 'hysteria2,vless');
    expect(uri.queryParameters['limit'], '20');
  });
  test('NIL subscription rejects unsupported protocols and quotas', () {
    expect(() => NilCatcherSubscription.build(protocols: {'wireguard'}), throwsArgumentError);
    expect(() => NilCatcherSubscription.build(perProtocol: 500), throwsArgumentError);
    expect(() => NilCatcherSubscription.build(protocols: {}), throwsArgumentError);
  });
}
