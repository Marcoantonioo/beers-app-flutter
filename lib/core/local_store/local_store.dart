abstract class LocalStore {
  Future<void> setValue<T>(String key, T value);
  Future<T> getValue<T>(String key);
  Future<void> delete(String key);
}