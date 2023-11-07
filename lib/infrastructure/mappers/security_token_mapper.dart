import '../../domain/domain.dart' show SecurityTokenEntity;
import '../models/ai/ai_security_token_response.dart';

class SecurityMapper {
  static SecurityTokenEntity securityTResponseToEntity(
          AiSecurityTokenResponse token) =>
      SecurityTokenEntity(
        accessToken: token.accessToken ?? '',
        tokenType: token.tokenType ?? '',
        refreshTokenExpirationHours: token.refreshTokenExpirationHours ?? 0,
      );
}
