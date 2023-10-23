class UserResponse {
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

  UserResponse({
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

  factory UserResponse.fromJson(Map<String, dynamic> json) => UserResponse(
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
