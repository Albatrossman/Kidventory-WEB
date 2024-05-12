import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kidventory_flutter/core/data/mapper/member_mapper.dart';
import 'package:kidventory_flutter/core/data/mapper/online_location_mapper.dart';
import 'package:kidventory_flutter/core/data/mapper/repeat_mapper.dart';
import 'package:kidventory_flutter/core/data/model/add_member_dto.dart';
import 'package:kidventory_flutter/core/data/model/create_event_dto.dart';
import 'package:kidventory_flutter/core/data/model/event_dto.dart';
import 'package:kidventory_flutter/core/data/service/csv/csv_parser.dart';
import 'package:kidventory_flutter/core/data/service/http/event_api_service.dart';
import 'package:kidventory_flutter/core/data/util/downloader/downloader.dart';
import 'package:kidventory_flutter/core/domain/model/color.dart';
import 'package:kidventory_flutter/core/domain/model/member.dart';
import 'package:kidventory_flutter/core/domain/model/online_location.dart';
import 'package:kidventory_flutter/core/domain/model/platform.dart';
import 'package:kidventory_flutter/core/domain/model/repeat.dart';
import 'package:kidventory_flutter/core/domain/model/repeat_end.dart';
import 'package:kidventory_flutter/core/domain/model/repeat_unit.dart';
import 'package:kidventory_flutter/core/domain/model/time_mode.dart';
import 'package:kidventory_flutter/core/domain/util/datetime_ext.dart';
import 'package:kidventory_flutter/core/ui/util/model/weekday.dart';
import 'package:kidventory_flutter/feature/main/edit_event/edit_event_screen_state.dart';

class EditEventScreenViewModel extends ChangeNotifier {
  final CSVParser _parser;
  final EventApiService _eventApiService;
  final Downloader downloader;

  EditEventScreenViewModel(this._parser, this._eventApiService, this.downloader);

  EditEventScreenState _state = EditEventScreenState();

  EditEventScreenState get state => _state;

  Future<String> createEvent(String name, String? imageFile, DateTime startDate) async {
    DateTime startDateTime = state.repeat.startDatetime.copyWith(
      year: startDate.year,
      month: startDate.month,
      day: startDate.day,
      hour: state.startTime.hour,
      minute: state.startTime.minute
    );
    DateTime endDateTime = state.repeat.endDatetime.copyWith(
      hour: state.endTime.hour,
      minute: state.endTime.minute
    );
    try {
      CreateEventDto createEvent = CreateEventDto(
        imageFile: imageFile,
        name: name,
        description: state.description,
        repeat: state.repeat
            .copy(
              startDatetime: state.allDay ? startDateTime.atStartOfDay : startDateTime,
              endDatetime: state.allDay ? endDateTime.atEndOfDay : endDateTime,
            )
            .toDto(),
        timeMode: state.allDay ? TimeMode.allDay : TimeMode.halting,
        onlineLocation: state.onlineLocation?.toData(),
        color: state.color,
      );

      EventDto event = await _eventApiService.createEvent(createEvent);
      await _addMembers(event.id);
      return event.id;
    } catch (exception) {
      rethrow;
    }
  }

  Future<void> _addMembers(String eventId) async {
    List<Member> allMembers = state.filesAndParticipants.values.expand((list) => list).toList();
    await _eventApiService.addMembers(
      eventId,
      AddMemberDto(participants: allMembers.map((member) => member.toData()).toList()),
    );
  }

  void editRepeat(
    int period,
    RepeatUnit unit,
    List<WeekDay> daysOfWeek,
    RepeatEnd end,
    DateTime? endDatetime,
    maxOccurrence,
  ) {
    Repeat repeat = Repeat(
      period: period,
      unit: unit,
      daysOfWeek: daysOfWeek,
      monthDay: null,
      monthDate: DateTime.now().day,
      startDatetime: state.repeat.startDatetime,
      endDatetime: endDatetime ?? state.repeat.endDatetime,
      endsOnMode: end,
      maxOccurrence: 1,
    );

    _update(repeat: repeat);
  }

  void toggleAllDay() {
    _update(allDay: !state.allDay);
  }

  void selectedStartTime(TimeOfDay time) {
    _update(
      repeat: state.repeat.copy(startDatetime: state.repeat.startDatetime.copyWithTime(time)),
      startTime: time,
    );
  }

  void selectedEndTime(TimeOfDay time) {
    _update(
      repeat: state.repeat.copy(endDatetime: state.repeat.endDatetime.copyWithTime(time)),
      endTime: time,
    );
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

  void editOnlineLocation(
    Platform platform,
    String link,
    String id,
    String password,
    String comment,
    String phone,
    String pin,
  ) {
    _update(
      onlineLocation: OnlineLocation(
        platform: Platform.meet,
        link: link,
        meetingId: id,
        password: password,
        comment: comment,
        phone: phone,
        pin: pin,
      ),
    );
  }

  void selectColor(EventColor color) {
    _update(color: color);
  }

  void editDescription(String description) {
    _update(description: description);
  }

  Future<void> downloadCSVTemplate() async {
    return await downloader.download(
        "http://dl.dropboxusercontent.com/scl/fi/atm063932wotgg9k4nn8h/Pete-s-new-template-Sheet1.csv?dl=0&rlkey=owapc95erxd8j1h11zsknh91e");
  }

  void _update({
    bool? loading,
    bool? allDay,
    String? message,
    Repeat? repeat,
    RepeatUnit? selectedRepeatUnit,
    RepeatEnd? selectedRepeatEnd,
    TimeOfDay? startTime,
    TimeOfDay? endTime,
    Map<File, List<Member>>? filesAndParticipants,
    OnlineLocation? onlineLocation,
    EventColor? color,
    String? description,
  }) {
    _state = _state.copy(
      loading: loading,
      allDay: allDay,
      message: message,
      repeat: repeat,
      selectedRepeatUnit: selectedRepeatUnit,
      selectedRepeatEnd: selectedRepeatEnd,
      startTime: startTime ?? state.startTime,
      endTime: endTime ?? state.endTime,
      filesAndParticipants: filesAndParticipants,
      onlineLocation: onlineLocation,
      color: color,
      description: description,
    );

    notifyListeners();
  }
}
