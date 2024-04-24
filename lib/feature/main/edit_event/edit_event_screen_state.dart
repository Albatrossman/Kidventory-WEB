import 'dart:io';

import 'package:kidventory_flutter/core/domain/model/color.dart';
import 'package:kidventory_flutter/core/domain/model/member.dart';
import 'package:kidventory_flutter/core/domain/model/repeat_end.dart';
import 'package:kidventory_flutter/core/domain/model/repeat_unit.dart';

class EditEventScreenState {
  final bool loading;
  final bool allDay;
  final String? message;
  final RepeatUnit selectedRepeatUnit;
  final RepeatEnd selectedRepeatEnd;
  final Map<File, List<Member>> filesAndParticipants;
  final EventColor color;
  final String description;

  EditEventScreenState({
    this.loading = false,
    this.allDay = false,
    this.message,
    this.selectedRepeatUnit = RepeatUnit.day,
    this.selectedRepeatEnd = RepeatEnd.onDate,
    Map<File, List<Member>>? filesAndParticipants,
    this.color = EventColor.peacock,
    this.description = '',
  }) : filesAndParticipants = filesAndParticipants ?? {};

  EditEventScreenState copy({
    bool? loading,
    bool? allDay,
    String? message,
    RepeatUnit? selectedRepeatUnit,
    RepeatEnd? selectedRepeatEnd,
    Map<File, List<Member>>? filesAndParticipants,
    EventColor? color,
    String? description,
  }) {
    return EditEventScreenState(
      loading: loading ?? this.loading,
      allDay: allDay ?? this.allDay,
      message: message ?? this.message,
      selectedRepeatUnit: selectedRepeatUnit ?? this.selectedRepeatUnit,
      selectedRepeatEnd: selectedRepeatEnd ?? this.selectedRepeatEnd,
      filesAndParticipants: filesAndParticipants ?? this.filesAndParticipants,
      color: color ?? this.color,
      description: description ?? this.description,
    );
  }
}
