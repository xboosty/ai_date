import 'package:dio/dio.dart';

abstract class AccountDatasource<T> {
  Future<T> registerUser(Map<String, dynamic> user);

  Future<T> registerUserSocial(Map<String, dynamic> user);

  Future<bool> verificationAccount(Map<String, dynamic> verification);

  Future<T> logIn(Map<String, dynamic> credential);

  Future<T?> logInSocial(String token);

  Future<bool> logOut();

  Future<bool> changePasswordAccount(Map<String, dynamic> passwords);

  Future<bool> forgotPasswordAccount({required String email});

  Future<bool> recoveryPassword(Map<String, dynamic> recoveryCredentilal);

  Future<T> updateAccount(FormData userUpdate);
}
