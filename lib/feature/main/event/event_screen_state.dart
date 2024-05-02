import 'dart:io';

import 'package:kidventory_flutter/core/data/model/event_dto.dart';
import 'package:kidventory_flutter/core/data/model/event_session_dto.dart';
import 'package:kidventory_flutter/core/data/model/participant_dto.dart';
import 'package:kidventory_flutter/core/data/model/role_dto.dart';

class EventScreenState {
  final bool loading;
  final EventDto? event;
  final List<ParticipantDto> participants;
  final Map<RoleDto, List<ParticipantDto>>? participantsByRole;
  final List<ParticipantDto> updatedAttendances;
  final List<EventSessionDto> sessions;
  final EventSessionDto? selectedSession;
  final List<File> files;

  EventScreenState({
    this.loading = false,
    this.event,
    List<ParticipantDto>? participants,
    Map<RoleDto, List<ParticipantDto>>? participantsByRole,
    List<ParticipantDto>? updatedAttendances,
    List<EventSessionDto>? sessions,
    this.selectedSession,
    List<File>? files,
  }) : participants = participants ?? [], participantsByRole = participantsByRole ?? {}, updatedAttendances = updatedAttendances ?? [], sessions = sessions ?? [], files = files ?? [];

  EventScreenState copy({
    bool? loading,
    EventDto? event,
    List<ParticipantDto>? participants,
    Map<RoleDto, List<ParticipantDto>>? participantsByRole,
    List<ParticipantDto>? updatedAttendances,
    List<EventSessionDto>? sessions,
    EventSessionDto? selectedSession,
    List<File>? files,
  }) {
    return EventScreenState(
      loading: loading ?? this.loading,
      event: event ?? this.event,
      participants: participants ?? this.participants,
      participantsByRole: participantsByRole ?? this.participantsByRole,
      updatedAttendances: updatedAttendances ?? this.updatedAttendances,
      sessions: sessions ?? this.sessions,
      selectedSession: selectedSession ?? this.selectedSession,
      files: files ?? this.files,
    );
  }
}
