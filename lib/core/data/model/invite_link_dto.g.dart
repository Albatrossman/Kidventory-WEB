// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invite_link_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InviteLinkDto _$InviteLinkDtoFromJson(Map<String, dynamic> json) =>
    InviteLinkDto(
      eventId: json['eventId'] as String?,
      expirationDate: json['expirationDate'] == null
          ? null
          : DateTime.parse(json['expirationDate'] as String),
      id: json['id'] as String?,
      isActive: json['isActive'] as bool?,
      isPrivate: json['isPrivate'] as bool?,
      referenceId: json['referenceId'] as String?,
    );

Map<String, dynamic> _$InviteLinkDtoToJson(InviteLinkDto instance) =>
    <String, dynamic>{
      'eventId': instance.eventId,
      'expirationDate': instance.expirationDate?.toIso8601String(),
      'id': instance.id,
      'isActive': instance.isActive,
      'isPrivate': instance.isPrivate,
      'referenceId': instance.referenceId,
    };
