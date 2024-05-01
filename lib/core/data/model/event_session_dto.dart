import 'package:json_annotation/json_annotation.dart';
import 'package:kidventory_flutter/core/data/util/serializer/enum_serializer.dart';
import 'package:kidventory_flutter/core/domain/model/color.dart';
import 'package:kidventory_flutter/core/domain/model/time_mode.dart';

part 'event_session_dto.g.dart';

@JsonSerializable()
class EventSessionDto {
  final String id;
  final String title;
  final DateTime startDateTime;
  final DateTime endDateTime;
  @JsonKey(fromJson: EnumSerializer.timeModeFromJson, toJson: EnumSerializer.toJson)
  final TimeMode timeMode;
  @JsonKey(fromJson: EnumSerializer.eventColorFromJson, toJson: EnumSerializer.toJson)
  final EventColor color;

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