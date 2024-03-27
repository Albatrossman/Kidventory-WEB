class TokenDto {
  final String accessToken;
  final String tokenType;
  final int expiresIn;
  final String refreshToken;
  final String clientId;
  final String userName;
  final String issued;
  final String expires;
  final int statusCode;
  final String message;

  TokenDto({
    required this.accessToken,
    required this.tokenType,
    required this.expiresIn,
    required this.refreshToken,
    required this.clientId,
    required this.userName,
    required this.issued,
    required this.expires,
    required this.statusCode,
    required this.message,
  });

  factory TokenDto.fromJson(Map<String, dynamic> json) {
    return TokenDto(
      accessToken: json['access_token'],
      tokenType: json['token_type'],
      expiresIn: json['expires_in'],
      refreshToken: json['refresh_token'],
      clientId: json['client_id'],
      userName: json['userName'],
      issued: json['issued'],
      expires: json['expires'],
      statusCode: json['statusCode'],
      message: json['message'],
    );
  }
}
