import 'package:flutter/foundation.dart';
import 'package:kidventory_flutter/feature/main/edit_event/edit_event_screen_state.dart';

class EditEventScreenViewModel extends ChangeNotifier {

  EditEventScreenState _state = EditEventScreenState();
  EditEventScreenState get state => _state;

  void toggleAllDay() {
    _update(allDay: !state.allDay);
  }

  void _update({bool? loading, bool? allDay, String? message}) {
    _state = _state.copy(loading: loading, allDay: allDay, message: message);
    notifyListeners();
  }
}
