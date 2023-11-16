import '../../domain/domain.dart' show AiUserEntity, UserEntity;
import '../models/ai/ai_user_response.dart';
import '../models/ntsprint/user_response.dart';

class UserMapper {
  // Mappers for NTSprint API
  static UserEntity userResponseToEntity(UserResponse user) {
    return UserEntity(
      id: user.id,
      name: user.fullName,
      lastName: user.lastName ?? '',
      email: user.email,
      birthDate: user.birthDate ?? DateTime(1000),
      phone: user.phone ?? '',
      gender: user.gender,
      sexualOrientation: user.sexualOrientation,
      sexualityId: user.sexualityId ?? -1,
      identity: user.identity ?? '',
      genderId: user.genderId ?? -1,
      statusId: user.statusId ?? -1,
      status: user.status ?? '',
      avatar: user.avatar,
      avatarMimeType: user.avatarMimeType,
      isGenderVisible: user.isGenderVisible ?? false,
      isSexualityVisible: user.isSexualityVisible ?? false,
      pictures: user.pictures,
    );
  }

  // userJsonToEntity
  static AiUserEntity aiUserResponseToEntity(AiUserResponse user) {
    return AiUserEntity(
      id: user.id ?? -1,
      email: user.email ?? '',
      avatar: user.avatar ?? '',
    );
  }
}
