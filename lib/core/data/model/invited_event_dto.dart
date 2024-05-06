import 'package:json_annotation/json_annotation.dart';
import 'package:kidventory_flutter/core/data/model/event_dto.dart';

part 'invited_event_dto.g.dart';

@JsonSerializable()
class InvitedEventDto {
  @JsonKey(name: 'eventDetail')
  final EventDto eventDto;
  final bool isPrivate;

  InvitedEventDto({
    required this.eventDto,
    required this.isPrivate,
  });

  factory InvitedEventDto.fromJson(Map<String, dynamic> json) =>
      _$InvitedEventDtoFromJson(json);
  Map<String, dynamic> toJson() => _$InvitedEventDtoToJson(this);
}
