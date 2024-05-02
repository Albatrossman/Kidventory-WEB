// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MemberDto _$MemberDtoFromJson(Map<String, dynamic> json) => MemberDto(
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      email: json['email'] as String,
      age: json['age'] as int,
      gender: json['gender'] as String,
      address: json['address'] as String,
      role: $enumDecode(_$RoleDtoEnumMap, json['role']),
      primaryGuardian: json['primaryGuardian'] as String?,
      phone: (json['phone'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$MemberDtoToJson(MemberDto instance) => <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.email,
      'age': instance.age,
      'gender': instance.gender,
      'address': instance.address,
      'role': _$RoleDtoEnumMap[instance.role]!,
      'primaryGuardian': instance.primaryGuardian,
      'phone': instance.phone,
    };

const _$RoleDtoEnumMap = {
  RoleDto.owner: 'owner',
  RoleDto.teacher: 'teacher',
  RoleDto.participant: 'participant',
};
