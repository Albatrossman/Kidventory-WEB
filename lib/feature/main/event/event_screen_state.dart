import 'dart:io';

import 'package:kidventory_flutter/core/data/model/event_dto.dart';
import 'package:kidventory_flutter/core/data/model/participant_dto.dart';
import 'package:kidventory_flutter/core/data/model/role_dto.dart';

class EventScreenState {
  final bool loading;
  final EventDto? event;
  final List<ParticipantDto> participants;
  final Map<RoleDto, List<ParticipantDto>>? participantsByRole;
  final List<ParticipantDto> updatedAttendances;
  final List<File> files;

  EventScreenState({
    this.loading = false,
    this.event,
    List<ParticipantDto>? participants,
    Map<RoleDto, List<ParticipantDto>>? participantsByRole,
    List<ParticipantDto>? updatedAttendances,
    List<File>? files,
  }) : participants = participants ?? [], participantsByRole = participantsByRole ?? {}, updatedAttendances = updatedAttendances ?? [], files = files ?? [];

  EventScreenState copy({
    bool? loading,
    EventDto? event,
    List<ParticipantDto>? participants,
    Map<RoleDto, List<ParticipantDto>>? participantsByRole,
    List<ParticipantDto>? updatedAttendances,
    List<File>? files,
  }) {
    return EventScreenState(
      loading: loading ?? this.loading,
      event: event ?? this.event,
      participants: participants ?? this.participants,
      participantsByRole: participantsByRole ?? this.participantsByRole,
      updatedAttendances: updatedAttendances ?? this.updatedAttendances,
      files: files ?? this.files,
    );
  }
}
