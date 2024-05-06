// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_join_status_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateJoinStatusDto _$UpdateJoinStatusDtoFromJson(Map<String, dynamic> json) =>
    UpdateJoinStatusDto(
      participantUserId: json['participantUserId'] as String,
      participantMemberId: json['participantMemberId'] as String,
      role: EnumSerializer.roleFromJson(json['role'] as int),
      state: EnumSerializer.joinStatusFromJson(json['state'] as int),
    );

Map<String, dynamic> _$UpdateJoinStatusDtoToJson(
        UpdateJoinStatusDto instance) =>
    <String, dynamic>{
      'participantUserId': instance.participantUserId,
      'participantMemberId': instance.participantMemberId,
      'role': EnumSerializer.toJson(instance.role),
      'state': EnumSerializer.toJson(instance.state),
    };
