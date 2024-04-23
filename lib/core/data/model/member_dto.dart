import 'package:json_annotation/json_annotation.dart';
import 'package:kidventory_flutter/core/domain/model/role.dart';

part 'member_dto.g.dart';

@JsonSerializable()
class MemberDto {
  String firstName;
  String lastName;
  String email;
  int age;
  String gender;
  String address;
  Role role;
  String? primaryGuardian;
  List<String> phone;

  MemberDto({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.age,
    required this.gender,
    required this.address,
    required this.role,
    required this.primaryGuardian,
    required this.phone,
  });

  factory MemberDto.fromJson(Map<String, dynamic> json) => _$MemberDtoFromJson(json);
  Map<String, dynamic> toJson() => _$MemberDtoToJson(this);
}
