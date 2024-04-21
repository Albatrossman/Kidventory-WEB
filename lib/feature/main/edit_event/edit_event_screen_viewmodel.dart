import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:kidventory_flutter/core/data/service/csv/csv_parser.dart';
import 'package:kidventory_flutter/core/domain/model/color.dart';
import 'package:kidventory_flutter/core/domain/model/member.dart';
import 'package:kidventory_flutter/core/domain/model/repeat_end.dart';
import 'package:kidventory_flutter/core/domain/model/repeat_unit.dart';
import 'package:kidventory_flutter/feature/main/edit_event/edit_event_screen_state.dart';

class EditEventScreenViewModel extends ChangeNotifier {
  final CSVParser _parser;

  EditEventScreenViewModel(this._parser);

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

  void importCSV(File file) {
    List<Member> participants = _parser.parse(file.readAsStringSync());
    Map<File, List<Member>> filesAndParticipants = Map.from(state.filesAndParticipants);
    filesAndParticipants[file] = participants;

    _update(filesAndParticipants: filesAndParticipants);
  }

  void removeCSV(File file) {
    Map<File, List<Member>> filesAndParticipants = Map.from(state.filesAndParticipants);
    filesAndParticipants.remove(file);

    _update(filesAndParticipants: filesAndParticipants);
  }

  void selectColor(EventColor color) {
    _update(color: color);
  }

  void _update({
    bool? loading,
    bool? allDay,
    String? message,
    RepeatUnit? selectedRepeatUnit,
    RepeatEnd? selectedRepeatEnd,
    Map<File, List<Member>>? filesAndParticipants,
    EventColor? color,
    String? description,
  }) {
    _state = _state.copy(
      loading: loading,
      allDay: allDay,
      message: message,
      selectedRepeatUnit: selectedRepeatUnit,
      selectedRepeatEnd: selectedRepeatEnd,
      filesAndParticipants: filesAndParticipants,
      color: color,
      description: description,
    );

    notifyListeners();
  }
}
