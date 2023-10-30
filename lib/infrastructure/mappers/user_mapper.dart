import '../../domain/domain.dart' show UserEntity;
import '../models/ntsprint/user_response.dart';

class UserMapper {
  // Mappers for NTSprint API
  static UserEntity userResponseToEntity(UserResponse user) {
    return UserEntity(
      id: user.id,
      name: user.fullName,
      email: user.email,
      birthDate: user.birthDate ?? DateTime(1000),
      phone: user.phone ?? 'null',
      gender: user.gender,
      sexualOrientation: user.sexualOrientation,
      identity: user.identity ?? '',
      genderId: user.genderId ?? -1,
      statusId: user.statusId ?? -1,
      status: user.status ?? '',
      avatar: user.avatar,
      avatarMimeType: user.avatarMimeType,
      isGenderVisible: user.isGenderVisible ?? false,
      isSexualityVisible: user.isSexualityVisible ?? false,
    );
  }
}
