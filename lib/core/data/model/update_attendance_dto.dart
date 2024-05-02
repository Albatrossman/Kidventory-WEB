import 'package:json_annotation/json_annotation.dart';
import 'package:kidventory_flutter/core/data/model/member_attendance_dto.dart';

part 'update_attendance_dto.g.dart';

@JsonSerializable()
class UpdateAttendanceDto {
  @JsonKey(name: 'memberAttendances')
  List<MemberAttendanceDto> attendances;

  UpdateAttendanceDto({required this.attendances});

  factory UpdateAttendanceDto.fromJson(Map<String, dynamic> json) => _$UpdateAttendanceDtoFromJson(json);
  Map<String, dynamic> toJson() => _$UpdateAttendanceDtoToJson(this);
}
