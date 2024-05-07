import 'package:kidventory_flutter/core/domain/model/repeat_end.dart';
import 'package:kidventory_flutter/core/domain/model/repeat_unit.dart';
import 'package:kidventory_flutter/core/domain/model/time_mode.dart';
import 'package:kidventory_flutter/core/ui/util/model/weekday.dart';

class Repeat {
  final int period;
  final RepeatUnit unit;
  final List<WeekDay>? daysOfWeek;
  final WeekDay? monthDay;
  final int? monthDate;
  final DateTime startDatetime;
  final DateTime endDatetime;
  final RepeatEnd endsOnMode;
  final int maxOccurrence;

  bool get isNever =>
      (endsOnMode == RepeatEnd.onDate && startDatetime == endDatetime) ||
      (endsOnMode == RepeatEnd.afterOccurrence && maxOccurrence == 1);

  Repeat({
    required this.period,
    required this.unit,
    this.daysOfWeek,
    this.monthDay,
    this.monthDate,
    required this.startDatetime,
    required this.endsOnMode,
    required this.endDatetime,
    required this.maxOccurrence,
  });

  factory Repeat.defaultRepeat() {
    return Repeat(
      period: 1,
      unit: RepeatUnit.day,
      daysOfWeek: null,
      monthDay: null,
      monthDate: null,
      startDatetime: DateTime.now(),
      endsOnMode: RepeatEnd.onDate,
      endDatetime: DateTime.now().add(const Duration(days: 365, hours: 1)),
      maxOccurrence: 1,
    );
  }

  Repeat copy({
    DateTime? startDatetime,
    DateTime? endDatetime,
  }) {
    return Repeat(
      period: period,
      unit: unit,
      daysOfWeek: daysOfWeek,
      monthDay: monthDay,
      monthDate: monthDate,
      startDatetime: startDatetime ?? this.startDatetime,
      endDatetime: endDatetime ?? this.endDatetime,
      endsOnMode: endsOnMode,
      maxOccurrence: maxOccurrence,
    );
  }
}
