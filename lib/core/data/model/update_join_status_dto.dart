import 'package:json_annotation/json_annotation.dart';
import 'package:kidventory_flutter/core/data/model/join_status_dto.dart';
import 'package:kidventory_flutter/core/data/model/role_dto.dart';
import 'package:kidventory_flutter/core/data/util/serializer/enum_serializer.dart';

part 'update_join_status_dto.g.dart';

@JsonSerializable()
class UpdateJoinStatusDto {
  final String participantUserId;
  final String participantMemberId;
  @JsonKey(fromJson: EnumSerializer.roleFromJson, toJson: EnumSerializer.toJson)
  final RoleDto role;
  @JsonKey(fromJson: EnumSerializer.joinStatusFromJson, toJson: EnumSerializer.toJson)
  final JoinStatusDto state;

  UpdateJoinStatusDto({
    required this.participantUserId,
    required this.participantMemberId,
    required this.role,
    required this.state,
  });

  factory UpdateJoinStatusDto.fromJson(Map<String, dynamic> json) =>
      _$UpdateJoinStatusDtoFromJson(json);
  Map<String, dynamic> toJson() => _$UpdateJoinStatusDtoToJson(this);
}
