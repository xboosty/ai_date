import '../ai/security_token_entity.dart';

class UserEntity {
  final int? id;
  final DateTime birthDate;
  final String name;
  final String lastName;
  final String identity;
  final int genderId;
  final String gender;
  final String email;
  final String phone;
  final int statusId;
  final String status;
  final dynamic avatar;
  final dynamic avatarMimeType;
  final String sexualOrientation;
  final int sexualityId;
  final String? token;
  final SecurityTokenEntity? tokenAI;
  final bool isGenderVisible;
  final bool isSexualityVisible;
  final List<String?> pictures;

  UserEntity({
    this.id,
    required this.birthDate,
    required this.name,
    required this.lastName,
    required this.identity,
    required this.genderId,
    required this.gender,
    required this.email,
    required this.phone,
    required this.statusId,
    required this.status,
    required this.avatar,
    required this.avatarMimeType,
    required this.sexualOrientation,
    required this.sexualityId,
    this.token,
    this.tokenAI,
    required this.isGenderVisible,
    required this.isSexualityVisible,
    required this.pictures,
  });

  get isVerify => null;

  factory UserEntity.fromJson(Map<String, dynamic> json) => UserEntity(
        id: json["id"],
        birthDate: DateTime.parse(json["birthDate"]),
        name: json["name"],
        lastName: json["lastName"],
        identity: json["identity"],
        genderId: json["genderId"],
        gender: json["gender"],
        email: json["email"],
        phone: json["phone"],
        statusId: json["statusId"],
        status: json["status"],
        avatar: json["avatar"],
        avatarMimeType: json["avatarMimeType"],
        sexualOrientation: json["sexualOrientation"],
        sexualityId: json["sexualityId"],
        isGenderVisible: json["isGenderVisible"],
        isSexualityVisible: json["isSexualityVisible"],
        pictures: List<String>.from(json["pictures"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "birthDate": birthDate.toIso8601String(),
        "name": name,
        "lastName": lastName,
        "identity": identity,
        "genderId": genderId,
        "gender": gender,
        "email": email,
        "phone": phone,
        "statusId": statusId,
        "status": status,
        "avatar": avatar,
        "avatarMimeType": avatarMimeType,
        "sexualOrientation": sexualOrientation,
        "sexualityId": sexualityId,
        "isGenderVisible": isGenderVisible,
        "isSexualityVisible": isSexualityVisible,
        "pictures": List<dynamic>.from(pictures.map((x) => x)),
      };
}
