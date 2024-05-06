// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invited_event_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InvitedEventDto _$InvitedEventDtoFromJson(Map<String, dynamic> json) =>
    InvitedEventDto(
      eventDto: EventDto.fromJson(json['eventDetail'] as Map<String, dynamic>),
      isPrivate: json['isPrivate'] as bool,
    );

Map<String, dynamic> _$InvitedEventDtoToJson(InvitedEventDto instance) =>
    <String, dynamic>{
      'eventDetail': instance.eventDto,
      'isPrivate': instance.isPrivate,
    };
