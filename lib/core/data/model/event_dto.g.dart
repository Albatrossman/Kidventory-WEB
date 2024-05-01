// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventDto _$EventDtoFromJson(Map<String, dynamic> json) => EventDto(
      id: json['id'] as String,
      imageUrl: json['imageUrl'] as String?,
      name: json['title'] as String,
      description: json['descrption'] as String?,
      repeat: RepeatDto.fromJson(json['repeat'] as Map<String, dynamic>),
      timeMode: EnumSerializer.timeModeFromJson(json['timeMode'] as int),
      color: EnumSerializer.eventColorFromJson(json['color'] as int),
      onlineLocation: json['onlineLocation'] == null
          ? null
          : OnlineLocationDto.fromJson(
              json['onlineLocation'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$EventDtoToJson(EventDto instance) => <String, dynamic>{
      'id': instance.id,
      'imageUrl': instance.imageUrl,
      'title': instance.name,
      'descrption': instance.description,
      'repeat': instance.repeat,
      'timeMode': EnumSerializer.toJson(instance.timeMode),
      'color': EnumSerializer.toJson(instance.color),
      'onlineLocation': instance.onlineLocation,
    };
