import 'package:json_annotation/json_annotation.dart';
import 'package:kidventory_flutter/core/data/model/online_location_dto.dart';
import 'package:kidventory_flutter/core/data/model/repeat_dto.dart';
import 'package:kidventory_flutter/core/data/util/serializer/enum_serializer.dart';
import 'package:kidventory_flutter/core/domain/model/color.dart';
import 'package:kidventory_flutter/core/domain/model/time_mode.dart';

part 'create_event_dto.g.dart';

@JsonSerializable()
class CreateEventDto {
  final String? imageFile;
  @JsonKey(name: 'title')
  final String name;
  final String? description;
  final RepeatDto repeat;
  @JsonKey(toJson: EnumSerializer.toJson)
  final TimeMode timeMode;
  @JsonKey(toJson: EnumSerializer.toJson)
  final EventColor color;
  final OnlineLocationDto? onlineLocation;

  CreateEventDto({
    this.imageFile,
    required this.name,
    this.description,
    required this.repeat,
    required this.timeMode,
    required this.color,
    this.onlineLocation,
  });

  factory CreateEventDto.fromJson(Map<String, dynamic> json) => _$CreateEventDtoFromJson(json);
  Map<String, dynamic> toJson() => _$CreateEventDtoToJson(this);
}