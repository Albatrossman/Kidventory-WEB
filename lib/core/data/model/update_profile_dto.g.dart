// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_profile_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateProfileDto _$UpdateProfileDtoFromJson(Map<String, dynamic> json) =>
    UpdateProfileDto(
      avatarFile: json['avatarFile'] as String?,
      avatarUrl: json['avatarUrl'] as String?,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
    );

Map<String, dynamic> _$UpdateProfileDtoToJson(UpdateProfileDto instance) =>
    <String, dynamic>{
      'avatarFile': instance.avatarFile,
      'avatarUrl': instance.avatarUrl,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
    };
