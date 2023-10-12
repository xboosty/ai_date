import 'package:dio/dio.dart';

import '../../../domain/domain.dart' show AccountDatasource, UserEntity;
import '../../infrastructure.dart'
    show NtsErrorResponse, NtsUserResponse, NtsVerificationResponse, UserMapper;

class NtsAccountAuthDatasource extends AccountDatasource<UserEntity> {
  NtsAccountAuthDatasource._();
  static final ds = NtsAccountAuthDatasource._();

  // DIO Instance
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://x0lb3wkw74.execute-api.us-east-1.amazonaws.com/Prod',
    ),
  );

  final Map<String, dynamic> _headers = {
    'Content-Type': 'application/json',
    'User-Agent':
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/117.0.0.0 Safari/537.36 Edg/117.0.2045.60',
  };

  @override
  Future<UserEntity> registerUser(Map<String, dynamic> user) async {
    try {
      final rs = await dio.post(
        '/api/account/register',
        data: user,
        options: Options(
          headers: _headers,
          followRedirects: false,
          // will not throw errors
          validateStatus: (status) => true,
          // headers: headers,
        ),
      );

      if (rs.data["statusCode"] == 200) {
        final userResponse = NtsUserResponse.fromJson(rs.data);

        // Parsed to model response to entity
        final UserEntity userResult =
            UserMapper.userResponseToEntity(userResponse);

        return userResult;
        // Devuelve la entidad
      } else {
        // Devuelve un error
        throw NtsErrorResponse.fromJson(rs.data);
      }
    } catch (e) {
      rethrow;
    }

    // Make Request

    // Parsed Response
  }

  @override
  Future<UserEntity> logIn(Map<String, dynamic> credential) async {
    try {
      // Make Request
      final rs = await dio.post(
        '/api/account/login',
        data: credential,
        options: Options(
          headers: _headers,
          followRedirects: false,
          // will not throw errors
          validateStatus: (status) => true,
          // headers: headers,
        ),
      );

      if (rs.data["statusCode"] == 200) {
        final userResponse = NtsUserResponse.fromJson(rs.data);

        // Parsed to model response to entity
        final UserEntity userResult =
            UserMapper.userResponseToEntity(userResponse);

        return userResult;
        // Devuelve la entidad
      } else {
        // Devuelve un error
        throw NtsErrorResponse.fromJson(rs.data);
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> logOut() async {
    try {
      // Make Request
      final rs = await dio.post(
        '/api/account/logout',
        options: Options(
          headers: _headers,
          followRedirects: false,
          // will not throw errors
          validateStatus: (status) => true,
        ),
      );

      if (rs.data["statusCode"] == 200) {
        final isLogOutResponse = NtsVerificationResponse.fromJson(rs.data);

        if (isLogOutResponse.result ?? false) {
          return true;
        } else {
          return false;
        }
        // Devuelve la entidad
      } else {
        // Devuelve un error
        throw NtsErrorResponse.fromJson(rs.data);
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> verificationAccount(Map<String, dynamic> verification) async {
    try {
      // Make Request
      final rs = await dio.post(
        '/api/account/verify-code',
        data: verification,
        options: Options(
          headers: _headers,
          followRedirects: false,
          // will not throw errors
          validateStatus: (status) => true,
          // headers: headers,
        ),
      );

      if (rs.data["statusCode"] == 200) {
        final verificationResponse = NtsVerificationResponse.fromJson(rs.data);

        if (verificationResponse.result ?? false) {
          return true;
        } else {
          return false;
        }
      } else {
        // Devuelve un error
        throw NtsErrorResponse.fromJson(rs.data);
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> changePasswordAccount(Map<String, dynamic> passwords) async {
    try {
      final rs = await dio.post(
        '/api/account/verify-code',
        data: passwords,
        options: Options(
          headers: _headers,
          followRedirects: false,
          // will not throw errors
          validateStatus: (status) => true,
          // headers: headers,
        ),
      );

      if (rs.data["statusCode"] == 200) {
        final bool isChangePassword = rs.data as bool;
        return isChangePassword;
      } else {
        // Devuelve un error
        throw NtsErrorResponse.fromJson(rs.data);
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> forgotPasswordAccount(
      {required String code, required String number}) async {
    try {
      final rs = await dio.post(
        '/api/account/forgot-password',
        data: {
          "phone": {"code": code, "number": number}
        },
        options: Options(
          headers: _headers,
          followRedirects: false,
          // will not throw errors
          validateStatus: (status) => true,
          // headers: headers,
        ),
      );

      if (rs.data["statusCode"] == 200) {
        final bool isSendCode = rs.data as bool;
        return isSendCode;
      } else {
        // Devuelve un error
        throw NtsErrorResponse.fromJson(rs.data);
      }
    } catch (e) {
      rethrow;
    }
  }
}
