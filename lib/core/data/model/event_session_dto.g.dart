// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_session_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventSessionDto _$EventSessionDtoFromJson(Map<String, dynamic> json) =>
    EventSessionDto(
      id: json['id'] as String,
      title: json['title'] as String,
      startDateTime: DateTime.parse(json['startDateTime'] as String),
      endDateTime: DateTime.parse(json['endDateTime'] as String),
      timeMode: EnumSerializer.timeModeFromJson(json['timeMode'] as int),
      color: EnumSerializer.eventColorFromJson(json['color'] as int),
    );

Map<String, dynamic> _$EventSessionDtoToJson(EventSessionDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'startDateTime': instance.startDateTime.toIso8601String(),
      'endDateTime': instance.endDateTime.toIso8601String(),
      'timeMode': EnumSerializer.toJson(instance.timeMode),
      'color': EnumSerializer.toJson(instance.color),
    };
