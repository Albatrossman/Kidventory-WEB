// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'join_from_invite_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JoinFromInvitetDto _$JoinFromInvitetDtoFromJson(Map<String, dynamic> json) =>
    JoinFromInvitetDto(
      includeMeAsAdult: json['includeMeAsAdult'] as bool,
      memberIds:
          (json['memberIds'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$JoinFromInvitetDtoToJson(JoinFromInvitetDto instance) =>
    <String, dynamic>{
      'includeMeAsAdult': instance.includeMeAsAdult,
      'memberIds': instance.memberIds,
    };
