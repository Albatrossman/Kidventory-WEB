import 'package:json_annotation/json_annotation.dart';
import 'package:kidventory_flutter/core/data/model/role_dto.dart';
import 'package:kidventory_flutter/core/data/util/serializer/enum_serializer.dart';

part 'session_dto.g.dart';

@JsonSerializable()
class SessionDto {
  final String sessionId;
  final String eventId;
  final String? imageUrl;
  final String title;
  final String timeMode;
  final String color;
  final DateTime startDateTime;
  final DateTime endDateTime;
  @JsonKey(fromJson: EnumSerializer.optionalRoleFromJson, toJson: EnumSerializer.toJson)
  final RoleDto? role;

  SessionDto({
    required this.sessionId,
    required this.eventId,
    required this.imageUrl,
    required this.title,
    required this.timeMode,
    required this.color,
    required this.startDateTime,
    required this.endDateTime,
    this.role,
  });

  factory SessionDto.fromJson(Map<String, dynamic> json) =>
      _$SessionDtoFromJson(json);
  Map<String, dynamic> toJson() => _$SessionDtoToJson(this);
}
