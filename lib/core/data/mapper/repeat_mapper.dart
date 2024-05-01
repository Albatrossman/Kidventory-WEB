import 'package:kidventory_flutter/core/data/model/repeat_dto.dart';
import 'package:kidventory_flutter/core/domain/model/repeat.dart';
import 'package:kidventory_flutter/core/domain/model/repeat_end.dart';
import 'package:kidventory_flutter/core/ui/util/model/weekday.dart';

extension DataExtension on RepeatDto {
  Repeat toDomain() {
    return Repeat(
      period: period,
      unit: periodUnit,
      daysOfWeek: daysOfWeek.map((day) => WeekDay.values.firstWhere((e) => e.toString() == 'WeekDay.$day')).toList(),
      monthDay: monthDay,
      monthDate: dayNumberOfMonth == 0 ? null : dayNumberOfMonth,
      startDatetime: startDateTime,
      endDatetime: endDateTime,
      endsOnMode: RepeatEnd.values.firstWhere((e) => e.toString() == 'RepeatEnd.$endsOnMode'),
      maxOccurrence: maxOccurrence,
    );
  }
}

extension DomainExtension on Repeat {
  RepeatDto toDto() {
    return RepeatDto(
      period: period,
      periodUnit: unit,
      daysOfWeek: daysOfWeek?.map((day) => day.toString().split('.').last).toList() ?? [],
      monthDay: monthDay,
      dayNumberOfMonth: monthDate ?? 0,
      startDateTime: startDatetime,
      endDateTime: endDatetime,
      endsOnMode: endsOnMode,
      maxOccurrence: maxOccurrence,
    );
  }
}
