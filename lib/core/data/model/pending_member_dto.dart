import 'package:json_annotation/json_annotation.dart';
import 'package:kidventory_flutter/core/data/model/join_status_dto.dart';
import 'package:kidventory_flutter/core/data/model/role_dto.dart';
import 'package:kidventory_flutter/core/data/util/serializer/enum_serializer.dart';

part 'pending_member_dto.g.dart';

@JsonSerializable()
class PendingMemberDto {
  final String id;
  final String memberId;

  @JsonKey(fromJson: EnumSerializer.roleFromJson, toJson: EnumSerializer.toJson)
  final RoleDto role;
  @JsonKey(fromJson: EnumSerializer.joinStatusFromJson, toJson: EnumSerializer.toJson)
  final JoinStatusDto state;
  final String firstName;
  final String lastName;
  final String adultUserId;
  final String adultFirstName;
  final String adultLastName;

  PendingMemberDto({
    required this.id,
    required this.memberId,
    required this.role,
    required this.state,
    required this.firstName,
    required this.lastName,
    required this.adultUserId,
    required this.adultFirstName,
    required this.adultLastName,
  });

  factory PendingMemberDto.fromJson(Map<String, dynamic> json) =>
      _$PendingMemberDtoFromJson(json);
  Map<String, dynamic> toJson() => _$PendingMemberDtoToJson(this);
}
