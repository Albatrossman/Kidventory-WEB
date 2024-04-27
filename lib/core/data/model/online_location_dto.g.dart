// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'online_location_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OnlineLocationDto _$OnlineLocationDtoFromJson(Map<String, dynamic> json) => OnlineLocationDto(
      meetingApp: json['meetingApp'] as String,
      sessionLink: json['sessionLink'] as String,
      meetingId: json['meetingId'] as String,
      password: json['password'] as String,
      comment: json['comment'] as String,
      phone: json['phone'] as String,
      pin: json['pin'] as String,
    );

Map<String, dynamic> _$OnlineLocationDtoToJson(OnlineLocationDto instance) => <String, dynamic>{
      'meetingApp': instance.meetingApp,
      'sessionLink': instance.sessionLink,
      'meetingId': instance.meetingId,
      'password': instance.password,
      'comment': instance.comment,
      'phone': instance.phone,
      'pin': instance.pin,
    };
