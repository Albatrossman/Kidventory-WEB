import 'package:json_annotation/json_annotation.dart';
import 'package:kidventory_flutter/core/data/model/attendance_dto.dart';
import 'package:kidventory_flutter/core/data/model/role_dto.dart';

part 'participant_dto.g.dart';

@JsonSerializable()
class ParticipantDto {
  final String sessionId;
  final String? avatarUrl;
  final String memberId;
  final String firstName;
  final String lastName;
  final DateTime startDateTime;
  final DateTime endDateTime;
  final String timeMode;
  @JsonKey(name: 'atendance')
  final AttendanceDto attendance;
  final String color;
  final RoleDto role;

  ParticipantDto({
    this.avatarUrl,
    required this.sessionId,
    required this.firstName,
    required this.lastName,
    required this.memberId,
    required this.startDateTime,
    required this.endDateTime,
    required this.timeMode,
    required this.attendance,
    required this.color,
    required this.role
  });

  factory ParticipantDto.fromJson(Map<String, dynamic> json) => _$ParticipantDtoFromJson(json);
  Map<String, dynamic> toJson() => _$ParticipantDtoToJson(this);
}