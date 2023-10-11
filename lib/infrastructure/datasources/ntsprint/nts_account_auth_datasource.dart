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
        headers: {
          'Content-Type': 'application/json',
          'User-Agent':
              'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/117.0.0.0 Safari/537.36 Edg/117.0.2045.60',
        },
        followRedirects: false,
        // will not throw errors
        validateStatus: (status) => true,
        // headers: headers,
      ),
    );
    // Parsed Response
    final userResponse = NtsUserResponse.fromJson(rs.data);

    // Parsed to model response to entity
    final UserEntity userResult = UserMapper.userResponseToEntity(userResponse);

    return userResult;
  }

  @override
  Future<UserEntity> logIn(Map<String, dynamic> credential) async {
    // Make Request
    final rs = await dio.post(
      '/api/account/login',
      data: credential,
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'User-Agent':
              'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/117.0.0.0 Safari/537.36 Edg/117.0.2045.60',
        },
        followRedirects: false,
        // will not throw errors
        validateStatus: (status) => true,
        // headers: headers,
      ),
    );

    print('esto es response $rs');
    print('esto es response string ${rs.toString()}');
    print('esto es response string ${rs.statusCode.toString()}');

    // if ( rs.statusCode ) {

    // }

    final userResponse = NtsUserResponse.fromJson(rs.data);

    // Parsed to model response to entity
    final UserEntity userResult = UserMapper.userResponseToEntity(userResponse);

    return userResult;
  }

  @override
  Future<bool> logOut() async {
    // Make Request
    final rs = await dio.post(
      '/api/account/logout',
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'User-Agent':
              'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/117.0.0.0 Safari/537.36 Edg/117.0.2045.60',
        },
        followRedirects: false,
        // will not throw errors
        validateStatus: (status) => true,
      ),
    );

    final isLogOutResponse = NtsVerificationResponse.fromJson(rs.data);

    if (isLogOutResponse.result ?? false) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<bool> verificationAccount(Map<String, dynamic> verification) async {
    // Make Request
    final rs = await dio.post(
      '/api/account/verify-code',
      data: verification,
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'User-Agent':
              'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/117.0.0.0 Safari/537.36 Edg/117.0.2045.60',
        },
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

  @override
  Future<bool> changePasswordAccount(Map<String, dynamic> passwords) async {
    final rs = await dio.post(
      '/api/account/verify-code',
      data: passwords,
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'User-Agent':
              'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/117.0.0.0 Safari/537.36 Edg/117.0.2045.60',
        },
        followRedirects: false,
        // will not throw errors
        validateStatus: (status) => true,
        // headers: headers,
      ),
    );

    final bool isChangePassword = rs.data as bool;

    return isChangePassword;
  }

  @override
  Future<bool> forgotPasswordAccount(
      {required String code, required String number}) async {
    final rs = await dio.post(
      '/api/account/forgot-password',
      data: {
        "phone": {"code": code, "number": number}
      },
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'User-Agent':
              'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/117.0.0.0 Safari/537.36 Edg/117.0.2045.60',
        },
        followRedirects: false,
        // will not throw errors
        validateStatus: (status) => true,
        // headers: headers,
      ),
    );

    final bool isSendCode = rs.data as bool;

    return isSendCode;
  }
}
