import 'package:json_annotation/json_annotation.dart';
import 'package:kidventory_flutter/core/data/util/serializer/date_time_serializer.dart';
import 'package:kidventory_flutter/core/data/util/serializer/enum_serializer.dart';
import 'package:kidventory_flutter/core/domain/model/color.dart';
import 'package:kidventory_flutter/core/domain/model/time_mode.dart';

part 'session_minimal_dto.g.dart';

@JsonSerializable()
class SessionMinimalDto {
  final String id;
  final String title;
  @JsonKey(toJson: DateTimeSerializer.toJson)
  final DateTime startDateTime;
  @JsonKey(toJson: DateTimeSerializer.toJson)
  final DateTime endDateTime;
  @JsonKey(fromJson: EnumSerializer.timeModeFromJson, toJson: EnumSerializer.toJson)
  final TimeMode timeMode;
  @JsonKey(fromJson: EnumSerializer.eventColorFromJson, toJson: EnumSerializer.toJson)
  final EventColor color;

  SessionMinimalDto({
    required this.id,
    required this.title,
    required this.timeMode,
    required this.color,
    required this.startDateTime,
    required this.endDateTime
  });

  factory SessionMinimalDto.fromJson(Map<String, dynamic> json) => _$SessionMinimalDtoFromJson(json);
  Map<String, dynamic> toJson() => _$SessionMinimalDtoToJson(this);
}