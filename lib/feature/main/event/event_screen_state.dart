import 'dart:io';

import 'package:kidventory_flutter/core/data/model/event_dto.dart';
import 'package:kidventory_flutter/core/data/model/participant_dto.dart';

class EventScreenState {
  final bool loading;
  final EventDto? event;
  final List<ParticipantDto> participants;
  final List<File> files;

  EventScreenState({
    this.loading = false,
    this.event,
    List<ParticipantDto>? participants,
    List<File>? files,
  }) : participants = participants ?? [], files = files ?? [];

  EventScreenState copy({
    bool? loading,
    EventDto? event,
    List<ParticipantDto>? participants,
    List<File>? files,
  }) {
    return EventScreenState(
      loading: loading ?? this.loading,
      event: event,
      participants: participants ?? this.participants,
      files: files ?? this.files,
    );
  }
}
