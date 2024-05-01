import 'package:json_annotation/json_annotation.dart';
import 'package:kidventory_flutter/core/data/util/serializer/date_time_serializer.dart';
import 'package:kidventory_flutter/core/data/util/serializer/enum_serializer.dart';
import 'package:kidventory_flutter/core/domain/model/repeat_end.dart';
import 'package:kidventory_flutter/core/domain/model/repeat_unit.dart';
import 'package:kidventory_flutter/core/ui/util/model/weekday.dart';

part 'repeat_dto.g.dart';

@JsonSerializable()
class RepeatDto {
  final int period;
  @JsonKey(toJson: EnumSerializer.toJson)
  final RepeatUnit periodUnit;
  @JsonKey(name: 'weekDays')
  final List<String> daysOfWeek;
  @JsonKey(toJson: EnumSerializer.toJson)
  final WeekDay? monthDay;
  final int dayNumberOfMonth;
  @JsonKey(toJson: DateTimeSerializer.toJson)
  final DateTime startDateTime;
  @JsonKey(toJson: DateTimeSerializer.toJson)
  final DateTime endDateTime;
  @JsonKey(toJson: EnumSerializer.toJson)
  final RepeatEnd endsOnMode;
  final int maxOccurrence;

  RepeatDto({
    required this.period,
    required this.periodUnit,
    required this.daysOfWeek,
    required this.monthDay,
    required this.dayNumberOfMonth,
    required this.startDateTime,
    required this.endsOnMode,
    required this.endDateTime,
    required this.maxOccurrence,
  });

  factory RepeatDto.fromJson(Map<String, dynamic> json) => _$RepeatDtoFromJson(json);
  Map<String, dynamic> toJson() => _$RepeatDtoToJson(this);
}