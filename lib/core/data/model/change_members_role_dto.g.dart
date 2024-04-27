// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'change_members_role_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChangeMembersRoleDto _$ChangeMembersRoleDtoFromJson(Map<String, dynamic> json) =>
    ChangeMembersRoleDto(
      memberRoles: (json['memberRoles'] as List<dynamic>)
          .map((e) => MemberRoleDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ChangeMembersRoleDtoToJson(ChangeMembersRoleDto instance) =>
    <String, dynamic>{
      'memberRoles': instance.memberRoles,
    };

MemberRoleDto _$MemberRoleDtoFromJson(Map<String, dynamic> json) => MemberRoleDto(
      memberId: json['memberId'] as String,
      role: json['role'] as String,
    );

Map<String, dynamic> _$MemberRoleDtoToJson(MemberRoleDto instance) => <String, dynamic>{
      'memberId': instance.memberId,
      'role': instance.role,
    };
