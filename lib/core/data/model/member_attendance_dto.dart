import 'package:json_annotation/json_annotation.dart';
import 'package:kidventory_flutter/core/data/model/attendance_dto.dart';
import 'package:kidventory_flutter/core/data/util/serializer/enum_serializer.dart';

part 'member_attendance_dto.g.dart';

@JsonSerializable()
class MemberAttendanceDto {
  final String memberId;
  @JsonKey(toJson: EnumSerializer.toJson)
  final AttendanceDto attendance;

  MemberAttendanceDto({
    required this.memberId,
    required this.attendance,
  });

  factory MemberAttendanceDto.fromJson(Map<String, dynamic> json) => _$MemberAttendanceDtoFromJson(json);
  Map<String, dynamic> toJson() => _$MemberAttendanceDtoToJson(this);
}