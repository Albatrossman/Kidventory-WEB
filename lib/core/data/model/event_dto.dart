import 'package:json_annotation/json_annotation.dart';
import 'package:kidventory_flutter/core/data/model/online_location_dto.dart';
import 'package:kidventory_flutter/core/data/model/repeat_dto.dart';

part 'event_dto.g.dart';

@JsonSerializable()
class EventDto {
  final String id;
  final String imageFile;
  final String imageUrl;
  final String title;
  final String description;
  final RepeatDto repeat;
  final String timeMode;
  final String startTime;
  final String endTime;
  final String color;
  final OnlineLocationDto onlineLocation;

  EventDto({
    required this.id,
    required this.imageFile,
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.repeat,
    required this.timeMode,
    required this.startTime,
    required this.endTime,
    required this.color,
    required this.onlineLocation,
  });

  factory EventDto.fromJson(Map<String, dynamic> json) => _$EventDtoFromJson(json);
  Map<String, dynamic> toJson() => _$EventDtoToJson(this);
}