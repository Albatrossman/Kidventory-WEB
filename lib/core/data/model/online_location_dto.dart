import 'package:json_annotation/json_annotation.dart';

part 'online_location_dto.g.dart';

@JsonSerializable()
class OnlineLocationDto {
  final String meetingApp;
  final String sessionLink;
  final String meetingId;
  final String password;
  final String comment;
  final String phone;
  final String pin;

  OnlineLocationDto({
    required this.meetingApp,
    required this.sessionLink,
    required this.meetingId,
    required this.password,
    required this.comment,
    required this.phone,
    required this.pin,
  });

  factory OnlineLocationDto.fromJson(Map<String, dynamic> json) => _$OnlineLocationDtoFromJson(json);
  Map<String, dynamic> toJson() => _$OnlineLocationDtoToJson(this);
}