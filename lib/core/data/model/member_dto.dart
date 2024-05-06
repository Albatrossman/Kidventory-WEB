import 'package:json_annotation/json_annotation.dart';
import 'package:kidventory_flutter/core/data/model/gender_dto.dart';
import 'package:kidventory_flutter/core/data/model/role_dto.dart';
import 'package:kidventory_flutter/core/data/util/serializer/date_serializer.dart';
import 'package:kidventory_flutter/core/data/util/serializer/enum_serializer.dart';

part 'member_dto.g.dart';

@JsonSerializable()
class MemberDto {
  String firstName;
  String lastName;
  String email;
  @JsonKey(name: 'birthDate', toJson: DateSerializer.toJson)
  DateTime? birthday;
  @JsonKey(toJson: EnumSerializer.toJson)
  GenderDto? gender;
  String? address;
  @JsonKey(toJson: EnumSerializer.toJson)
  RoleDto? role;
  String? primaryGuardian;
  String? phone;

  MemberDto({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.birthday,
    required this.gender,
    required this.address,
    required this.role,
    required this.primaryGuardian,
    required this.phone,
  });

  factory MemberDto.fromJson(Map<String, dynamic> json) => _$MemberDtoFromJson(json);
  Map<String, dynamic> toJson() => _$MemberDtoToJson(this);
}
