/// NIL Config Catcher integration for the existing Hiddify/sing-box client.
/// A subscription is a remote profile; connection remains owned by the
/// existing native VPN controller (never by a WebView).
///
/// No credentials or private server addresses are persisted by this module.
class NilCatcherSubscription {
  static const origin = 'https://nil-config-catcher.babak-yaghoobi23.workers.dev';
  static const supported = <String>{
    'vless', 'vmess', 'trojan', 'ss', 'hysteria2', 'tuic',
  };
  static const limits = <int>{5, 10, 20, 50, 100};

  /// Builds the actual collector API subscription URL used by profile import.
  /// Import it as a *remote subscription* through the existing profile flow.
  static Uri build({
    Set<String> protocols = supported,
    int perProtocol = 10,
    String title = 'NIL Proxy',
  }) {
    if (protocols.isEmpty || !supported.containsAll(protocols)) {
      throw ArgumentError.value(protocols, 'protocols', 'Unsupported protocol');
    }
    if (!limits.contains(perProtocol)) {
      throw ArgumentError.value(perProtocol, 'perProtocol', 'Invalid quota');
    }
    if (title.isEmpty || title.length > 80 || title.contains(RegExp(r'[\x00-\x1f\x7f]'))) {
      throw ArgumentError.value(title, 'title', 'Invalid profile title');
    }
    final sorted = protocols.toList()..sort();
    return Uri.parse('$origin/api/subscription').replace(queryParameters: {
      'protocol': 'all',
      'source': 'all',
      'q': '',
      'format': 'base64',
      'title': title,
      'limit': '$perProtocol',
      'protocols': sorted.join(','),
    });
  }
}
