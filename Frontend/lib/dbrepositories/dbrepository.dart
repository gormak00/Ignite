abstract class DbRepository<T> {
  Future<T> get(String id);
  Future<List<T>> getAll();
  Future<T> insert(T object);
  Future<T> update(T object);
  Future<void> delete(String id);
  Future<void> deleteAll();
  Future<bool> exists(String id);
}
