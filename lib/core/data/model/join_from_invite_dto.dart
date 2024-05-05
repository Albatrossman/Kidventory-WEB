import 'package:json_annotation/json_annotation.dart';

part 'join_from_invite_dto.g.dart';

@JsonSerializable()
class JoinFromInvitetDto {
  final bool includeMeAsAdult;
  final List<String> memberIds;

  JoinFromInvitetDto({
    required this.includeMeAsAdult,
    required this.memberIds,
  });

  factory JoinFromInvitetDto.fromJson(Map<String, dynamic> json) =>
      _$JoinFromInvitetDtoFromJson(json);
  Map<String, dynamic> toJson() => _$JoinFromInvitetDtoToJson(this);
}
