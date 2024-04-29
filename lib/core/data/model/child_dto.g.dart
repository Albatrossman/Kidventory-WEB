// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'child_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChildDto _$ChildDtoFromJson(Map<String, dynamic> json) => ChildDto(
      id: json['id'] as String,
      parentId: json['parentId'] as String,
      avatarFile: json['avatarFile'] as String,
      avatarUrl: json['avatarUrl'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      relation: json['relation'] as String,
      birthday: DateTime.parse(json['birthday'] as String),
      age: json['age'] as int,
      address: json['address'] as String,
    );

Map<String, dynamic> _$ChildDtoToJson(ChildDto instance) => <String, dynamic>{
      'id': instance.id,
      'parentId': instance.parentId,
      'avatarFile': instance.avatarFile,
      'avatarUrl': instance.avatarUrl,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'relation': instance.relation,
      'birthday': instance.birthday.toIso8601String(),
      'age': instance.age,
      'address': instance.address,
    };
