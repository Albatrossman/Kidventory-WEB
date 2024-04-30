import 'package:json_annotation/json_annotation.dart';

part 'update_profile_dto.g.dart';

@JsonSerializable()
class UpdateProfileDto {
  final String? avatarFile;
  final String? avatarUrl;
  final String firstName;
  final String lastName;

  UpdateProfileDto({
    this.avatarFile,
    this.avatarUrl,
    required this.firstName,
    required this.lastName,
  });

  factory UpdateProfileDto.fromJson(Map<String, dynamic> json) =>
      _$UpdateProfileDtoFromJson(json);
  Map<String, dynamic> toJson() => _$UpdateProfileDtoToJson(this);
}
