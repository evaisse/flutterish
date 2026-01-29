
/// Result of a getList call
class GetListResult {
  final List<Map<String, dynamic>> data;
  final int total;

  GetListResult({required this.data, required this.total});
}

/// The interface for fetching data.
/// Mimics React-Admin's DataProvider.
abstract class DataProvider {
  /// Get a list of resources.
  Future<GetListResult> getList(
    String resource, {
    int page = 1,
    int perPage = 10,
    Map<String, dynamic>? filter,
    Map<String, dynamic>? sort,
  });

  /// Get a single resource by ID.
  Future<Map<String, dynamic>> getOne(String resource, String id);

  /// Update a resource.
  Future<Map<String, dynamic>> update(String resource, String id, Map<String, dynamic> data);

  /// Create a new resource.
  Future<Map<String, dynamic>> create(String resource, Map<String, dynamic> data);

  /// Delete a resource.
  Future<void> delete(String resource, String id);
}
