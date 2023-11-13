class AiUserEntity {
  final int id;
  final String email;
  final String avatar;

  AiUserEntity({
    required this.id,
    required this.email,
    required this.avatar,
  });

  factory AiUserEntity.fromJson(Map<String, dynamic> json) => AiUserEntity(
        id: json["id"],
        email: json["email"],
        avatar: json["avatar"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "avatar": avatar,
      };
}
