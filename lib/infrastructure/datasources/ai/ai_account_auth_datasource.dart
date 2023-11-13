import 'package:ai_date/infrastructure/infrastructure.dart';
import 'package:dio/dio.dart';

import '../../../config/config.dart'
    show AiSecurityTokenResponse, SecurityMapper, SharedPref;
import '../../../domain/domain.dart'
    show AccountDatasource, SecurityTokenEntity, AiUserEntity;

class AIAccountAuthDatasource extends AccountDatasource<AiUserEntity> {
  AIAccountAuthDatasource._();

  static final ds = AIAccountAuthDatasource._();

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
  Future<AiUserEntity> logIn(Map<String, dynamic> credential) {
    // TODO: implement logIn
    throw UnimplementedError();
  }

  @override
  Future<AiUserEntity?> logInSocial(String token) {
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
  Future<AiUserEntity> registerUser(Map<String, dynamic> user) async {
    try {
      final rs = await dio.post(
        '/users/users',
        data: user,
        options: Options(
          headers: {
            'Authorization': SharedPref.pref.tokenAI,
          },
        ),
      );
      if (rs.statusCode == 200) {
        final userResponse = AiUserResponse.fromJson(rs.data);
        // Parsed to model response to entity
        final AiUserEntity aiUserResult =
            UserMapper.aiUserResponseToEntity(userResponse);

        return aiUserResult;
      } else {
        // Devuelve un error
        throw Exception(rs.statusMessage);
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<AiUserEntity> registerUserSocial(Map<String, dynamic> user) {
    // TODO: implement registerUserSocial
    throw UnimplementedError();
  }

  @override
  Future<AiUserEntity> updateAccount(FormData userUpdate) {
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
