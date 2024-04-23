import 'package:json_annotation/json_annotation.dart';

part 'token_dto.g.dart';

@JsonSerializable()
class TokenDto {
  @JsonKey(name: "access_token")
  final String accessToken;
  @JsonKey(name: "refresh_token")
  final String refreshToken;
  final String userName;

  TokenDto({
    required this.accessToken,
    required this.refreshToken,
    required this.userName,
  });

  factory TokenDto.fromJson(Map<String, dynamic> json) => _$TokenDtoFromJson(json);
  Map<String, dynamic> toJson() => _$TokenDtoToJson(this);
}
