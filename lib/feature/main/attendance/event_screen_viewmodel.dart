import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kidventory_flutter/core/data/model/event_dto.dart';
import 'package:kidventory_flutter/core/data/service/http/event_api_service.dart';
import 'package:kidventory_flutter/feature/main/event/event_screen_state.dart';

class AttendanceScreenViewModel extends ChangeNotifier {
  final EventApiService _eventApiService;

  AttendanceScreenViewModel(this._eventApiService);
  
  EventScreenState _state = EventScreenState();
  EventScreenState get state => _state;

  void refresh(String id) async {
    try {
      EventDto event = await _eventApiService.getEvent(id);
      _update(event: event);
    } catch (e) {
      // Donno yet
    }
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

  void _update({
    bool? loading,
    EventDto? event,
    List<File>? files,
  }) {
    _state = _state.copy(
      loading: loading,
      event: event,
      files: files,
    );

    notifyListeners();
  }
}
