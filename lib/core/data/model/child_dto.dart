import 'package:json_annotation/json_annotation.dart';
import 'package:kidventory_flutter/core/ui/util/model/child_info.dart';

part 'child_dto.g.dart';

@JsonSerializable()
class ChildDto {
  final String id;
  final String parentId;
  final String avatarFile;
  final String avatarUrl;
  final String firstName;
  final String lastName;
  final String relation;
  final DateTime birthday;
  final int age;
  final String address;

  ChildDto({
    required this.id,
    required this.parentId,
    required this.avatarFile,
    required this.avatarUrl,
    required this.firstName,
    required this.lastName,
    required this.relation,
    required this.birthday,
    required this.age,
    required this.address,
  });

  factory ChildDto.fromJson(Map<String, dynamic> json) =>
      _$ChildDtoFromJson(json);
  Map<String, dynamic> toJson() => _$ChildDtoToJson(this);

  ChildInfo convertToChildInfo() {
    return ChildInfo(
      id: id,
      image: avatarUrl,
      firstName: firstName,
      lastName: lastName,
      birthday: birthday,
      relation: relation,
    );
  }
}
