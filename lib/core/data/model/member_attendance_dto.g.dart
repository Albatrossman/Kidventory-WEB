// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member_attendance_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MemberAttendanceDto _$MemberAttendanceDtoFromJson(Map<String, dynamic> json) =>
    MemberAttendanceDto(
      memberId: json['memberId'] as String,
      attendance: $enumDecode(_$AttendanceDtoEnumMap, json['attendance']),
    );

Map<String, dynamic> _$MemberAttendanceDtoToJson(
        MemberAttendanceDto instance) =>
    <String, dynamic>{
      'memberId': instance.memberId,
      'attendance': _$AttendanceDtoEnumMap[instance.attendance]!,
    };

const _$AttendanceDtoEnumMap = {
  AttendanceDto.unspecified: 'unspecified',
  AttendanceDto.late: 'late',
  AttendanceDto.absent: 'absent',
  AttendanceDto.present: 'present',
};
