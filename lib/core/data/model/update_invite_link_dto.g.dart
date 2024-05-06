// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_invite_link_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateInviteLinkDto _$UpdateInviteLinkDtoFromJson(Map<String, dynamic> json) =>
    UpdateInviteLinkDto(
      isActive: json['isActive'] as bool,
      isPrivate: json['isPrivate'] as bool,
      expirationDate: json['expirationDate'] == null
          ? null
          : DateTime.parse(json['expirationDate'] as String),
    );

Map<String, dynamic> _$UpdateInviteLinkDtoToJson(
        UpdateInviteLinkDto instance) =>
    <String, dynamic>{
      'isActive': instance.isActive,
      'isPrivate': instance.isPrivate,
      'expirationDate': instance.expirationDate?.toIso8601String(),
    };
