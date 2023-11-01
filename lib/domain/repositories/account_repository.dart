import '../datasources/account_datasource.dart';

abstract class AccountRepository<T> {
  AccountRepository({required this.datasource});
  final AccountDatasource<T> datasource;

  Future<T> registerUserRepository(Map<String, dynamic> user);

  Future<T> registerUserSocialRepository(Map<String, dynamic> user);

  Future<T> signInUserRepository(Map<String, dynamic> credentials);

  Future<T?> signInUserSocialRepository(String token);

  Future<bool> verificationCodeRepository(Map<String, dynamic> verify);

  Future<bool> logOutRepository();

  Future<bool> changePasswordRepository(Map<String, dynamic> passwords);

  Future<bool> forgotPasswordRepository({required String email});

  Future<bool> recoveryPassword(Map<String, dynamic> recoveryCredentilal);
}
