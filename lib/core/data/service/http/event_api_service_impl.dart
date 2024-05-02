import 'package:dio/dio.dart';
import 'package:kidventory_flutter/core/data/model/add_member_dto.dart';
import 'package:kidventory_flutter/core/data/model/change_members_role_dto.dart';
import 'package:kidventory_flutter/core/data/model/create_event_dto.dart';
import 'package:kidventory_flutter/core/data/model/event_dto.dart';
import 'package:kidventory_flutter/core/data/model/participant_dto.dart';
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
    await client.dio.post('events/$eventId/members');
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
  Future<void> changeMemberRole(
      String eventId, ChangeMembersRoleDto membersRole) {
    throw UnimplementedError();
  }

  @override
  Future<void> deleteMember(String eventId, String memberId) {
    throw UnimplementedError();
  }

  @override
  Future<List<DateTime>> getSessions(String eventId) {
    throw UnimplementedError();
  }

  @override
  Future<EventDto> getEventFromReference(String id) async {
    Response response = await client.dio.get('inviteLink/$id');

    if (response.statusCode == 200) {
      return EventDto.fromJson(response.data);
    } else {
      throw Exception('Could not find an event associated with the link');
    }
  }
}
