import '../datasources/block_datasource.dart';

abstract class BlockRepository<T> {
  BlockRepository({required this.datasource});
  final BlockDatasource<T> datasource;

  Future<List<T>> userBloquedListRepository();

  Future<bool> bloquedUserByIdRepository({required int id});

  Future<bool> unbloquedUserByIdRepository({required int id});
}
