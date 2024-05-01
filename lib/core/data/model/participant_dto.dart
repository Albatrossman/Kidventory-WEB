import 'package:json_annotation/json_annotation.dart';
import 'package:kidventory_flutter/core/data/model/attendance_dto.dart';
import 'package:kidventory_flutter/core/data/model/role_dto.dart';
import 'package:kidventory_flutter/core/data/util/serializer/enum_serializer.dart';

part 'participant_dto.g.dart';

@JsonSerializable()
class ParticipantDto {
  final String memberId;
  final String? avatarUrl;
  final String firstName;
  @JsonKey(name: 'lastNam')
  final String lastName;
  @JsonKey(name: 'atendance', fromJson: EnumSerializer.attendanceFromJson)
  final AttendanceDto attendance;
  @JsonKey(name: 'role', fromJson: EnumSerializer.roleFromJson)
  final RoleDto role;

  ParticipantDto({
    this.avatarUrl,
    required this.firstName,
    required this.lastName,
    required this.memberId,
    required this.attendance,
    required this.role,
  });

  factory ParticipantDto.fromJson(Map<String, dynamic> json) => _$ParticipantDtoFromJson(json);
  Map<String, dynamic> toJson() => _$ParticipantDtoToJson(this);
}