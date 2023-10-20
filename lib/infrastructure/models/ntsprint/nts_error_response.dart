class NtsErrorResponse {
  final int? statusCode;
  final int? customStatusCode;
  final String? message;

  NtsErrorResponse({
    this.statusCode,
    this.customStatusCode,
    this.message,
  });

  factory NtsErrorResponse.fromJson(Map<String, dynamic> json) {
    String? messageResp;
    if (json["message"] != null) {
      messageResp = json["message"];
    }

    if (json["errors"] != null) {
      messageResp = json["errors"][0];
    }

    return NtsErrorResponse(
      statusCode: json["statusCode"],
      customStatusCode: json["customStatusCode"],
      message: messageResp,
    );
  }

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "customStatusCode": customStatusCode,
        "message": message,
      };
}
