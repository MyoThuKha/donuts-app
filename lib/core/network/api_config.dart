/// Where the mock API lives and how long the app waits for it.
class ApiConfig {
  const new({required this.baseUrl});

  /// Reads `--dart-define=API_BASE_URL`, falling back to the `main` branch
  /// on GitHub raw.
  factory fromEnvironment() => const ApiConfig(
    baseUrl: String.fromEnvironment(
      'API_BASE_URL',
      defaultValue: defaultBaseUrl,
    ),
  );

  static const String defaultBaseUrl =
      'https://raw.githubusercontent.com/MyoThuKha/donuts-app/main/mock-api/';
  static const String catalogPath = 'v1/catalog.json';
  static const Duration connectTimeout = Duration(seconds: 8);
  static const Duration receiveTimeout = Duration(seconds: 8);
  static const Duration probeTimeout = Duration(seconds: 3);

  final String baseUrl;

  /// The base that relative paths in the API's data resolve against, such
  /// as an image path like `assets/home/shop.jpg`.
  Uri get baseUri => Uri.parse(baseUrl);

  Uri get catalogUri => baseUri.resolve(catalogPath);
}
