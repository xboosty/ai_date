class SecurityTokenEntity {
  final String accessToken;
  final String tokenType;
  final int refreshTokenExpirationHours;

  SecurityTokenEntity({
    required this.accessToken,
    required this.tokenType,
    required this.refreshTokenExpirationHours,
  });

  factory SecurityTokenEntity.fromJson(Map<String, dynamic> json) =>
      SecurityTokenEntity(
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
