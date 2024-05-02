// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'participant_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ParticipantDto _$ParticipantDtoFromJson(Map<String, dynamic> json) =>
    ParticipantDto(
      avatarUrl: json['avatarUrl'] as String?,
      firstName: json['firstName'] as String,
      lastName: json['lastNam'] as String,
      memberId: json['memberId'] as String,
      attendance: EnumSerializer.attendanceFromJson(json['attendance'] as int),
      role: EnumSerializer.roleFromJson(json['role'] as int),
    );

Map<String, dynamic> _$ParticipantDtoToJson(ParticipantDto instance) =>
    <String, dynamic>{
      'memberId': instance.memberId,
      'avatarUrl': instance.avatarUrl,
      'firstName': instance.firstName,
      'lastNam': instance.lastName,
      'attendance': _$AttendanceDtoEnumMap[instance.attendance]!,
      'role': _$RoleDtoEnumMap[instance.role]!,
    };

const _$AttendanceDtoEnumMap = {
  AttendanceDto.unspecified: 'unspecified',
  AttendanceDto.late: 'late',
  AttendanceDto.absent: 'absent',
  AttendanceDto.present: 'present',
};

const _$RoleDtoEnumMap = {
  RoleDto.owner: 'owner',
  RoleDto.teacher: 'teacher',
  RoleDto.participant: 'participant',
};
