import 'package:json_annotation/json_annotation.dart';

part 'invite_link_dto.g.dart';

@JsonSerializable()
class InviteLinkDto {
  final String? eventId;
  final DateTime? expiryDate;
  final String? id;
  final bool? isActive;
  final bool? isPrivate;
  final String? referenceId;

  InviteLinkDto({
    this.eventId,
    this.expiryDate,
    this.id,
    this.isActive,
    this.isPrivate,
    this.referenceId,
  });

    factory InviteLinkDto.fromJson(Map<String, dynamic> json) => _$InviteLinkDtoFromJson(json);
  Map<String, dynamic> toJson() => _$InviteLinkDtoToJson(this);
}
