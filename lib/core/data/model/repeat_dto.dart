import 'package:json_annotation/json_annotation.dart';

part 'repeat_dto.g.dart';

@JsonSerializable()
class RepeatDto {
  final String id;
  final int period;
  final String periodUnit;
  final List<String> weekDays;
  final String monthDay;
  final int dayNumberOfMonth;
  final DateTime startDateTime;
  final String endsOnMode;
  final DateTime endDate;
  final int maxOccurrence;

  RepeatDto({
    required this.id,
    required this.period,
    required this.periodUnit,
    required this.weekDays,
    required this.monthDay,
    required this.dayNumberOfMonth,
    required this.startDateTime,
    required this.endsOnMode,
    required this.endDate,
    required this.maxOccurrence,
  });

  factory RepeatDto.fromJson(Map<String, dynamic> json) => _$RepeatDtoFromJson(json);
  Map<String, dynamic> toJson() => _$RepeatDtoToJson(this);
}