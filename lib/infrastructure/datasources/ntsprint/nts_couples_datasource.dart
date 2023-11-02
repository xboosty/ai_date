import 'package:dio/dio.dart';
import '../../../domain/domain.dart' show CouplesDatasource, UserEntity;
import '../../../config/config.dart'
    show NtsCouplesUserResponse, NtsErrorResponse, SharedPref, UserMapper;

class NtSprintCouplesDatasource extends CouplesDatasource<UserEntity> {
  NtSprintCouplesDatasource._();

  static final ds = NtSprintCouplesDatasource._();

  // DIO Instance
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://x0lb3wkw74.execute-api.us-east-1.amazonaws.com/Prod',
    ),
  );

  @override
  Future<List<UserEntity>> getFakeCouples() async {
    try {
      final rs = await dio.get(
        '/api/account/users-list',
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
        final userResponse = NtsCouplesUserResponse.fromJson(rs.data);

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
