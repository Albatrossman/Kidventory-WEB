import 'package:kidventory_flutter/core/data/model/attendance_dto.dart';
import 'package:kidventory_flutter/core/data/model/join_status_dto.dart';
import 'package:kidventory_flutter/core/data/model/role_dto.dart';
import 'package:kidventory_flutter/core/domain/model/color.dart';
import 'package:kidventory_flutter/core/domain/model/platform.dart';
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
    RoleDto: RoleDto.values,
    JoinStatusDto: JoinStatusDto.values, //
  };

  static int? toJson(dynamic value) => value?.index;

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

  static WeekDay? weekDayFromJson(int? index) {
    if (index == null) return null;
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

  static Platform? platformFromJson(int? index) {
    if (index == null) return null;
    if (index < 0 || index >= TimeMode.values.length) {
      throw ArgumentError('Index out of bounds for Platform decoding: $index');
    }
    return Platform.values[index];
  }

  static EventColor eventColorFromJson(int index) {
    if (index < 0 || index >= EventColor.values.length) {
      throw ArgumentError('Index out of bounds for EventColor decoding: $index');
    }
    return EventColor.values[index];
  }

  static AttendanceDto attendanceFromJson(int index) {
    if (index < 0 || index >= AttendanceDto.values.length) {
      throw ArgumentError('Index out of bounds for AttendanceDto decoding: $index');
    }
    return AttendanceDto.values[index];
  }

  static RoleDto roleFromJson(int index) {
    if (index < 0 || index >= RoleDto.values.length) {
      throw ArgumentError('Index out of bounds for RoleDto decoding: $index');
    }
    return RoleDto.values[index];
  }

  static JoinStatusDto joinStatusFromJson(int index) {
    if (index < 0 || index >= JoinStatusDto.values.length) {
      throw ArgumentError('Index out of bounds for RoleDto decoding: $index');
    }
    return JoinStatusDto.values[index];
  }

  static List<int> weekDaysToJson(List<WeekDay> days) {
    return days.map((day) => day.index).toList();
  }

  static List<WeekDay> weekDaysFromJson(List<dynamic> indices) {
    return indices.map((index) => WeekDay.values[index as int]).toList();
  }
}