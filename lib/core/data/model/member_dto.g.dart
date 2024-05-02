// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MemberDto _$MemberDtoFromJson(Map<String, dynamic> json) => MemberDto(
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      email: json['email'] as String,
      birthday: json['birthDate'] == null
          ? null
          : DateTime.parse(json['birthDate'] as String),
      gender: $enumDecodeNullable(_$GenderDtoEnumMap, json['gender']),
      address: json['address'] as String?,
      role: $enumDecodeNullable(_$RoleDtoEnumMap, json['role']),
      primaryGuardian: json['primaryGuardian'] as String?,
      phone: json['phone'] as String?,
    );

Map<String, dynamic> _$MemberDtoToJson(MemberDto instance) => <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.email,
      'birthDate': DateSerializer.toJson(instance.birthday),
      'gender': EnumSerializer.toJson(instance.gender),
      'address': instance.address,
      'role': EnumSerializer.toJson(instance.role),
      'primaryGuardian': instance.primaryGuardian,
      'phone': instance.phone,
    };

const _$GenderDtoEnumMap = {
  GenderDto.none: 'none',
  GenderDto.male: 'male',
  GenderDto.female: 'female',
  GenderDto.nonBinary: 'nonBinary',
};

const _$RoleDtoEnumMap = {
  RoleDto.owner: 'owner',
  RoleDto.teacher: 'teacher',
  RoleDto.participant: 'participant',
};
