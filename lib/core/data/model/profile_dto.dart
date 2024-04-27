import 'package:kidventory_flutter/core/data/model/child_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'profile_dto.g.dart';

@JsonSerializable()
class ProfileDto {
  final String id;
  final String avatarUrl;
  final String email;
  final String password;
  final String firstName;
  final String lastName;
  final String timeZone;
  final List<String> phone;
  final List<ChildDto> children;

  ProfileDto({
    required this.id,
    required this.avatarUrl,
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
    required this.timeZone,
    required this.phone,
    required this.children,
  });


 factory ProfileDto.fromJson(Map<String, dynamic> json) =>
      _$ProfileDtoFromJson(json);
  Map<String, dynamic> toJson() => _$ProfileDtoToJson(this);
}