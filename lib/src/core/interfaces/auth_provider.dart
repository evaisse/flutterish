
/// The interface for handling authentication.
/// Mimics React-Admin's AuthProvider.
abstract class AuthProvider {
  /// Log the user in.
  Future<void> login(Map<String, dynamic> params);

  /// Log the user out.
  Future<void> logout();

  /// Check if the user is authenticated.
  /// Should throw if not authenticated.
  Future<void> checkAuth();

  /// Check if an error implies an authentication error (e.g. 401).
  Future<void> checkError(dynamic error);

  /// Get the permissions of the current user.
  Future<dynamic> getPermissions();
}
