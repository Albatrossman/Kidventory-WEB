import 'package:flutter/foundation.dart';
import 'package:kidventory_flutter/core/ui/util/model/repeat_end.dart';
import 'package:kidventory_flutter/core/ui/util/model/repeat_unit.dart';
import 'package:kidventory_flutter/feature/main/edit_event/edit_event_screen_state.dart';

class EditEventScreenViewModel extends ChangeNotifier {
  EditEventScreenState _state = EditEventScreenState();

  EditEventScreenState get state => _state;

  void toggleAllDay() {
    _update(allDay: !state.allDay);
  }

  void selectRepeatUnit(RepeatUnit unit) {
    _update(selectedRepeatUnit: unit);
  }

  void selectRepeatEnd(RepeatEnd end) {
    _update(selectedRepeatEnd: end);
  }

  void _update(
      {bool? loading,
      bool? allDay,
      String? message,
      RepeatUnit? selectedRepeatUnit,
      RepeatEnd? selectedRepeatEnd}) {
    _state = _state.copy(
      loading: loading,
      allDay: allDay,
      message: message,
      selectedRepeatUnit: selectedRepeatUnit,
      selectedRepeatEnd: selectedRepeatEnd,
    );
    notifyListeners();
  }
}
