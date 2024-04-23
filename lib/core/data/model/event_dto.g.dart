// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventDto _$EventDtoFromJson(Map<String, dynamic> json) => EventDto(
      id: json['id'] as String,
      imageFile: json['imageFile'] as String,
      imageUrl: json['imageUrl'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      repeat: RepeatDto.fromJson(json['repeat'] as Map<String, dynamic>),
      timeMode: json['timeMode'] as String,
      startTime: json['startTime'] as String,
      endTime: json['endTime'] as String,
      color: json['color'] as String,
      onlineLocation: OnlineLocationDto.fromJson(
          json['onlineLocation'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$EventDtoToJson(EventDto instance) => <String, dynamic>{
      'id': instance.id,
      'imageFile': instance.imageFile,
      'imageUrl': instance.imageUrl,
      'title': instance.title,
      'description': instance.description,
      'repeat': instance.repeat,
      'timeMode': instance.timeMode,
      'startTime': instance.startTime,
      'endTime': instance.endTime,
      'color': instance.color,
      'onlineLocation': instance.onlineLocation,
    };
