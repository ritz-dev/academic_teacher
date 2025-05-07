abstract class StorageInterface {
  Future<void> saveToken(String token);
  Future<String?> getToken();
  Future<void> deleteToken();
}