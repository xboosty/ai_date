import '../../../domain/domain.dart' show BlockRepository, UserEntity;

class NtsBlockRepository extends BlockRepository<UserEntity> {
  NtsBlockRepository({required super.datasource});

  @override
  Future<bool> bloquedUserByIdRepository({required int id}) async {
    final bool isBloqued = await datasource.bloquedUserById(id: id);
    return isBloqued;
  }

  @override
  Future<bool> unbloquedUserByIdRepository({required int id}) async {
    final bool isUnbloqued = await datasource.unbloquedUserById(id: id);
    return isUnbloqued;
  }

  @override
  Future<List<UserEntity>> userBloquedListRepository() async {
    final List<UserEntity> usersBloqued = await datasource.userBloquedList();
    return usersBloqued;
  }
}
