import 'package:kidventory_flutter/core/data/model/token_dto.dart';
import 'package:kidventory_flutter/core/domain/model/token.dart';

extension DataExtension on TokenDto {
  Token toDomain() {
    return Token(
      accessToken: accessToken,
      refreshToken: refreshToken,
    );
  }
}

extension DomainExtension on Token {
  TokenDto toData() {
    return TokenDto(
      accessToken: accessToken,
      refreshToken: refreshToken,
    );
  }
}