// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_password_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdatePasswordDto _$UpdatePasswordDtoFromJson(Map<String, dynamic> json) =>
    UpdatePasswordDto(
      email: json['email'] as String,
      currentPassword: json['currentPassword'] as String,
      newPassword: json['newPassword'] as String,
      confirmNewPassword: json['confirmNewPassword'] as String,
    );

Map<String, dynamic> _$UpdatePasswordDtoToJson(UpdatePasswordDto instance) =>
    <String, dynamic>{
      'email': instance.email,
      'currentPassword': instance.currentPassword,
      'newPassword': instance.newPassword,
      'confirmNewPassword': instance.confirmNewPassword,
    };
