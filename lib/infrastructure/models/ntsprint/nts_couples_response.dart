import 'user_response.dart';

class NtsCouplesUserResponse {
  final List<UserResponse>? result;
  final int? statusCode;
  final int? customStatusCode;

  NtsCouplesUserResponse({
    this.result,
    this.statusCode,
    this.customStatusCode,
  });

  factory NtsCouplesUserResponse.fromJson(Map<String, dynamic> json) =>
      NtsCouplesUserResponse(
        result: json["result"] == null
            ? []
            : json["result"] != []
                ? List<UserResponse>.from(
                    json["result"]!.map((x) => UserResponse.fromJson(x)))
                : [],
        statusCode: json["statusCode"],
        customStatusCode: json["customStatusCode"],
      );

  Map<String, dynamic> toJson() => {
        "result": result == null
            ? []
            : List<dynamic>.from(result!.map((x) => x.toJson())),
        "statusCode": statusCode,
        "customStatusCode": customStatusCode,
      };
}
