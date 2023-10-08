import '../datasources/account_datasource.dart';

abstract class AccountRepository<T> {
  AccountRepository({required this.datasource});
  final AccountDatasource<T> datasource;

  Future<T> registerUserRepository(Map<String, dynamic> user);

  Future<bool> verificationCodeRepository(Map<String, dynamic> verify);
}
