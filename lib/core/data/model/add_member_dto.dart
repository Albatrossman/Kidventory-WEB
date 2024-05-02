import 'package:json_annotation/json_annotation.dart';
import 'package:kidventory_flutter/core/data/model/member_dto.dart';

part 'add_member_dto.g.dart';

@JsonSerializable()
class AddMemberDto {
  final List<MemberDto> participants;


  AddMemberDto({
    required this.participants,
  });

  Map<String, dynamic> toJson() => _$AddMemberDtoToJson(this);
}