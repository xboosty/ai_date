class AiSecurityTokenResponse {
  final String? accessToken;
  final String? tokenType;
  final int? refreshTokenExpirationHours;

  AiSecurityTokenResponse({
    this.accessToken,
    this.tokenType,
    this.refreshTokenExpirationHours,
  });

  factory AiSecurityTokenResponse.fromJson(Map<String, dynamic> json) =>
      AiSecurityTokenResponse(
        accessToken: json["access_token"],
        tokenType: json["token_type"],
        refreshTokenExpirationHours: json["refresh_token_expiration_hours"],
      );

  Map<String, dynamic> toJson() => {
        "access_token": accessToken,
        "token_type": tokenType,
        "refresh_token_expiration_hours": refreshTokenExpirationHours,
      };
}
