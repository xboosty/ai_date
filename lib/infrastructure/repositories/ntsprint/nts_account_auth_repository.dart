import '../../../domain/domain.dart' show AccountRepository, UserEntity;

class NtsAccountAuthRepository extends AccountRepository<UserEntity> {
  NtsAccountAuthRepository({required super.datasource});

  @override
  Future<UserEntity> registerUserRepository(Map<String, dynamic> user) async {
    final UserEntity userEntity = await datasource.registerUser(user);
    return userEntity;
  }

  @override
  Future<bool> verificationCodeRepository(Map<String, dynamic> verify) async {
    final bool isVerify = await datasource.verificationAccount(verify);
    return isVerify;
  }

  @override
  Future<UserEntity> signInUserRepository(
      Map<String, dynamic> credentials) async {
    final UserEntity user = await datasource.logIn(credentials);
    return user;
  }
}
