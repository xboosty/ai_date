import '../../domain/domain.dart' show UserEntity;
import '../models/ntsprint/nts_user_response.dart';

class UserMapper {
  // Mappers for NTSprint API

  static UserEntity userResponseToEntity(NtsUserResponse ur) {
    return UserEntity(
      name: ur.user.fullName,
      email: ur.user.email,
      birthDate: ur.user.birthDate ?? DateTime(1000),
      phone: ur.user.phone ?? 'null',
      gender: ur.user.gender,
      sexualOrientation: ur.user.sexualOrientation,
      identity: ur.user.identity ?? '',
      genderId: ur.user.genderId ?? -1,
      statusId: ur.user.statusId ?? -1,
      status: ur.user.status ?? '',
      avatar: ur.user.avatar,
      avatarMimeType: ur.user.avatarMimeType,
    );
  }
}
