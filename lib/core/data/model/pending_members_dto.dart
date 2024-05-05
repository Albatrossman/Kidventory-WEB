import 'package:json_annotation/json_annotation.dart';
import 'package:kidventory_flutter/core/data/model/pending_member_dto.dart';

part 'pending_members_dto.g.dart';

@JsonSerializable()
class PendingMembersDto {
  final String id;
  final String eventId;
  final List<PendingMemberDto> members;

  PendingMembersDto({
    required this.id,
    required this.eventId,
    required this.members,
  });

  factory PendingMembersDto.fromJson(Map<String, dynamic> json) => _$PendingMembersDtoFromJson(json);
  Map<String, dynamic> toJson() => _$PendingMembersDtoToJson(this);
}