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

  @override
  Future<bool> logOutRepository() async {
    final bool isLogOut = await datasource.logOut();
    return isLogOut;
  }

  @override
  Future<bool> changePasswordRepository(Map<String, dynamic> passwords) async {
    final bool isChangedPassword =
        await datasource.changePasswordAccount(passwords);
    return isChangedPassword;
  }

  @override
  Future<bool> forgotPasswordRepository(
      {required String code, required String number}) async {
    final bool isForgetChangedPassword =
        await datasource.forgotPasswordAccount(code: code, number: number);
    return isForgetChangedPassword;
  }
}
