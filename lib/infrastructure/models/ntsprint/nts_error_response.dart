class NtsErrorResponse {
  final int? statusCode;
  final int? customStatusCode;
  final String? message;

  NtsErrorResponse({
    this.statusCode,
    this.customStatusCode,
    this.message,
  });

  factory NtsErrorResponse.fromJson(Map<String, dynamic> json) =>
      NtsErrorResponse(
        statusCode: json["statusCode"],
        customStatusCode: json["customStatusCode"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "customStatusCode": customStatusCode,
        "message": message,
      };
}
