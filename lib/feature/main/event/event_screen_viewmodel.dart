import 'dart:io';

import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kidventory_flutter/core/data/model/attendance_dto.dart';
import 'package:kidventory_flutter/core/data/model/event_dto.dart';
import 'package:kidventory_flutter/core/data/model/event_session_dto.dart';
import 'package:kidventory_flutter/core/data/model/member_attendance_dto.dart';
import 'package:kidventory_flutter/core/data/model/participant_dto.dart';
import 'package:kidventory_flutter/core/data/model/pending_members_dto.dart';
import 'package:kidventory_flutter/core/data/model/role_dto.dart';
import 'package:kidventory_flutter/core/data/model/update_attendance_dto.dart';
import 'package:kidventory_flutter/core/data/model/update_invite_link_dto.dart';
import 'package:kidventory_flutter/core/data/service/http/event_api_service.dart';
import 'package:kidventory_flutter/feature/main/event/event_screen_state.dart';

class EventScreenViewModel extends ChangeNotifier {
  final EventApiService _eventApiService;

  EventScreenViewModel(this._eventApiService);

  EventScreenState _state = EventScreenState();

  EventScreenState get state => _state;

  Future<void> refresh(String id) async {
    try {
      _update(loading: true);
      EventDto event = await _eventApiService.getEvent(id);
      List<PendingMembersDto> pendingMembers =
          await _eventApiService.getPendingMembers(id);
      List<ParticipantDto> participants =
          await _eventApiService.getMembers(id, event.nearestSession.id);
      Map<RoleDto, List<ParticipantDto>> participantsByRole = groupBy(
        participants,
        (participant) => participant.role,
      );
      List<EventSessionDto> sessions =
          await _eventApiService.getSessions(event.id);
      _update(
        loading: false,
        event: event,
        participants: participants,
        participantsByRole: participantsByRole,
        selectedSession: event.nearestSession,
        sessions: sessions,
        pendingMembers: pendingMembers,
      );
    } catch (e) {
      _update(loading: false);
      rethrow;
    }
  }

  Future<void> updateInviteLink(
      String eventId, UpdateInviteLinkDto request) async {
    try {
      await _eventApiService.updateInviteLink(eventId, request);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> getMembers() async {
    List<ParticipantDto> participants = await _eventApiService.getMembers(
      state.event?.id ?? '',
      state.selectedSession?.id ?? '',
    );
    Map<RoleDto, List<ParticipantDto>> participantsByRole = groupBy(
      participants,
      (participant) => participant.role,
    );
    _update(
      participants: participants,
      participantsByRole: participantsByRole,
      updatedAttendances: participants
          .where((participant) => participant.role == RoleDto.participant)
          .toList(),
    );
  }

  Future<void> getPendingMembers() async {
    List<PendingMembersDto> pendingMembers =
        await _eventApiService.getPendingMembers(
      state.event?.id ?? '',
    );
    _update();
  }

  Future<void> getSessions() async {
    List<EventSessionDto> sessions =
        await _eventApiService.getSessions(state.event?.id ?? '');
    _update(sessions: sessions);
  }

  Future<void> changeSession(EventSessionDto session) async {
    try {
      _update(loading: true);
      List<ParticipantDto> participants =
          await _eventApiService.getMembers(state.event!.id, session.id);
      Map<RoleDto, List<ParticipantDto>> participantsByRole =
          groupBy(participants, (participant) => participant.role);

      _update(
        participants: participants,
        participantsByRole: participantsByRole,
        updatedAttendances: participants
            .where((participant) => participant.role == RoleDto.participant)
            .toList(),
        selectedSession: session,
      );
    } finally {
      _update(loading: false);
    }
  }

  Future<void> updateAttendances() async {
    await _eventApiService.updateAttendance(
      state.event?.id ?? '',
      state.selectedSession?.id ?? '',
      UpdateAttendanceDto(
        attendances: state.updatedAttendances.map((participant) {
          return MemberAttendanceDto(
            memberId: participant.memberId,
            attendance: participant.attendance,
          );
        }).toList(),
      ),
    );
  }

  Future<void> editAttendance(
      ParticipantDto participant, AttendanceDto attendance) async {
    List<ParticipantDto> updatedList =
        List<ParticipantDto>.from(state.updatedAttendances);
    int index =
        updatedList.indexWhere((p) => p.memberId == participant.memberId);

    if (index != -1) {
      AttendanceDto currentAttendance = updatedList[index].attendance;

      updatedList[index] = ParticipantDto(
        memberId: updatedList[index].memberId,
        firstName: updatedList[index].firstName,
        lastName: updatedList[index].lastName,
        avatarUrl: updatedList[index].avatarUrl,
        attendance: currentAttendance == attendance
            ? AttendanceDto.unspecified
            : attendance,
        role: updatedList[index].role,
      );
    }

    _update(updatedAttendances: updatedList);
  }

  void editAllAttendances(AttendanceDto attendance) {
    bool allAlreadySet =
        state.updatedAttendances.every((p) => p.attendance == attendance);
    List<ParticipantDto> updatedList =
        state.updatedAttendances.map((participant) {
      return ParticipantDto(
        memberId: participant.memberId,
        firstName: participant.firstName,
        lastName: participant.lastName,
        avatarUrl: participant.avatarUrl,
        attendance: allAlreadySet ? AttendanceDto.unspecified : attendance,
        role: participant.role,
      );
    }).toList();

    _update(updatedAttendances: updatedList);
  }

  Future<void> deleteEvent(String id) async {
    try {
      final _ = await _eventApiService.deleteEvent(id);
    } catch (e) {
      rethrow;
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
    List<ParticipantDto>? participants,
    Map<RoleDto, List<ParticipantDto>>? participantsByRole,
    List<ParticipantDto>? updatedAttendances,
    List<EventSessionDto>? sessions,
    EventSessionDto? selectedSession,
    List<File>? files,
    List<PendingMembersDto>? pendingMembers,
  }) {
    _state = _state.copy(
      loading: loading,
      event: event,
      participants: participants,
      participantsByRole: participantsByRole,
      updatedAttendances: updatedAttendances,
      sessions: sessions,
      selectedSession: selectedSession,
      files: files,
      pendingMembers: pendingMembers,
    );

    notifyListeners();
  }
}
