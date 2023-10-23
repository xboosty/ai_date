import 'user_response.dart';

class NtsUserResponse {
  final UserResponse user;
  final int? statusCode;
  final int? customStatusCode;

  NtsUserResponse({
    required this.user,
    this.statusCode,
    this.customStatusCode,
  });

  factory NtsUserResponse.fromJson(Map<String, dynamic> json) =>
      NtsUserResponse(
        user: UserResponse.fromJson(json["result"]),
        statusCode: json["statusCode"],
        customStatusCode: json["customStatusCode"],
      );

  Map<String, dynamic> toJson() => {
        "result": user.toJson(),
        "statusCode": statusCode,
        "customStatusCode": customStatusCode,
      };
}
