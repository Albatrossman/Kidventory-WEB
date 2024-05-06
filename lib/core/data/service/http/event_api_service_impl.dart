import 'package:dio/dio.dart';
import 'package:kidventory_flutter/core/data/model/event_session_dto.dart';
import 'package:kidventory_flutter/core/data/model/add_member_dto.dart';
import 'package:kidventory_flutter/core/data/model/change_members_role_dto.dart';
import 'package:kidventory_flutter/core/data/model/create_event_dto.dart';
import 'package:kidventory_flutter/core/data/model/event_dto.dart';
import 'package:kidventory_flutter/core/data/model/invited_event_dto.dart';
import 'package:kidventory_flutter/core/data/model/join_from_invite_dto.dart';
import 'package:kidventory_flutter/core/data/model/participant_dto.dart';
import 'package:kidventory_flutter/core/data/model/pending_members_dto.dart';
import 'package:kidventory_flutter/core/data/model/update_attendance_dto.dart';
import 'package:kidventory_flutter/core/data/model/update_invite_link_dto.dart';
import 'package:kidventory_flutter/core/data/model/update_join_status_dto.dart';
import 'package:kidventory_flutter/core/data/service/http/event_api_service.dart';
import 'package:kidventory_flutter/core/data/util/dio_client.dart';

class EventApiServiceImpl extends EventApiService {
  final DioClient client;

  EventApiServiceImpl(this.client);

  @override
  Future<EventDto> createEvent(CreateEventDto event) async {
    Response response = await client.dio.post('events', data: event.toJson());
    return EventDto.fromJson(response.data!);
  }

  @override
  Future<EventDto> getEvent(String id) async {
    Response response = await client.dio.get('events/$id');
    return EventDto.fromJson(response.data);
  }

  @override
  Future<EventDto> editEvent(String id, EventDto event) async {
    Response response = await client.dio.put('events/$id');
    return EventDto.fromJson(response.data);
  }

  @override
  Future<void> deleteEvent(String id) async {
    await client.dio.delete('events/$id');
  }

  @override
  Future<void> addMembers(String eventId, AddMemberDto body) async {
    await client.dio.post('events/$eventId/members', data: body);
  }

  @override
  Future<List<ParticipantDto>> getMembers(
      String eventId, String sessionId) async {
    Response response =
        await client.dio.get('events/$eventId/sessions/$sessionId/members');
    var participantsJson = response.data as List;
    return participantsJson
        .map<ParticipantDto>((json) => ParticipantDto.fromJson(json))
        .toList();
  }

  @override
  Future<List<PendingMembersDto>> getPendingMembers(String eventId) async {
    Response response =
        await client.dio.get('events/$eventId/me//joinRequest/pending');
    var participantsJson = response.data as List;
    return participantsJson
        .map<PendingMembersDto>((json) => PendingMembersDto.fromJson(json))
        .toList();
  }

  @override
  Future<void> updatePendingMembers(
      String eventId, String requestId, UpdateJoinStatusDto body) async {
    await client.dio.put(
      'events/$eventId/me//joinRequests/$requestId',
      data: body.toJson(),
    );
  }

  @override
  Future<void> changeMemberRole(
      String eventId, ChangeMembersRoleDto membersRole) {
    throw UnimplementedError();
  }

  @override
  Future<void> deleteMember(String eventId, String memberId) {
    throw UnimplementedError();
  }

  @override
  Future<List<EventSessionDto>> getSessions(String eventId) async {
    Response response = await client.dio.get('event/$eventId/sessions');
    var sessionsJson = response.data as List;
    return sessionsJson
        .map<EventSessionDto>((json) => EventSessionDto.fromJson(json))
        .toList();
  }

  @override
  Future<void> updateAttendance(
      String eventId, String sessionId, UpdateAttendanceDto attendances) async {
    await client.dio.patch(
        'events/$eventId/sessions/$sessionId/members/updateAttendances',
        data: attendances);
  }

  @override
  Future<InvitedEventDto> getEventFromReference(String id) async {
    Response response = await client.dio.get('inviteLink/$id');
    return InvitedEventDto.fromJson(response.data);
  }

  @override
  Future<void> joinPrivateEvent(String id, JoinFromInvitetDto body) async {
    Response response = await client.dio.post(
      'events/$id/me/JoinRequest',
      data: body.toJson(),
    );

    if (response.statusCode == 200) {
      //success
    } else {
      throw Exception('Failed to send join request');
    }
  }

  @override
  Future<void> joinPublicEvent(String id, JoinFromInvitetDto body) async {
    Response response = await client.dio.put(
      'events/$id/me/AddMemberToPublicEvent',
      data: body.toJson(),
    );

    if (response.statusCode == 200) {
      //success
    } else {
      throw Exception('Failed to join');
    }
  }

  @override
  Future<void> updateInviteLink(
      String eventId, UpdateInviteLinkDto body) async {
    Response response = await client.dio.put(
      'events/$eventId/InviteLink',
      data: body.toJson(),
    );

    if (response.statusCode == 200) {
      //success
    } else {
      throw Exception('Failed to edit invite link');
    }
  }
}
