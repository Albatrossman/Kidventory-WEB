// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_event_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateEventDto _$CreateEventDtoFromJson(Map<String, dynamic> json) =>
    CreateEventDto(
      imageFile: json['imageFile'] as String?,
      name: json['title'] as String,
      description: json['description'] as String?,
      repeat: RepeatDto.fromJson(json['repeat'] as Map<String, dynamic>),
      timeMode: $enumDecode(_$TimeModeEnumMap, json['timeMode']),
      color: $enumDecode(_$EventColorEnumMap, json['color']),
      onlineLocation: json['onlineLocation'] == null
          ? null
          : OnlineLocationDto.fromJson(
              json['onlineLocation'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CreateEventDtoToJson(CreateEventDto instance) =>
    <String, dynamic>{
      'imageFile': instance.imageFile,
      'title': instance.name,
      'description': instance.description,
      'repeat': instance.repeat,
      'timeMode': EnumSerializer.toJson(instance.timeMode),
      'color': EnumSerializer.toJson(instance.color),
      'onlineLocation': instance.onlineLocation,
    };

const _$TimeModeEnumMap = {
  TimeMode.allDay: 'allDay',
  TimeMode.halting: 'halting',
};

const _$EventColorEnumMap = {
  EventColor.tomato: 'tomato',
  EventColor.flamingo: 'flamingo',
  EventColor.tangerine: 'tangerine',
  EventColor.banana: 'banana',
  EventColor.sage: 'sage',
  EventColor.basil: 'basil',
  EventColor.peacock: 'peacock',
  EventColor.blueberry: 'blueberry',
  EventColor.lavender: 'lavender',
  EventColor.grape: 'grape',
};
