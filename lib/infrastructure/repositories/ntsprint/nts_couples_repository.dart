import '../../../domain/domain.dart' show CouplesRepository, UserEntity;

class NtsCouplesRepository extends CouplesRepository<UserEntity> {
  NtsCouplesRepository({required super.datasource});

  @override
  Future<List<UserEntity>> getFakeCouplesRepository() async {
    final List<UserEntity> fakeCouples = await datasource.getFakeCouples();
    return fakeCouples;
  }
}
