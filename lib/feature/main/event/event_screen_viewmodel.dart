import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kidventory_flutter/core/domain/model/color.dart';
import 'package:kidventory_flutter/core/domain/model/repeat_end.dart';
import 'package:kidventory_flutter/core/domain/model/repeat_unit.dart';
import 'package:kidventory_flutter/feature/main/event/event_screen_state.dart';

class EventScreenViewModel extends ChangeNotifier {
  EventScreenState _state = EventScreenState();
  EventScreenState get state => _state;

  void selectRepeatUnit(RepeatUnit unit) {
    _update(selectedRepeatUnit: unit);
  }

  void selectRepeatEnd(RepeatEnd end) {
    _update(selectedRepeatEnd: end);
  }

  void importCSV(File file) {
    List<File> files = List<File>.from(state.files);
    files.add(file);
    _update(files: files);
  }

  void removeCSV(File file) {
    List<File> updatedFiles = state.files.where((f) => f != file).toList();
    _update(files: updatedFiles);
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
    List<File>? files,
    EventColor? color,
    String? description,
  }) {
    _state = _state.copy(
        loading: loading,
        files: files,
        color: color,
        description: description
    );

    notifyListeners();
  }
}
