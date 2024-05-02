import 'package:json_annotation/json_annotation.dart';

part 'update_invite_link_dto.g.dart';

@JsonSerializable()
class UpdateInviteLinkDto {
  final bool isActive;
  final bool isPrivate;
  final DateTime? expirationDate;

  UpdateInviteLinkDto({
    required this.isActive,
    required this.isPrivate,
    this.expirationDate,
  });

  factory UpdateInviteLinkDto.fromJson(Map<String, dynamic> json) =>
      _$UpdateInviteLinkDtoFromJson(json);
  Map<String, dynamic> toJson() => _$UpdateInviteLinkDtoToJson(this);
}
