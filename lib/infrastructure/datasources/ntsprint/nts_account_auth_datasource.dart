import 'package:dio/dio.dart';

import '../../../config/config.dart' show SharedPref;
import '../../../domain/domain.dart' show AccountDatasource, UserEntity;
import '../../infrastructure.dart'
    show
        NtsErrorResponse,
        NtsSocialAuthResponse,
        NtsUserResponse,
        NtsVerificationResponse,
        UserMapper;

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
        // Save Token in
        String? token = rs.headers.value('x-amzn-Remapped-Authorization');

        SharedPref.pref.token = token ?? 'null';
        final userResponse = NtsUserResponse.fromJson(rs.data);

        // Parsed to model response to entity
        final UserEntity userResult =
            UserMapper.userResponseToEntity(userResponse.user);

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
  Future<UserEntity> registerUserSocial(Map<String, dynamic> user) async {
    try {
      final rs = await dio.post(
        '/api/account/firebase-signup',
        data: user,
        options: Options(
          headers: _headers,
          followRedirects: false,
          validateStatus: (status) => true,
        ),
      );

      if (rs.data["statusCode"] == 200) {
        String? token = rs.headers.value('x-amzn-Remapped-Authorization');

        SharedPref.pref.token = token ?? 'null';
        final userResponse = NtsUserResponse.fromJson(rs.data);

        final UserEntity userResult =
            UserMapper.userResponseToEntity(userResponse.user);

        return userResult;
      } else {
        throw NtsErrorResponse.fromJson(rs.data);
      }
    } catch (e) {
      rethrow;
    }
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
      print('token ${rs.headers.value('x-amzn-Remapped-Authorization')}');

      // print('token nuevo: $token');
      if (rs.data["statusCode"] == 200) {
        // Save Token in
        String? token = rs.headers.value('x-amzn-Remapped-Authorization');

        SharedPref.pref.token = token ?? 'null';
        final userResponse = NtsUserResponse.fromJson(rs.data);

        // Parsed to model response to entity
        final UserEntity userResult =
            UserMapper.userResponseToEntity(userResponse.user);

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
  Future<UserEntity?> logInSocial(String token) async {
    try {
      final rs = await dio.get(
        '/api/account/firebase',
        queryParameters: {'idToken': token},
        options: Options(
          headers: _headers,
          followRedirects: false,
          validateStatus: (status) => true,
        ),
      );

      if (rs.data["statusCode"] == 200) {
        String? token = rs.headers.value('x-amzn-Remapped-Authorization');

        SharedPref.pref.token = token ?? 'null';
        final userResponse = NtsSocialAuthResponse.fromJson(rs.data);

        if (userResponse.user != null) {
          final UserEntity userResult =
              UserMapper.userResponseToEntity(userResponse.user!);
          return userResult;
        }

        return null;
      } else {
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
          headers: {
            'Authorization': SharedPref.pref.token,
            'Content-Type': 'application/json',
            'User-Agent':
                'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/117.0.0.0 Safari/537.36 Edg/117.0.2045.60',
          },
          followRedirects: false,
          // will not throw errors
          validateStatus: (status) => true,
        ),
      );
      print('esto es la respuesta ${rs.data}');
      if (rs.data["statusCode"] == 200) {
        // final isLogOutResponse = NtsVerificationResponse.fromJson(rs.data);
        return true;
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
        '/api/account/change-password',
        data: passwords,
        options: Options(
          headers: {
            'Authorization': SharedPref.pref.token,
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

      if (rs.data["statusCode"] == 200) {
        return true;
      } else {
        // Devuelve un error
        throw NtsErrorResponse.fromJson(rs.data);
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> forgotPasswordAccount({required String email}) async {
    try {
      final rs = await dio.post(
        '/api/account/forgot-password',
        data: {"email": email},
        options: Options(
          headers: _headers,
          followRedirects: false,
          // will not throw errors
          validateStatus: (status) => true,
          // headers: headers,
        ),
      );

      if (rs.data["statusCode"] == 200) {
        final bool isSendCode =
            rs.data["result"] == true ? rs.data["result"] : false;
        return isSendCode;
      } else {
        // Devuelve un error
        throw NtsErrorResponse.fromJson(rs.data);
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> recoveryPassword(
      Map<String, dynamic> recoveryCredentilal) async {
    // TODO: implement recoveryPassword
    try {
      final rs = await dio.post(
        '/api/account/recovery-password',
        data: recoveryCredentilal,
        options: Options(
          headers: _headers,
          followRedirects: false,
          // will not throw errors
          validateStatus: (status) => true,
          // headers: headers,
        ),
      );

      if (rs.data["statusCode"] == 200) {
        final bool isSendCode =
            rs.data["result"] == true ? rs.data["result"] : false;
        return isSendCode;
      } else {
        // Devuelve un error
        throw NtsErrorResponse.fromJson(rs.data);
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserEntity> updateAccount(Map<String, dynamic> userUpdate) async {
    try {
      final rs = await dio.post(
        '/api/account/edit-profile',
        data: userUpdate,
        options: Options(
          headers: _headers,
          followRedirects: false,
          // will not throw errors
          validateStatus: (status) => true,
          // headers: headers,
        ),
      );

      if (rs.data["statusCode"] == 200) {
        // Save Token in
        String? token = rs.headers.value('x-amzn-Remapped-Authorization');

        SharedPref.pref.token = token ?? 'null';
        final userResponse = NtsUserResponse.fromJson(rs.data);

        // Parsed to model response to entity
        final UserEntity userResult =
            UserMapper.userResponseToEntity(userResponse.user);

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
}
