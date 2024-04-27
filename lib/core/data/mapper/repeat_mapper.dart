import 'package:kidventory_flutter/core/data/model/repeat_dto.dart';
import 'package:kidventory_flutter/core/domain/model/repeat.dart';
import 'package:kidventory_flutter/core/domain/model/repeat_end.dart';
import 'package:kidventory_flutter/core/domain/model/repeat_unit.dart';
import 'package:kidventory_flutter/core/ui/util/model/weekday.dart';

extension DataExtension on RepeatDto {
  Repeat toDomain() {
    return Repeat(
      period: period,
      unit: RepeatUnit.values.firstWhere((e) => e.toString() == 'RepeatUnit.$periodUnit'),
      daysOfWeek: weekDays.map((day) => WeekDay.values.firstWhere((e) => e.toString() == 'WeekDay.$day')).toList(),
      monthDay: monthDay.isEmpty ? null : monthDay,
      monthDate: dayNumberOfMonth == 0 ? null : dayNumberOfMonth,
      startDateTime: startDateTime,
      endsOnMode: RepeatEnd.values.firstWhere((e) => e.toString() == 'RepeatEnd.$endsOnMode'),
      endDate: endDate,
      maxOccurrence: maxOccurrence,
    );
  }
}

extension DomainExtension on Repeat {
  RepeatDto toDto() {
    return RepeatDto(
      id: '',
      period: period,
      periodUnit: unit.toString().split('.').last,
      weekDays: daysOfWeek?.map((day) => day.toString().split('.').last).toList() ?? [],
      monthDay: monthDay ?? '',
      dayNumberOfMonth: monthDate ?? 0,
      startDateTime: startDateTime,
      endsOnMode: endsOnMode.toString().split('.').last,
      endDate: endDate,
      maxOccurrence: maxOccurrence,
    );
  }
}
