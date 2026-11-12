/// The API answered, but its envelope carried an error or no data.
class ApiException implements Exception {
  const new(this.code, this.message);

  final String code;
  final String message;

  @override
  String toString() => 'ApiException($code): $message';
}
