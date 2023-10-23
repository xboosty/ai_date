abstract class BlockDatasource<T> {
  Future<List<T>> userBloquedList();

  Future<bool> bloquedUserById({required int id});

  Future<bool> unbloquedUserById({required int id});
}
