import 'package:kidventory_flutter/core/domain/model/repeat_end.dart';
import 'package:kidventory_flutter/core/domain/model/repeat_unit.dart';
import 'package:kidventory_flutter/core/ui/util/model/weekday.dart';

class Repeat {
  final int period;
  final RepeatUnit unit;
  final List<WeekDay>? daysOfWeek;
  final String? monthDay;
  final int? monthDate;
  final DateTime startDateTime;
  final RepeatEnd endsOnMode;
  final DateTime endDate;
  final int maxOccurrence;

  bool get isNever => (endsOnMode == RepeatEnd.onDate && startDateTime == endDate) ||
      (endsOnMode == RepeatEnd.afterOccurrence && maxOccurrence == 1);

  Repeat({
    required this.period,
    required this.unit,
    this.daysOfWeek,
    this.monthDay,
    this.monthDate,
    required this.startDateTime,
    required this.endsOnMode,
    required this.endDate,
    required this.maxOccurrence,
  });

  factory Repeat.defaultRepeat() {
    return Repeat(
      period: 1,
      unit: RepeatUnit.day,
      daysOfWeek: null,
      monthDay: null,
      monthDate: null,
      startDateTime: DateTime.now(),
      endsOnMode: RepeatEnd.onDate,
      endDate: DateTime.now().add(const Duration(days: 365)),
      maxOccurrence: 1,
    );
  }
}