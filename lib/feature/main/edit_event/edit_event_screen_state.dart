import 'package:kidventory_flutter/core/ui/util/model/repeat_end.dart';
import 'package:kidventory_flutter/core/ui/util/model/repeat_unit.dart';

class EditEventScreenState {
  final bool loading;
  final bool allDay;
  final String? message;
  final RepeatUnit selectedRepeatUnit;
  final RepeatEnd selectedRepeatEnd;

  EditEventScreenState(
      {this.loading = false,
      this.allDay = false,
      this.message,
      this.selectedRepeatUnit = RepeatUnit.day,
      this.selectedRepeatEnd = RepeatEnd.onDate});

  EditEventScreenState copy(
      {bool? loading,
      bool? allDay,
      String? message,
      RepeatUnit? selectedRepeatUnit,
      RepeatEnd? selectedRepeatEnd}) {
    return EditEventScreenState(
      loading: loading ?? this.loading,
      allDay: allDay ?? this.allDay,
      message: message ?? this.message,
      selectedRepeatUnit: selectedRepeatUnit ?? this.selectedRepeatUnit,
      selectedRepeatEnd: selectedRepeatEnd ?? this.selectedRepeatEnd,
    );
  }
}
