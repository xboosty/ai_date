class NtsUserResponse {
  final User user;
  final int? statusCode;
  final int? customStatusCode;

  NtsUserResponse({
    required this.user,
    this.statusCode,
    this.customStatusCode,
  });

  factory NtsUserResponse.fromJson(Map<String, dynamic> json) =>
      NtsUserResponse(
        user: User.fromJson(json["result"]),
        statusCode: json["statusCode"],
        customStatusCode: json["customStatusCode"],
      );

  Map<String, dynamic> toJson() => {
        "result": user.toJson(),
        "statusCode": statusCode,
        "customStatusCode": customStatusCode,
      };
}

class User {
  final int? id;
  final DateTime? birthDate;
  final String fullName;
  final String? identity;
  final int? genderId;
  final String gender;
  final String email;
  final String? phone;
  final int? statusId;
  final String? status;
  final dynamic avatar;
  final dynamic avatarMimeType;
  final String sexualOrientation;

  User({
    this.id,
    this.birthDate,
    required this.fullName,
    this.identity,
    this.genderId,
    required this.gender,
    required this.email,
    this.phone,
    this.statusId,
    this.status,
    this.avatar,
    this.avatarMimeType,
    required this.sexualOrientation,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        birthDate: json["birthDate"] == null
            ? null
            : DateTime.parse(json["birthDate"]),
        fullName: json["fullName"],
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
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "birthDate": birthDate?.toIso8601String(),
        "fullName": fullName,
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
      };
}
