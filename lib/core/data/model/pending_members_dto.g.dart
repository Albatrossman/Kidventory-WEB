// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pending_members_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PendingMembersDto _$PendingMembersDtoFromJson(Map<String, dynamic> json) =>
    PendingMembersDto(
      id: json['id'] as String,
      eventId: json['eventId'] as String,
      members: (json['members'] as List<dynamic>)
          .map((e) => PendingMemberDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PendingMembersDtoToJson(PendingMembersDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'eventId': instance.eventId,
      'members': instance.members,
    };
