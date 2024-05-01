import 'package:json_annotation/json_annotation.dart';

part 'online_location_dto.g.dart';

@JsonSerializable()
class OnlineLocationDto {
  final String? meetingApp;
  final String? sessionLink;
  final String? meetingId;
  final String? password;
  final String? comment;
  final String? phone;
  final String? pin;

  OnlineLocationDto({
    this.meetingApp,
    this.sessionLink,
    this.meetingId,
    this.password,
    this.comment,
    this.phone,
    this.pin,
  });

  factory OnlineLocationDto.fromJson(Map<String, dynamic> json) =>
      _$OnlineLocationDtoFromJson(json);
  Map<String, dynamic> toJson() => _$OnlineLocationDtoToJson(this);
}
