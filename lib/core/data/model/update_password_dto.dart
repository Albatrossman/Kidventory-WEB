import 'package:json_annotation/json_annotation.dart';

part 'update_password_dto.g.dart';

@JsonSerializable()
class UpdatePasswordDto {
  final String email;
  final String currentPassword;
  final String newPassword;
  final String confirmNewPassword;

  UpdatePasswordDto({
    required this.email,
    required this.currentPassword,
    required this.newPassword,
    required this.confirmNewPassword,
  });

  factory UpdatePasswordDto.fromJson(Map<String, dynamic> json) =>
      _$UpdatePasswordDtoFromJson(json);
  Map<String, dynamic> toJson() => _$UpdatePasswordDtoToJson(this);
}
