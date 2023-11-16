class UserResponse {
  final int? id;
  final DateTime? birthDate;
  final String fullName;
  final String? lastName;
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
  final int? sexualityId;
  final bool? isGenderVisible;
  final bool? isSexualityVisible;
  final List<String?> pictures;

  UserResponse({
    this.id,
    this.birthDate,
    required this.fullName,
    this.lastName,
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
    this.sexualityId,
    this.isGenderVisible,
    this.isSexualityVisible,
    required this.pictures,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) => UserResponse(
        id: json["id"],
        birthDate: json["birthDate"] == null
            ? null
            : DateTime.parse(json["birthDate"]),
        fullName: json["fullName"],
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
        "birthDate": birthDate?.toIso8601String(),
        "fullName": fullName,
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
