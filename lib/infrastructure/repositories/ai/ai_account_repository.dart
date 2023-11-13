import 'package:dio/dio.dart';

import '../../../domain/domain.dart'
    show AccountRepository, SecurityTokenEntity, AiUserEntity;
import '../../datasources/ai/ai_account_auth_datasource.dart';

class AIAccountRepository extends AccountRepository<AiUserEntity> {
  AIAccountRepository({required super.datasource});

  @override
  Future<bool> changePasswordRepository(Map<String, dynamic> passwords) {
    // TODO: implement changePasswordRepository
    throw UnimplementedError();
  }

  @override
  Future<bool> forgotPasswordRepository({required String email}) {
    // TODO: implement forgotPasswordRepository
    throw UnimplementedError();
  }

  @override
  Future<bool> logOutRepository() {
    // TODO: implement logOutRepository
    throw UnimplementedError();
  }

  @override
  Future<bool> recoveryPassword(Map<String, dynamic> recoveryCredentilal) {
    // TODO: implement recoveryPassword
    throw UnimplementedError();
  }

  @override
  Future<AiUserEntity> registerUserRepository(Map<String, dynamic> user) async {
    final AiUserEntity aiUserEntity = await datasource.registerUser(user);
    return aiUserEntity;
  }

  @override
  Future<AiUserEntity> registerUserSocialRepository(Map<String, dynamic> user) {
    // TODO: implement registerUserSocialRepository
    throw UnimplementedError();
  }

  @override
  Future<AiUserEntity> signInUserRepository(Map<String, dynamic> credentials) {
    // TODO: implement signInUserRepository
    throw UnimplementedError();
  }

  @override
  Future<AiUserEntity?> signInUserSocialRepository(String token) {
    // TODO: implement signInUserSocialRepository
    throw UnimplementedError();
  }

  @override
  Future<AiUserEntity> updateAccountRepository(FormData userUpdate) {
    // TODO: implement updateAccountRepository
    throw UnimplementedError();
  }

  @override
  Future<bool> verificationCodeRepository(Map<String, dynamic> verify) {
    // TODO: implement verificationCodeRepository
    throw UnimplementedError();
  }

  Future<SecurityTokenEntity> securityTokenRepository() async {
    final security = await AIAccountAuthDatasource.ds.getSecurityToken();
    return security;
  }
}
