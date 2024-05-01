// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventDto _$EventDtoFromJson(Map<String, dynamic> json) => EventDto(
      id: json['id'] as String,
      imageUrl: json['imageUrl'] as String,
      name: json['title'] as String,
      description: json['description'] as String,
      repeat: RepeatDto.fromJson(json['repeat'] as Map<String, dynamic>),
      timeMode: json['timeMode'] as String,
      color: json['color'] as String,
      onlineLocation: OnlineLocationDto.fromJson(
          json['onlineLocation'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$EventDtoToJson(EventDto instance) => <String, dynamic>{
      'id': instance.id,
      'imageUrl': instance.imageUrl,
      'title': instance.name,
      'description': instance.description,
      'repeat': instance.repeat,
      'timeMode': instance.timeMode,
      'color': instance.color,
      'onlineLocation': instance.onlineLocation,
    };
