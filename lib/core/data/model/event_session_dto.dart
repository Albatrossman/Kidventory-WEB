import 'package:json_annotation/json_annotation.dart';

part 'event_session_dto.g.dart';

@JsonSerializable()
class EventSessionDto {
  final String id;
  final String title;
  final DateTime startDateTime;
  final DateTime endDateTime;
  final String timeMode;
  final String color;

  EventSessionDto({
    required this.id,
    required this.title,
    required this.startDateTime,
    required this.endDateTime,
    required this.timeMode,
    required this.color,
  });

  factory EventSessionDto.fromJson(Map<String, dynamic> json) => _$EventSessionDtoFromJson(json);
  Map<String, dynamic> toJson() => _$EventSessionDtoToJson(this);
}