import 'package:kidventory_flutter/core/domain/model/color.dart';
import 'package:kidventory_flutter/core/domain/model/repeat_end.dart';
import 'package:kidventory_flutter/core/domain/model/repeat_unit.dart';
import 'package:kidventory_flutter/core/domain/model/time_mode.dart';

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
}