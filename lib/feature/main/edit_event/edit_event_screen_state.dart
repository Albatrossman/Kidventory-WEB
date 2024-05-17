
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kidventory_flutter/core/domain/model/color.dart';
import 'package:kidventory_flutter/core/domain/model/member.dart';
import 'package:kidventory_flutter/core/domain/model/online_location.dart';
import 'package:kidventory_flutter/core/domain/model/repeat.dart';
import 'package:kidventory_flutter/core/domain/model/repeat_end.dart';
import 'package:kidventory_flutter/core/domain/model/repeat_unit.dart';
import 'package:kidventory_flutter/core/ui/util/extension/date_time_extension.dart';

class EditEventScreenState {
  final bool loading;
  final String name;
  final bool allDay;
  final Repeat repeat;
  final RepeatUnit selectedRepeatUnit;
  final RepeatEnd selectedRepeatEnd;
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final Map<XFile, List<Member>> filesAndParticipants;
  final OnlineLocation? onlineLocation;
  final EventColor color;
  final String description;
  final String? message;

  EditEventScreenState({
    this.loading = false,
    this.name = '',
    this.allDay = false,
    this.message,
    Repeat? repeat,
    this.selectedRepeatUnit = RepeatUnit.day,
    this.selectedRepeatEnd = RepeatEnd.onDate,
    TimeOfDay? startTime,
    TimeOfDay? endTime,
    Map<XFile, List<Member>>? filesAndParticipants,
    this.onlineLocation,
    this.color = EventColor.peacock,
    this.description = '',
  })  : repeat = repeat ?? Repeat.defaultRepeat(),
        startTime = startTime ?? TimeOfDay.now().roundedToNextQuarter(),
        endTime = endTime ??
            startTime?.roundedToNextQuarter().replacing(hour: (startTime.hour) % 24) ??
            TimeOfDay.now().roundedToNextQuarter().replacing(hour: (TimeOfDay.now().hour + 1) % 24),
        filesAndParticipants = filesAndParticipants ?? {};

  EditEventScreenState copy({
    bool? loading,
    String? name,
    bool? allDay,
    String? message,
    TimeOfDay? startTime,
    TimeOfDay? endTime,
    Repeat? repeat,
    RepeatUnit? selectedRepeatUnit,
    RepeatEnd? selectedRepeatEnd,
    Map<XFile, List<Member>>? filesAndParticipants,
    OnlineLocation? onlineLocation,
    EventColor? color,
    String? description,
  }) {
    return EditEventScreenState(
      loading: loading ?? this.loading,
      name: name ?? this.name,
      allDay: allDay ?? this.allDay,
      message: message ?? this.message,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      repeat: repeat ?? this.repeat,
      selectedRepeatUnit: selectedRepeatUnit ?? this.selectedRepeatUnit,
      selectedRepeatEnd: selectedRepeatEnd ?? this.selectedRepeatEnd,
      filesAndParticipants: filesAndParticipants ?? this.filesAndParticipants,
      onlineLocation: onlineLocation ?? this.onlineLocation,
      color: color ?? this.color,
      description: description ?? this.description,
    );
  }
}
