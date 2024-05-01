import 'package:json_annotation/json_annotation.dart';
import 'package:kidventory_flutter/core/data/model/event_session_dto.dart';
import 'package:kidventory_flutter/core/data/model/online_location_dto.dart';
import 'package:kidventory_flutter/core/data/model/repeat_dto.dart';
import 'package:kidventory_flutter/core/data/util/serializer/enum_serializer.dart';
import 'package:kidventory_flutter/core/domain/model/color.dart';
import 'package:kidventory_flutter/core/domain/model/time_mode.dart';

part 'event_dto.g.dart';

@JsonSerializable()
class EventDto {
  final String id;
  final String? imageUrl;
  @JsonKey(name: 'title')
  final String name;
  @JsonKey(name: 'descrption')
  final String? description;
  final RepeatDto repeat;
  @JsonKey(fromJson: EnumSerializer.timeModeFromJson, toJson: EnumSerializer.toJson)
  final TimeMode timeMode;
  @JsonKey(fromJson: EnumSerializer.eventColorFromJson, toJson: EnumSerializer.toJson)
  final EventColor color;
  final OnlineLocationDto? onlineLocation;
  @JsonKey(name: 'nearestSession')
  final EventSessionDto nearestSession;

  EventDto({
    required this.id,
    required this.imageUrl,
    required this.name,
    required this.description,
    required this.repeat,
    required this.timeMode,
    required this.color,
    required this.onlineLocation,
    required this.nearestSession
  });

  factory EventDto.fromJson(Map<String, dynamic> json) => _$EventDtoFromJson(json);
  Map<String, dynamic> toJson() => _$EventDtoToJson(this);
}