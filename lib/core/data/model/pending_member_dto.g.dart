// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pending_member_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PendingMemberDto _$PendingMemberDtoFromJson(Map<String, dynamic> json) =>
    PendingMemberDto(
      id: json['id'] as String,
      memberId: json['memberId'] as String,
      role: EnumSerializer.roleFromJson(json['role'] as int),
      state: json['state'] as int,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      adultUserId: json['adultUserId'] as String,
      adultFirstName: json['adultFirstName'] as String,
      adultLastName: json['adultLastName'] as String,
    );

Map<String, dynamic> _$PendingMemberDtoToJson(PendingMemberDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'memberId': instance.memberId,
      'role': EnumSerializer.toJson(instance.role),
      'state': instance.state,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'adultUserId': instance.adultUserId,
      'adultFirstName': instance.adultFirstName,
      'adultLastName': instance.adultLastName,
    };
