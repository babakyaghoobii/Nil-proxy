/// Public service origin. The device reads the feed; collection runs on GitHub.
const nilCatcherOrigin = String.fromEnvironment(
  'NIL_API_ORIGIN',
  defaultValue: 'https://nil-config-catcher.babak-yaghoobi23.workers.dev',
);

final nilCatcherFeed = Uri.parse(nilCatcherOrigin).resolve('/api/subscription').replace(
  queryParameters: {'protocol': 'all', 'source': 'all', 'format': 'base64', 'title': 'Nil Config Catcher'},
);
