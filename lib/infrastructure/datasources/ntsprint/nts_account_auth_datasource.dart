import 'package:dio/dio.dart';

import '../../../domain/domain.dart' show AccountDatasource, UserEntity;
import '../../infrastructure.dart'
    show NtsUserResponse, NtsVerificationResponse, UserMapper;

class NtsAccountAuthDatasource extends AccountDatasource<UserEntity> {
  NtsAccountAuthDatasource._();
  static final ds = NtsAccountAuthDatasource._();

  // DIO Instance
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://x0lb3wkw74.execute-api.us-east-1.amazonaws.com/Prod',
    ),
  );

  @override
  Future<UserEntity> registerUser(Map<String, dynamic> user) async {
    // Make Request
    final rs = await dio.post(
      '/api/account/register',
      data: user,
      options: Options(
        followRedirects: false,
        // will not throw errors
        validateStatus: (status) => true,
        // headers: headers,
      ),
    );

    final userResponse = NtsUserResponse.fromJson(rs.data);

    // Parsed to model response to entity
    final UserEntity userResult = UserMapper.userResponseToEntity(userResponse);

    return userResult;
  }

  @override
  Future<UserEntity> logIn(Map<String, dynamic> credential) {
    // TODO: implement logIn
    throw UnimplementedError();
  }

  @override
  Future<bool> logOut() {
    // TODO: implement logOut
    throw UnimplementedError();
  }

  @override
  Future<bool> verificationAccount(Map<String, dynamic> verification) async {
    // Make Request
    final rs = await dio.post(
      '/api/account/verify-code',
      data: verification,
      options: Options(
        followRedirects: false,
        // will not throw errors
        validateStatus: (status) => true,
        // headers: headers,
      ),
    );

    final verificationResponse = NtsVerificationResponse.fromJson(rs.data);

    if (verificationResponse.result ?? false) {
      return true;
    } else {
      return false;
    }
  }
}
