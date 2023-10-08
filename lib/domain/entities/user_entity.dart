class UserEntity {
  final int? id;
  final DateTime birthDate;
  final String fullName;
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
  final String? token;

  UserEntity({
    this.id,
    required this.birthDate,
    required this.fullName,
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
    this.token,
  });

  // factory UserEntity.fromJson(Map<String, dynamic> json) => UserEntity(
  //     id: json["id"],
  //     birthDate: DateTime.parse(json["birthDate"]),
  //     fullName: json["fullName"],
  //     identity: json["identity"],
  //     genderId: json["genderId"],
  //     gender: json["gender"],
  //     email: json["email"],
  //     phone: json["phone"],
  //     statusId: json["statusId"],
  //     status: json["status"],
  //     avatar: json["avatar"],
  //     avatarMimeType: json["avatarMimeType"],
  //     sexualOrientation: json["sexualOrientation"],
  // );

  // Map<String, dynamic> toJson() => {
  //     "id": id,
  //     "birthDate": birthDate.toIso8601String(),
  //     "fullName": fullName,
  //     "identity": identity,
  //     "genderId": genderId,
  //     "gender": gender,
  //     "email": email,
  //     "phone": phone,
  //     "statusId": statusId,
  //     "status": status,
  //     "avatar": avatar,
  //     "avatarMimeType": avatarMimeType,
  //     "sexualOrientation": sexualOrientation,
  // };
}
