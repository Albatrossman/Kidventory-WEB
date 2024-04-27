// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'participant_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ParticipantDto _$ParticipantDtoFromJson(Map<String, dynamic> json) =>
    ParticipantDto(
      avatarUrl: json['avatarUrl'] as String?,
      sessionId: json['sessionId'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      memberId: json['memberId'] as String,
      startDateTime: DateTime.parse(json['startDateTime'] as String),
      endDateTime: DateTime.parse(json['endDateTime'] as String),
      timeMode: json['timeMode'] as String,
      attendance: $enumDecode(_$AttendanceDtoEnumMap, json['atendance']),
      color: json['color'] as String,
      role: $enumDecode(_$RoleDtoEnumMap, json['role']),
    );

Map<String, dynamic> _$ParticipantDtoToJson(ParticipantDto instance) =>
    <String, dynamic>{
      'sessionId': instance.sessionId,
      'avatarUrl': instance.avatarUrl,
      'memberId': instance.memberId,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'startDateTime': instance.startDateTime.toIso8601String(),
      'endDateTime': instance.endDateTime.toIso8601String(),
      'timeMode': instance.timeMode,
      'atendance': _$AttendanceDtoEnumMap[instance.attendance]!,
      'color': instance.color,
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
