abstract class AccountDatasource<T> {
  Future<T> registerUser(Map<String, dynamic> user);

  Future<bool> verificationAccount(Map<String, dynamic> verification);

  Future<T> logIn(Map<String, dynamic> credential);

  Future<bool> logOut();
}
