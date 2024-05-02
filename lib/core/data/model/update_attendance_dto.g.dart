// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_attendance_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateAttendanceDto _$UpdateAttendanceDtoFromJson(Map<String, dynamic> json) =>
    UpdateAttendanceDto(
      attendances: (json['membersAttendances'] as List<dynamic>)
          .map((e) => MemberAttendanceDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UpdateAttendanceDtoToJson(
        UpdateAttendanceDto instance) =>
    <String, dynamic>{
      'membersAttendances': instance.attendances,
    };
