import 'package:json_annotation/json_annotation.dart';

part 'change_members_role_dto.g.dart';

@JsonSerializable()
class ChangeMembersRoleDto {
  final List<MemberRoleDto> memberRoles;

  ChangeMembersRoleDto({required this.memberRoles});

  factory ChangeMembersRoleDto.fromJson(Map<String, dynamic> json) => _$ChangeMembersRoleDtoFromJson(json);
  Map<String, dynamic> toJson() => _$ChangeMembersRoleDtoToJson(this);
}


@JsonSerializable()
class MemberRoleDto {
  final String memberId;
  final String role;

  MemberRoleDto({required this.memberId, required this.role});

  factory MemberRoleDto.fromJson(Map<String, dynamic> json) => _$MemberRoleDtoFromJson(json);
  Map<String, dynamic> toJson() => _$MemberRoleDtoToJson(this);
}