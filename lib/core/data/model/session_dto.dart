import 'package:json_annotation/json_annotation.dart';

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

  SessionDto({
    required this.sessionId,
    required this.eventId,
    required this.imageUrl,
    required this.title,
    required this.timeMode,
    required this.color,
    required this.startDateTime,
    required this.endDateTime
  });

  factory SessionDto.fromJson(Map<String, dynamic> json) => _$SessionDtoFromJson(json);
  Map<String, dynamic> toJson() => _$SessionDtoToJson(this);
}