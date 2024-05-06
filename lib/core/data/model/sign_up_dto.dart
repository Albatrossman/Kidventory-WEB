import 'package:json_annotation/json_annotation.dart';

part 'sign_up_dto.g.dart';

@JsonSerializable()
class SignUpDto {
  final String email;
  final String firstname;
  final String lastname;
  final String password;
  final String timezone;

  SignUpDto({
    required this.email,
    required this.firstname,
    required this.lastname,
    required this.password,
    required this.timezone,
  });

  factory SignUpDto.fromJson(Map<String, dynamic> json) =>
      _$SignUpDtoFromJson(json);
  Map<String, dynamic> toJson() => _$SignUpDtoToJson(this);
}
