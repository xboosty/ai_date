import 'package:dio/dio.dart';
import '../../../domain/domain.dart' show BlockDatasource, UserEntity;
export '../../../domain/domain.dart' show UserEntity;
import '../../../config/config.dart'
    show NtsBlockedUserResponse, NtsErrorResponse, SharedPref, UserMapper;

class NtSprintBlockDatasource extends BlockDatasource<UserEntity> {
  NtSprintBlockDatasource._();

  static final ds = NtSprintBlockDatasource._();

  // DIO Instance
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://x0lb3wkw74.execute-api.us-east-1.amazonaws.com/Prod',
    ),
  );

  @override
  Future<bool> bloquedUserById({required int id}) async {
    try {
      final rs = await dio.post(
        '/api/block/blockUser',
        queryParameters: {'blockedUserId': id},
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
  Future<bool> unbloquedUserById({required int id}) async {
    try {
      final rs = await dio.post(
        '/api/block/unblockUser',
        queryParameters: {'blockedUserId': id},
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
  Future<List<UserEntity>> userBloquedList() async {
    try {
      final rs = await dio.get(
        '/api/block/block-user-list',
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
        final userResponse = NtsBlockedUserResponse.fromJson(rs.data);

        // Parsed to model response to entity
        final List<UserEntity> usersResult = userResponse.result
                ?.map((user) => UserMapper.userResponseToEntity(user))
                .toList() ??
            [];

        return usersResult;
      } else {
        // Devuelve un error
        throw NtsErrorResponse.fromJson(rs.data);
      }
    } catch (e) {
      rethrow;
    }
  }
}
