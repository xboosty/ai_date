import 'user_response.dart';

class NtsSocialAuthResponse {
  final UserResponse? user;
  final int? statusCode;
  final int? customStatusCode;

  NtsSocialAuthResponse({
    required this.user,
    this.statusCode,
    this.customStatusCode,
  });

  factory NtsSocialAuthResponse.fromJson(Map<String, dynamic> json) =>
      NtsSocialAuthResponse(
        user: json["result"]["registered"]
            ? UserResponse.fromJson(json["result"]["user"])
            : null,
        statusCode: json["statusCode"],
        customStatusCode: json["customStatusCode"],
      );

  Map<String, dynamic> toJson() => {
        "result": user?.toJson(),
        "statusCode": statusCode,
        "customStatusCode": customStatusCode,
      };
}
