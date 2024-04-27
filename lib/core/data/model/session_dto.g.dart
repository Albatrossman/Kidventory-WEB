// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SessionDto _$SessionDtoFromJson(Map<String, dynamic> json) => SessionDto(
      sessionId: json['sessionId'] as String,
      eventId: json['eventId'] as String,
      imageUrl: json['imageUrl'] as String?,
      title: json['title'] as String,
      timeMode: json['timeMode'] as String,
      color: json['color'] as String,
      startDateTime: DateTime.parse(json['startDateTime'] as String),
      endDateTime: DateTime.parse(json['endDateTime'] as String),
    );

Map<String, dynamic> _$SessionDtoToJson(SessionDto instance) => <String, dynamic>{
      'sessionId': instance.sessionId,
      'eventId': instance.eventId,
      'imageUrl': instance.imageUrl,
      'title': instance.title,
      'timeMode': instance.timeMode,
      'color': instance.color,
      'startDateTime': instance.startDateTime.toIso8601String(),
      'endDateTime': instance.endDateTime.toIso8601String(),
    };
