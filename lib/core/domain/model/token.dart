import 'package:json_annotation/json_annotation.dart';

part 'token.g.dart';

@JsonSerializable()
class Token {
  final String accessToken;
  final String refreshToken;
  final String username;

  Token({
    required this.accessToken,
    required this.refreshToken,
    required this.username,
  });

  factory Token.fromJson(Map<String, dynamic> json) => _$TokenFromJson(json);
  Map<String, dynamic> toJson() => _$TokenToJson(this);
}
