// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_minimal_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SessionMinimalDto _$SessionMinimalDtoFromJson(Map<String, dynamic> json) =>
    SessionMinimalDto(
      id: json['id'] as String,
      title: json['title'] as String,
      timeMode: EnumSerializer.timeModeFromJson(json['timeMode'] as int),
      color: EnumSerializer.eventColorFromJson(json['color'] as int),
      startDateTime: DateTime.parse(json['startDateTime'] as String),
      endDateTime: DateTime.parse(json['endDateTime'] as String),
    );

Map<String, dynamic> _$SessionMinimalDtoToJson(SessionMinimalDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'startDateTime': DateTimeSerializer.toJson(instance.startDateTime),
      'endDateTime': DateTimeSerializer.toJson(instance.endDateTime),
      'timeMode': EnumSerializer.toJson(instance.timeMode),
      'color': EnumSerializer.toJson(instance.color),
    };
