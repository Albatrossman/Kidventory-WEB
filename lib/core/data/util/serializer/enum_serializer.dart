import 'package:kidventory_flutter/core/domain/model/color.dart';
import 'package:kidventory_flutter/core/domain/model/repeat_end.dart';
import 'package:kidventory_flutter/core/domain/model/repeat_unit.dart';
import 'package:kidventory_flutter/core/domain/model/time_mode.dart';
import 'package:kidventory_flutter/core/ui/util/model/weekday.dart';

class EnumSerializer{
  static final Map<Type, List<dynamic>> _enumValues = {
    TimeMode: TimeMode.values,
    EventColor: EventColor.values,
    RepeatUnit: RepeatUnit.values,
    RepeatEnd: RepeatEnd.values,
  };

  static int toJson(dynamic value) => value.index;

  static T fromJson<T extends Enum>(int index) {
    var values = _enumValues[T] as List<T>;
    if (index < 0 || index >= values.length) {
      throw ArgumentError('Index out of bounds for enum decoding: $T');
    }
    return values[index];
  }

  static RepeatUnit repeatUnitFromJson(int index) {
    if (index < 0 || index >= RepeatUnit.values.length) {
      throw ArgumentError('Index out of bounds for RepeatUnit decoding: $index');
    }
    return RepeatUnit.values[index];
  }

  static WeekDay weekDayFromJson(int index) {
    if (index < 0 || index >= WeekDay.values.length) {
      throw ArgumentError('Index out of bounds for WeekDay decoding: $index');
    }
    return WeekDay.values[index];
  }

  static RepeatEnd repeatEndFromJson(int index) {
    if (index < 0 || index >= RepeatEnd.values.length) {
      throw ArgumentError('Index out of bounds for RepeatEnd decoding: $index');
    }
    return RepeatEnd.values[index];
  }

  static TimeMode timeModeFromJson(int index) {
    if (index < 0 || index >= TimeMode.values.length) {
      throw ArgumentError('Index out of bounds for TimeMode decoding: $index');
    }
    return TimeMode.values[index];
  }

  static EventColor eventColorFromJson(int index) {
    if (index < 0 || index >= EventColor.values.length) {
      throw ArgumentError('Index out of bounds for EventColor decoding: $index');
    }
    return EventColor.values[index];
  }
}