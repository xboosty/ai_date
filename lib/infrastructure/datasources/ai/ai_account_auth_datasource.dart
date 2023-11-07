import 'package:dio/dio.dart';

import '../../../config/config.dart'
    show AiSecurityTokenResponse, SecurityMapper, SharedPref;
import '../../../domain/domain.dart'
    show AccountDatasource, SecurityTokenEntity, UserEntity;

class AIAccountAuthDatasource extends AccountDatasource<UserEntity> {
  AIAccountAuthDatasource._();

  static final dai = AIAccountAuthDatasource._();

  final dio = Dio(
    BaseOptions(
      baseUrl: 'http://ec2-54-162-234-51.compute-1.amazonaws.com:9000',
    ),
  );

  @override
  Future<bool> changePasswordAccount(Map<String, dynamic> passwords) {
    // TODO: implement changePasswordAccount
    throw UnimplementedError();
  }

  @override
  Future<bool> forgotPasswordAccount({required String email}) {
    // TODO: implement forgotPasswordAccount
    throw UnimplementedError();
  }

  @override
  Future<UserEntity> logIn(Map<String, dynamic> credential) {
    // TODO: implement logIn
    throw UnimplementedError();
  }

  @override
  Future<UserEntity?> logInSocial(String token) {
    // TODO: implement logInSocial
    throw UnimplementedError();
  }

  @override
  Future<bool> logOut() {
    // TODO: implement logOut
    throw UnimplementedError();
  }

  @override
  Future<bool> recoveryPassword(Map<String, dynamic> recoveryCredentilal) {
    // TODO: implement recoveryPassword
    throw UnimplementedError();
  }

  @override
  Future<UserEntity> registerUser(Map<String, dynamic> user) async {
    final rs = await dio.post('/users/users', data: user);

    if (rs.statusCode == 200) {
    } else {
      print('hubo un error');
    }

    throw UnimplementedError();
  }

  @override
  Future<UserEntity> registerUserSocial(Map<String, dynamic> user) {
    // TODO: implement registerUserSocial
    throw UnimplementedError();
  }

  @override
  Future<UserEntity> updateAccount(FormData userUpdate) {
    // TODO: implement updateAccount
    throw UnimplementedError();
  }

  @override
  Future<bool> verificationAccount(Map<String, dynamic> verification) {
    // TODO: implement verificationAccount
    throw UnimplementedError();
  }

  Future<SecurityTokenEntity> getSecurityToken() async {
    try {
      final rs = await dio.get('/security/token');

      if (rs.statusCode == 200) {
        // Save Token
        String? tokenAI = rs.data['access_token'];
        SharedPref.pref.tokenAI = tokenAI ?? 'null';

        // Parse Response
        final securityResult = AiSecurityTokenResponse.fromJson(rs.data);

        final SecurityTokenEntity security =
            SecurityMapper.securityTResponseToEntity(securityResult);

        return security;
      } else {
        throw 'error getSecurityToken';
      }
    } catch (e) {
      rethrow;
    }
  }
}
