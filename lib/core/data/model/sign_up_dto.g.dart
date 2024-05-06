// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_up_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignUpDto _$SignUpDtoFromJson(Map<String, dynamic> json) => SignUpDto(
      email: json['email'] as String,
      firstname: json['firstname'] as String,
      lastname: json['lastname'] as String,
      password: json['password'] as String,
      timezone: json['timezone'] as String,
    );

Map<String, dynamic> _$SignUpDtoToJson(SignUpDto instance) => <String, dynamic>{
      'email': instance.email,
      'firstname': instance.firstname,
      'lastname': instance.lastname,
      'password': instance.password,
      'timezone': instance.timezone,
    };
