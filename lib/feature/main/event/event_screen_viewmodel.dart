import 'dart:io';

import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kidventory_flutter/core/data/model/attendance_dto.dart';
import 'package:kidventory_flutter/core/data/model/event_dto.dart';
import 'package:kidventory_flutter/core/data/model/member_attendance_dto.dart';
import 'package:kidventory_flutter/core/data/model/participant_dto.dart';
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
      EventDto event = await _eventApiService.getEvent(id);
      List<ParticipantDto> participants =
          await _eventApiService.getMembers(id, event.nearestSession.id);
      Map<RoleDto, List<ParticipantDto>> participantsByRole = groupBy(
        participants,
        (participant) => participant.role,
      );
      _update(
          event: event,
          participants: participants,
          participantsByRole: participantsByRole);
    } catch (e) {
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

  Future<void> getMembers(String eventId, String sessionId) async {
    List<ParticipantDto> participants =
        await _eventApiService.getMembers(eventId, sessionId);
    Map<RoleDto, List<ParticipantDto>> participantsByRole = groupBy(
      participants,
      (participant) => participant.role,
    );
    _update(participants: participants, participantsByRole: participantsByRole);
  }

  Future<void> updateAttendances(String eventId, String sessionId) async {
    await _eventApiService.updateAttendance(
      eventId,
      sessionId,
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
      updatedList[index] = ParticipantDto(
        memberId: updatedList[index].memberId,
        firstName: updatedList[index].firstName,
        lastName: updatedList[index].lastName,
        avatarUrl: updatedList[index].avatarUrl,
        attendance: attendance,
        role: updatedList[index].role,
      );
    }

    _update(updatedAttendances: updatedList);
  }

  void editAllAttendances(AttendanceDto attendance) {
    List<ParticipantDto> updatedList = state.participants.map((participant) {
      return ParticipantDto(
        memberId: participant.memberId,
        firstName: participant.firstName,
        lastName: participant.lastName,
        avatarUrl: participant.avatarUrl,
        attendance: attendance,
        role: participant.role,
      );
    }).toList();

    _update(updatedAttendances: updatedList);
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
    List<File>? files,
  }) {
    _state = _state.copy(
      loading: loading,
      event: event,
      participants: participants,
      participantsByRole: participantsByRole,
      updatedAttendances: updatedAttendances,
      files: files,
    );

    notifyListeners();
  }
}
