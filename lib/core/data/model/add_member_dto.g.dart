// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_member_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddMemberDto _$AddMemberDtoFromJson(Map<String, dynamic> json) => AddMemberDto(
      participants: (json['participants'] as List<dynamic>)
          .map((e) => MemberDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AddMemberDtoToJson(AddMemberDto instance) =>
    <String, dynamic>{
      'participants': instance.participants,
    };
