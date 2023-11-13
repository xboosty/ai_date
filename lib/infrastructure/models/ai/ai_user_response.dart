class AiUserResponse {
  final int? id;
  final String? email;
  final String? avatar;

  AiUserResponse({
    this.id,
    this.email,
    this.avatar,
  });

  factory AiUserResponse.fromJson(Map<String, dynamic> json) => AiUserResponse(
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
