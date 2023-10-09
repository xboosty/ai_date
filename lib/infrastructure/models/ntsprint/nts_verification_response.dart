class NtsVerificationResponse {
  final bool? result;
  final int? statusCode;
  final int? customStatusCode;

  NtsVerificationResponse({
    this.result,
    this.statusCode,
    this.customStatusCode,
  });

  factory NtsVerificationResponse.fromJson(Map<String, dynamic> json) =>
      NtsVerificationResponse(
        result: json["result"],
        statusCode: json["statusCode"],
        customStatusCode: json["customStatusCode"],
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "statusCode": statusCode,
        "customStatusCode": customStatusCode,
      };
}
