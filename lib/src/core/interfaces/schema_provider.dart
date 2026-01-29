
/// Interface for fetching the UI configuration (Schema).
abstract class SchemaProvider {
  /// Fetches the global application schema (resources, layout, etc.)
  Future<Map<String, dynamic>> getSchema();
}
