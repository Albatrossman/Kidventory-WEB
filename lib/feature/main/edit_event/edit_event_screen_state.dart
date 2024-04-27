import 'dart:io';

import 'package:kidventory_flutter/core/domain/model/color.dart';
import 'package:kidventory_flutter/core/domain/model/member.dart';
import 'package:kidventory_flutter/core/domain/model/online_location.dart';
import 'package:kidventory_flutter/core/domain/model/repeat.dart';
import 'package:kidventory_flutter/core/domain/model/repeat_end.dart';
import 'package:kidventory_flutter/core/domain/model/repeat_unit.dart';

class EditEventScreenState {
  final bool loading;
  final String name;
  final bool allDay;
  final Repeat repeat;
  final RepeatUnit selectedRepeatUnit;
  final RepeatEnd selectedRepeatEnd;
  final Map<File, List<Member>> filesAndParticipants;
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
    Map<File, List<Member>>? filesAndParticipants,
    this.onlineLocation,
    this.color = EventColor.peacock,
    this.description = '',
  }) : repeat = repeat ?? Repeat.defaultRepeat(), filesAndParticipants = filesAndParticipants ?? {};

  EditEventScreenState copy({
    bool? loading,
    String? name,
    bool? allDay,
    String? message,
    Repeat? repeat,
    RepeatUnit? selectedRepeatUnit,
    RepeatEnd? selectedRepeatEnd,
    Map<File, List<Member>>? filesAndParticipants,
    OnlineLocation? onlineLocation,
    EventColor? color,
    String? description,
  }) {
    return EditEventScreenState(
      loading: loading ?? this.loading,
      name: name ?? this.name,
      allDay: allDay ?? this.allDay,
      message: message ?? this.message,
      selectedRepeatUnit: selectedRepeatUnit ?? this.selectedRepeatUnit,
      selectedRepeatEnd: selectedRepeatEnd ?? this.selectedRepeatEnd,
      filesAndParticipants: filesAndParticipants ?? this.filesAndParticipants,
      onlineLocation: onlineLocation ?? this.onlineLocation,
      color: color ?? this.color,
      description: description ?? this.description,
    );
  }
}
